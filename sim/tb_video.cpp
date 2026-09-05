// Frozen-state video bench driver: loads a MAME state (tools/dumpstate.lua)
// and the ROM image, runs three frames and writes the third as raw RGB
// (512x384x3) for tools/diff_frames.py.
//   Vtb_video_top <state.txt> <ssprint.rom> <out.rgb>
#include "Vtb_video_top.h"
#include "Vtb_video_top___024root.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <vector>

static Vtb_video_top *top;
static uint64_t cyc = 0;
static inline void tick() { top->clk = 0; top->eval(); top->clk = 1; top->eval(); cyc++; }

// the loader's SDRAM layout (rtl/ssprint_pkg.sv)
static const uint32_t SD_TILES = 0x100000, SD_SPRITES = 0x140000;
static uint32_t tiles_img_to_sd(uint32_t o)   { return SD_TILES + ((((o >> 4) & 0x3fff) << 4) | (((o >> 1) & 7) << 1) | ((o >> 18) & 1)); }
static uint32_t sprites_img_to_sd(uint32_t o) { return SD_SPRITES + ((((o >> 6) & 0x7ff) << 6) | (((o >> 2) & 15) << 2) | (((o >> 17) & 1) << 1) | ((o >> 1) & 1)); }

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    if (argc < 4) { fprintf(stderr, "usage: %s state.txt ssprint.rom out.rgb\n", argv[0]); return 2; }
    // state
    std::vector<uint16_t> pal, alpha, mob, pft, pfb; unsigned xs = 0, ys = 0;
    { FILE *f = fopen(argv[1], "r"); if (!f) { perror(argv[1]); return 2; }
      char line[64]; std::vector<uint16_t> *cur = nullptr;
      while (fgets(line, sizeof line, f)) {
          if (!strncmp(line, "XSCROLL", 7)) { xs = strtoul(line + 8, nullptr, 16); continue; }
          if (!strncmp(line, "YSCROLL_LINE", 12)) continue;
          if (!strncmp(line, "YSCROLL", 7)) { ys = strtoul(line + 8, nullptr, 16); continue; }
          if (!strncmp(line, "FRAME", 5)) continue;
          if (!strncmp(line, "PALETTE", 7)) { cur = &pal; continue; }
          if (!strncmp(line, "ALPHA", 5)) { cur = &alpha; continue; }
          if (!strncmp(line, "MOB", 3)) { cur = &mob; continue; }
          if (!strncmp(line, "PFT", 3)) { cur = &pft; continue; }
          if (!strncmp(line, "PFB", 3)) { cur = &pfb; continue; }
          if (cur && isxdigit((unsigned char)line[0])) cur->push_back(strtoul(line, nullptr, 16));
      }
      fclose(f); }
    printf("state: pal %zu alpha %zu mob %zu pft %zu pfb %zu xscroll %04x yscroll %04x\n", pal.size(), alpha.size(), mob.size(), pft.size(), pfb.size(), xs, ys);
    // rom
    std::vector<uint8_t> rom; { FILE *f = fopen(argv[2], "rb"); if (!f) { perror(argv[2]); return 2; }
      uint8_t buf[65536]; size_t n; while ((n = fread(buf, 1, sizeof buf, f)) > 0) rom.insert(rom.end(), buf, buf + n); fclose(f); }

    top = new Vtb_video_top;
    top->reset = 1; top->cen_pix = 0; top->cpu_we = 0; top->sel_pal = top->sel_alpha = top->sel_mob = top->sel_pft = top->sel_pfb = 0;
    top->xscroll_we = top->yscroll_we = 0; top->chr_we = 0;
    // graphics into the chip model, as the loader lays them out
    auto &mem = top->rootp->tb_video_top__DOT__chip__DOT__mem;
    for (uint32_t o = 0; o < 0x80000; o++) {
        uint32_t w = tiles_img_to_sd(o); uint8_t v = rom[0x90000 + o];
        if (o & 1) mem[w] = (mem[w] & 0x00ff) | (v << 8); else mem[w] = (mem[w] & 0xff00) | v;
    }
    for (uint32_t o = 0; o < 0x40000; o++) {
        uint32_t w = sprites_img_to_sd(o); uint8_t v = rom[0x110000 + o] ^ 0xff;
        if (o & 1) mem[w] = (mem[w] & 0x00ff) | (v << 8); else mem[w] = (mem[w] & 0xff00) | v;
    }
    for (int i = 0; i < 20; i++) tick();
    top->reset = 0;
    while (!top->sd_ready) tick();
    // hold the video in reset a little longer, then load through the CPU port
    for (int i = 0; i < 4; i++) tick();
    for (uint32_t i = 0; i < 0x4000; i++) { top->chr_we = 1; top->chr_waddr = i; top->chr_wdata = rom[0x150000 + i]; tick(); }
    top->chr_we = 0;
    auto load = [&](std::vector<uint16_t> &v, int which) {
        for (size_t i = 0; i < v.size(); i++) {
            top->cpu_addr = i; top->cpu_wdata = v[i]; top->cpu_we = 1;
            top->sel_pal = which == 0; top->sel_alpha = which == 1; top->sel_mob = which == 2; top->sel_pft = which == 3; top->sel_pfb = which == 4;
            tick();
        }
        top->cpu_we = 0; top->sel_pal = top->sel_alpha = top->sel_mob = top->sel_pft = top->sel_pfb = 0; tick();
    };
    load(pal, 0); load(alpha, 1); load(mob, 2); load(pft, 3); load(pfb, 4);
    top->scroll_wdata = xs; top->xscroll_we = 1; tick(); top->xscroll_we = 0;
    top->scroll_wdata = ys; top->yscroll_we = 1; tick(); top->yscroll_we = 0;

    // run: cen_pix every 6 clocks; capture the third frame on DE
    std::vector<uint8_t> fb(512 * 384 * 3, 0);
    int frames = 0, x = 0, y = -1, prev_vs = 0, prev_de = 0, div = 0;
    long pixels = 0;
    while (frames < 3 && cyc < 200000000ULL) {
        div = (div + 1) % 6; top->cen_pix = (div == 0);
        tick();
        if (top->cen_out) {
            if (top->vsync && !prev_vs) { frames++; y = -1; }
            if (top->de && !prev_de) { y++; x = 0; }
            if (top->de && frames == 2 && y >= 0 && y < 384 && x < 512) {
                size_t o = (size_t(y) * 512 + x) * 3; fb[o] = top->r; fb[o + 1] = top->g; fb[o + 2] = top->b; pixels++;
            }
            if (top->de) x++;
            prev_vs = top->vsync; prev_de = top->de;
        }
    }
    FILE *o = fopen(argv[3], "wb"); fwrite(fb.data(), 1, fb.size(), o); fclose(o);
    printf("frames %d, %ld pixels captured, cycles %llu, line_late %d, model errors %u\n", frames, pixels, (unsigned long long)cyc, top->line_late, top->model_errors);
    return (frames >= 3 && !top->model_errors && !top->line_late) ? 0 : 1;
}
