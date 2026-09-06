// Whole-machine bench: loads ssprint.rom through the loader port, runs the
// machine for N frames, writes every Kth frame as a PNG (artifacts/sim/),
// logs the T11 PC at every frame and every sound command, so the boot can be
// lined up with MAME's (tools/smoke.lua) and frames diffed against snapshots.
//
//   Vtb_system_top <ssprint.rom> <frames> [snap_every] [coin_frame] [start_frame] [pedal_frame]
#include "Vtb_system_top.h"
#include "Vtb_system_top___024root.h"
#include "verilated.h"
#include "img_layout.h"
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <vector>
#include <string>
#include <zlib.h>

static Vtb_system_top *top;
static uint64_t cyc = 0;
static inline void tick() { top->clk = 0; top->eval(); top->clk = 1; top->eval(); cyc++; }

static void write_png(const char *path, const std::vector<uint8_t> &rgb, int w, int h) {
    std::vector<uint8_t> raw; raw.reserve((w * 3 + 1) * h);
    for (int y = 0; y < h; y++) { raw.push_back(0); raw.insert(raw.end(), rgb.begin() + y * w * 3, rgb.begin() + (y + 1) * w * 3); }
    uLongf clen = compressBound(raw.size()); std::vector<uint8_t> comp(clen);
    compress2(comp.data(), &clen, raw.data(), raw.size(), 6);
    FILE *f = fopen(path, "wb"); if (!f) return;
    auto be32 = [&](uint32_t v) { uint8_t b[4] = {uint8_t(v >> 24), uint8_t(v >> 16), uint8_t(v >> 8), uint8_t(v)}; fwrite(b, 1, 4, f); };
    auto chunk = [&](const char *t, const uint8_t *d, uint32_t n) {
        be32(n); fwrite(t, 1, 4, f); if (n) fwrite(d, 1, n, f);
        uint32_t c = crc32(0, (const Bytef *)t, 4); if (n) c = crc32(c, d, n); be32(c);
    };
    const uint8_t sig[8] = {0x89, 'P', 'N', 'G', 13, 10, 26, 10}; fwrite(sig, 1, 8, f);
    uint8_t ihdr[13] = {uint8_t(w >> 24), uint8_t(w >> 16), uint8_t(w >> 8), uint8_t(w), uint8_t(h >> 24), uint8_t(h >> 16), uint8_t(h >> 8), uint8_t(h), 8, 2, 0, 0, 0};
    chunk("IHDR", ihdr, 13); chunk("IDAT", comp.data(), clen); chunk("IEND", nullptr, 0);
    fclose(f);
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    if (argc < 3) { fprintf(stderr, "usage: %s ssprint.rom frames [snap_every] [coin_frame] [start_frame] [pedal_frame]\n", argv[0]); return 2; }
    int frames = atoi(argv[2]);
    int snap_every = argc > 3 ? atoi(argv[3]) : 60;
    int coin_frame = argc > 4 ? atoi(argv[4]) : -1;
    int start_frame = argc > 5 ? atoi(argv[5]) : -1;
    int pedal_frame = argc > 6 ? atoi(argv[6]) : -1;
    FILE *rf = fopen(argv[1], "rb"); if (!rf) { perror(argv[1]); return 2; }
    std::vector<uint8_t> rom; { uint8_t buf[65536]; size_t n; while ((n = fread(buf, 1, sizeof buf, rf)) > 0) rom.insert(rom.end(), buf, buf + n); }
    fclose(rf);
    printf("rom %zu bytes\n", rom.size());

    top = new Vtb_system_top;
    top->hw_reset = 1; top->reset = 1; top->dl_active = 0; top->dl_we = 0; top->nv_we = 0; top->nv_addr = 0; top->nv_wdata = 0;
    top->coin = 0; top->start = 0; top->btn3 = 0; top->service = 0;
    int ncoins = getenv("COINS") ? atoi(getenv("COINS")) : 1;   // coins 20 frames apart from coin_frame (as the MAME scripts)
    int nstarts = getenv("STARTS") ? atoi(getenv("STARTS")) : 1; // start presses 60 frames apart (APB: the siren, on btn3)
    top->pedal0 = top->pedal1 = top->pedal2 = 0xff; top->wheel0 = top->wheel1 = top->wheel2 = 0;
    top->dsw0 = getenv("DSW0") ? strtol(getenv("DSW0"), nullptr, 16) : 0x00;   // MAME's defaults: Super Sprint 00 / c0, APB 00 / 00
    top->dsw1 = getenv("DSW1") ? strtol(getenv("DSW1"), nullptr, 16) : 0xc0;
    for (int i = 0; i < 20; i++) tick();
    top->hw_reset = 0;
    while (!(top->dbg_flags & 0x80)) tick();
    printf("sdram ready at %llu\n", (unsigned long long)cyc);

    // download: one byte every 8 clocks, like the APF at its fastest
    top->dl_active = 1;
    for (size_t i = 0; i < rom.size(); i++) {
        top->dl_addr = i; top->dl_data = rom[i]; top->dl_we = 1; tick(); tick();
        top->dl_we = 0; for (int k = 0; k < 6; k++) tick();
    }
    for (int k = 0; k < 2000; k++) tick();
    top->dl_active = 0;
    top->reset = 0;
    printf("download done at %llu cycles\n", (unsigned long long)cyc);
    if (getenv("TB_SDCHK")) {
        // the banked ROM must be in SDRAM exactly as the image
        int bad = 0;
        for (uint32_t i = 0; i < 0x40000; i++) {
            uint16_t got = top->rootp->tb_system_top__DOT__chip__DOT__mem[i];
            uint16_t want = rom[IMG_MAIN_BANK + i * 2] | (rom[IMG_MAIN_BANK + i * 2 + 1] << 8);
            if (got != want) { if (bad < 5) printf("sdram[%05x] = %04x want %04x\n", i, got, want); bad++; }
        }
        printf("banked ROM in SDRAM: %d bad words of 262144\n", bad);
    }

    std::vector<uint8_t> fb(512 * 384 * 3, 0);
    int frame = 0, x = 0, y = -1, prev_vs = 0, prev_de = 0;
    long cmds = 0, t11_instr = 0, resps = 0, s_irqs = 0; uint16_t last_pc = 0;
    uint64_t frame_start = cyc;
    long audio_n = 0; int64_t audio_sum = 0; int16_t audio_max = 0;
    // TB_EVLOG=<frame>: from that frame on, log every T11 interrupt entry (code, interrupted PC),
    // sound command and 6502 response with its time and raster position, in the format of
    // tools/wipe_events.py (MAME's side), to compare the two machines' timelines
    static int ev_from = getenv("TB_EVLOG") ? atoi(getenv("TB_EVLOG")) : -1;
    int prev_state = 0; uint64_t t_run = cyc;
    while (frame < frames) {
        tick();
        {
            int st = top->rootp->tb_system_top__DOT__core__DOT__main__DOT__cpu__DOT__state;
            if (ev_from >= 0 && frame >= ev_from) {
                double t_us = (cyc - t_run) / 96.0;
                double l = top->rootp->tb_system_top__DOT__core__DOT__video__DOT__vcnt + top->rootp->tb_system_top__DOT__core__DOT__video__DOT__hcnt / 640.0;
                if (st == 13 && (prev_state == 17 || prev_state == 18))   // S_INT_PUSH1 from S_PAD / S_WAIT
                    printf("EV %12.1f f=%4d l=%6.1f IRQ  %02x pc=%04x\n", t_us + 11.4, frame, l, top->rootp->tb_system_top__DOT__core__DOT__main__DOT__cp, top->rootp->tb_system_top__DOT__core__DOT__main__DOT__cpu__DOT__r[7]);
                if (top->dbg_snd_cmd_wr) printf("EV %12.1f f=%4d l=%6.1f CMD  %02x\n", t_us, frame, l, top->dbg_snd_cmd);
                if (top->rootp->tb_system_top__DOT__core__DOT__snd_resp_wr) printf("EV %12.1f f=%4d l=%6.1f RESP --\n", t_us, frame, l);
                if (top->rootp->tb_system_top__DOT__core__DOT__snd_resp_rd) printf("EV %12.1f f=%4d l=%6.1f RRD  --\n", t_us, frame, l);
                if (top->rootp->tb_system_top__DOT__core__DOT__main__DOT__dbg_adc_st) printf("EV %12.1f f=%4d l=%6.1f ADCS %02x\n", t_us, frame, l, top->rootp->tb_system_top__DOT__core__DOT__main__DOT__adc_chan);
                if (top->rootp->tb_system_top__DOT__core__DOT__main__DOT__dbg_adc_rd) printf("EV %12.1f f=%4d l=%6.1f ADCR %02x cnt=%d\n", t_us, frame, l, top->rootp->tb_system_top__DOT__core__DOT__main__DOT__adc_sar, top->rootp->tb_system_top__DOT__core__DOT__main__DOT__adc_cnt);
            }
            prev_state = st;
        }
        if (top->dbg_t11_done) { t11_instr++; last_pc = top->dbg_t11_pc; }
        if (top->dbg_snd_cmd_wr) { cmds++; if (getenv("TB_CMDLOG")) printf("frame %d cmd %02x\n", frame, top->dbg_snd_cmd); }
        if (top->rootp->tb_system_top__DOT__core__DOT__snd_resp_wr) resps++;
        if (top->rootp->tb_system_top__DOT__core__DOT__irq_tick) s_irqs++;
        if (top->audio_valid) { audio_n++; audio_sum += (int16_t)top->audio_l; if ((int16_t)top->audio_l > audio_max) audio_max = (int16_t)top->audio_l; }
        if (top->cen_pix) {
            if (top->vsync && !prev_vs) {
                if (frame > 0 && snap_every > 0 && (frame % snap_every) == 0) {
                    char name[128]; snprintf(name, sizeof name, "../artifacts/sim/frame_%04d.png", frame);
                    write_png(name, fb, 512, 384);
                }
                printf("frame %4d: t11 pc %04x, %ld instr, %ld cmds, %ld resps, %ld snd irqs, flags %02x, 6502 at %04x, audio max %d, %llu cycles/frame\n",
                       frame, last_pc, t11_instr, cmds, resps, s_irqs, top->dbg_flags, top->dbg_6502_addr, audio_max, (unsigned long long)(cyc - frame_start));
                frame_start = cyc; frame++; y = -1; audio_max = 0;
                for (int k = 0; k < ncoins; k++) { if (frame == coin_frame + 20 * k) top->coin = 1; if (frame == coin_frame + 20 * k + 10) top->coin = 0; }
                for (int k = 0; k < nstarts; k++) { if (frame == start_frame + 60 * k) { top->start = 1; top->btn3 = 1; } if (frame == start_frame + 60 * k + 10) { top->start = 0; top->btn3 = 0; } }
                static int pedal_val = getenv("PEDAL_VAL") ? strtol(getenv("PEDAL_VAL"), nullptr, 0) : 0x3f;   // 0x3f matches the existing MAME captures (PEDAL=63); a real floored pedal is 0xc0
                if (frame == pedal_frame) { top->pedal0 = pedal_val; top->pedal1 = pedal_val; top->wheel0 = 0x30; }   // as tools/dumpstate.lua's PEDAL/WHEEL (APB's pedal is channel 1)
                static int pedal_off = getenv("PEDAL_OFF") ? atoi(getenv("PEDAL_OFF")) : -1;
                if (frame == pedal_off) { top->pedal0 = 0xff; top->pedal1 = 0xff; }
            }
            if (top->de && !prev_de) { y++; x = 0; }
            if (top->de && y >= 0 && y < 384 && x < 512) {
                size_t o = (size_t(y) * 512 + x) * 3; fb[o] = top->r; fb[o + 1] = top->g; fb[o + 2] = top->b;
            }
            if (top->de) x++;
            prev_vs = top->vsync; prev_de = top->de;
        }
        if (cyc > 96000000ULL * 200) { printf("timeout\n"); break; }
    }
    printf("done: %d frames, model errors %u\n", frame, top->model_errors);
    return top->model_errors ? 1 : 0;
}
