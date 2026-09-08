// Sound board bench: replays MAME's T11-side events (tools/trace_sound.lua:
// sound commands, sound resets, response reads) at their logged times into
// the sound board, logs every YM2151 / POKEY / latch write the 6502 makes
// with its time, and records the mix at 48 kHz. tools/compare_sound.py holds
// the write sequences and the audio to MAME's.
//
//   Vtb_sound_top <ssprint.rom> <mame_log.txt> <seconds> <rtl_log.txt> <rtl.wav>
#include "Vtb_sound_top.h"
#include "verilated.h"
#include "img_layout.h"
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <vector>
#include <string>

static Vtb_sound_top *top;
static uint64_t cyc = 0;
static inline void tick() { top->clk = 0; top->eval(); top->clk = 1; top->eval(); cyc++; }
static const double CLK = 96e6;

struct Ev { double us; std::string tag; unsigned addr, data, mask; };

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    if (argc < 6) { fprintf(stderr, "usage: %s rom mame_log seconds rtl_log rtl.wav\n", argv[0]); return 2; }
    double seconds = atof(argv[3]);
    std::vector<uint8_t> rom; { FILE *f = fopen(argv[1], "rb"); if (!f) { perror(argv[1]); return 2; }
      uint8_t buf[65536]; size_t n; while ((n = fread(buf, 1, sizeof buf, f)) > 0) rom.insert(rom.end(), buf, buf + n); fclose(f); }
    std::vector<Ev> ev; { FILE *f = fopen(argv[2], "r"); if (!f) { perror(argv[2]); return 2; }
      char line[256]; while (fgets(line, sizeof line, f)) { char tag[16]; double us; unsigned a, d, m = 0xffff;
        int n = sscanf(line, "%lf %15s %x %x %x", &us, tag, &a, &d, &m);
        if (n >= 3 && !strcmp(tag, "FRAME")) { unsigned fr; if (sscanf(line, "%lf FRAME %u", &us, &fr) == 2) ev.push_back({us, tag, fr, 0, 0}); continue; }
        if (n >= 4) ev.push_back({us, tag, a, d, n >= 5 ? m : 0xffffu}); } fclose(f); }
    printf("rom %zu bytes, %zu events\n", rom.size(), ev.size());
    FILE *lf = fopen(argv[4], "w"); if (!lf) { perror(argv[4]); return 2; }

    top = new Vtb_sound_top;
    top->reset = 1; top->cpu_reset = 1; top->snd_reset_pulse = 0; top->cmd_wr = 0; top->cmd_data = 0; top->resp_rd = 0;
    top->coins = 0; top->test = 0; top->leta0 = 0; top->rom_we = 0; top->nv_we = 0;
    top->dsw0 = getenv("DSW0") ? strtol(getenv("DSW0"), nullptr, 16) : 0x00;   // MAME's defaults: Super Sprint 00 / c0
    top->dsw1 = getenv("DSW1") ? strtol(getenv("DSW1"), nullptr, 16) : 0xc0;
    top->cfg_tms = rom[7] & 1;   // the image header: a TMS5220 is fitted
    for (int i = 0; i < 8; i++) tick();
    // load the ROM and the EEPROM with the board still in reset, so that the
    // clock enables (the 244 Hz IRQ divider in particular) start at t0 as
    // MAME's timers do
    for (int i = 0; i < 0xc000; i++) { top->rom_we = 1; top->rom_waddr = i; top->rom_wdata = rom[IMG_SOUND + i]; tick(); }
    top->rom_we = 0;
    for (int i = 0; i < 0x200; i++) { top->nv_we = 1; top->nv_addr = i; top->nv_wdata = rom[IMG_EEPROM + i]; tick(); }
    top->nv_we = 0;
    top->reset = 0;
    // MAME: machine_reset holds the 6502 in reset until the T11 releases it
    // (first SRST write in the log); the log's time base starts at the
    // machine's, ours starts here
    uint64_t t0 = cyc;
    size_t ei = 0;
    std::vector<int16_t> wav; uint32_t acc = 0; const uint32_t INC = (uint32_t)(4294967296.0 * 48000.0 / CLK);
    long n_cmd = 0, n_resp = 0, n_rrd = 0;
    // the coin switch is on the 6502's port: press it over the frames the MAME
    // capture did (tools/trace_sound.lua COIN=frame, held 10 frames)
    int coin_frame = getenv("COIN_FRAME") ? atoi(getenv("COIN_FRAME")) : 600;
    // the steering counter jumps to WHEEL at WHEEL_FRAME (dumpstate.lua / trace_sound.lua: START+60)
    int wheel_frame = getenv("WHEEL_FRAME") ? atoi(getenv("WHEEL_FRAME")) : 760;
    int wheel_val = getenv("WHEEL") ? strtol(getenv("WHEEL"), nullptr, 0) : 0x30;
    uint64_t end_cyc = t0 + (uint64_t)(seconds * CLK);
    while (cyc < end_cyc) {
        double now_us = (cyc - t0) / CLK * 1e6;
        top->cmd_wr = 0; top->snd_reset_pulse = 0; top->resp_rd = 0;
        while (ei < ev.size() && ev[ei].us <= now_us) {
            const Ev &e = ev[ei++];
            // 8-bit registers on the even byte: a write covering only the odd byte is not a write to them
            if (e.tag == "CMD" && (e.mask & 0xff)) { top->cmd_wr = 1; top->cmd_data = e.data; n_cmd++; }
            else if (e.tag == "SRST" && (e.mask & 0xff)) { top->cpu_reset = e.data & 1; top->snd_reset_pulse = 1; }
            else if (e.tag == "RRD") { top->resp_rd = 1; n_rrd++; }
            else if (e.tag == "FRAME") {
                int fr = (int)e.addr;
                static int ncoins = getenv("COINS") ? atoi(getenv("COINS")) : 1;   // as tools/trace_sound.lua: COINS coins, 20 frames apart
                static int coin_bit = getenv("COIN_BIT") ? atoi(getenv("COIN_BIT")) : 0;   // coins[0] = IN1 bit 5 (Super Sprint's coin 1); APB and Championship Sprint have coin 1 on bit 6 (COIN_BIT=1)
                for (int k = 0; k < ncoins; k++) { if (fr == coin_frame + 20 * k) top->coins = 1 << coin_bit; if (fr == coin_frame + 20 * k + 10) top->coins = 0; }
                if (fr == wheel_frame) top->leta0 = wheel_val;
            }
        }
        tick();
        double t_us = (cyc - t0) / CLK * 1e6;
        if (top->dbg_ym_wr) fprintf(lf, "%.3f YM %04x %02x\n", t_us, 0x1850 + top->dbg_ym_a0, top->dbg_d);
        if (top->dbg_pk_wr) fprintf(lf, "%.3f %s %04x %02x\n", t_us, top->dbg_pk_sel ? "PK2" : "PK1", (top->dbg_pk_sel ? 0x1830 : 0x1800) + top->dbg_pk_reg, top->dbg_d);
        if (top->dbg_io_wr) {
            static const char *names[8] = {"TMS", "TMSS", "RESP", "COIN", "ACK", "MIX", "SW", "SEN"};
            fprintf(lf, "%.3f %s %04x %02x\n", t_us, names[top->dbg_io_reg], 0x1870 + top->dbg_io_reg * 2 + (top->dbg_io_reg == 1 ? top->dbg_io_a0 : 0), top->dbg_d);   // the strobe's address bit 0 is the /WS level
            if (top->dbg_io_reg == 2) n_resp++;
        }
        uint64_t na = (uint64_t)acc + INC; if (na >> 32) wav.push_back((int16_t)top->audio_l); acc = (uint32_t)na;
    }
    fclose(lf);
    // wav
    FILE *wf = fopen(argv[5], "wb");
    uint32_t datasz = wav.size() * 2, fmtsz = 16, rate = 48000, brate = rate * 2; uint16_t ch = 1, bits = 16, align = 2, pcm = 1;
    fwrite("RIFF", 1, 4, wf); uint32_t riffsz = 36 + datasz; fwrite(&riffsz, 4, 1, wf); fwrite("WAVE", 1, 4, wf);
    fwrite("fmt ", 1, 4, wf); fwrite(&fmtsz, 4, 1, wf); fwrite(&pcm, 2, 1, wf); fwrite(&ch, 2, 1, wf); fwrite(&rate, 4, 1, wf);
    fwrite(&brate, 4, 1, wf); fwrite(&align, 2, 1, wf); fwrite(&bits, 2, 1, wf); fwrite("data", 1, 4, wf); fwrite(&datasz, 4, 1, wf);
    fwrite(wav.data(), 2, wav.size(), wf); fclose(wf);
    printf("replayed %ld commands, %ld response reads; 6502 wrote %ld responses; %zu samples\n", n_cmd, n_rrd, n_resp, wav.size());
    return 0;
}
