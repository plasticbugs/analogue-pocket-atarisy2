// T11 core bench: run the core from reset on the real ROM image and compare
// its register state before every instruction with a MAME trace
// (tools/trace_t11.lua): R0-R5, SP, PSW and PC. I/O reads are replayed from
// the trace's read log so the bench sees exactly MAME's inputs; interrupts
// MAME took are replayed at the same instruction boundary by driving CP.
//
//   Vtb_t11_top <ssprint.rom> <trace.txt> <trace_io.txt> [max_instructions] [state.txt]
//
// A state file (tools/dumpstate.lua) or a register line is needed to start
// from a window that is not the reset; the boot window starts from reset.
#include "Vtb_t11_top.h"
#include "Vtb_t11_top___024root.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <vector>
#include <string>
#include <deque>
#include <map>
#include <algorithm>

static Vtb_t11_top *top;
static uint64_t cyc = 0;
static inline void tick() { top->clk = 0; top->eval(); top->clk = 1; top->eval(); cyc++; }

struct TraceLine { uint16_t r[8]; uint8_t psw; uint16_t pc; std::string dis; int irq; long cyc; };

static std::vector<TraceLine> load_trace(const char *path) {
    std::vector<TraceLine> out;
    FILE *f = fopen(path, "r"); if (!f) { perror(path); exit(2); }
    char line[512]; int pending_irq = 0;
    while (fgets(line, sizeof line, f)) {
        TraceLine t; unsigned r0, r1, r2, r3, r4, r5, sp, psw, pc, at, code;
        // MAME logs "(interrupted at PC, IRQ n)" between the instruction after
        // which it took the interrupt and the handler's first instruction
        if (sscanf(line, " (interrupted at %o, IRQ %u)", &at, &code) == 2) { pending_irq = code; continue; }
        long cy = -1;   // MAME's totalcycles before the instruction (traces without CYC= still load)
        if (sscanf(line, "R0=%x R1=%x R2=%x R3=%x R4=%x R5=%x SP=%x PSW=%x CYC=%ld %o:", &r0, &r1, &r2, &r3, &r4, &r5, &sp, &psw, &cy, &pc) != 10 &&
            sscanf(line, "R0=%x R1=%x R2=%x R3=%x R4=%x R5=%x SP=%x PSW=%x %o:", &r0, &r1, &r2, &r3, &r4, &r5, &sp, &psw, &pc) != 9) continue;
        t.irq = pending_irq; pending_irq = 0; t.cyc = cy;
        t.r[0] = r0; t.r[1] = r1; t.r[2] = r2; t.r[3] = r3; t.r[4] = r4; t.r[5] = r5; t.r[6] = sp; t.r[7] = pc; t.psw = psw; t.pc = pc;
        const char *colon = strchr(line, ':'); t.dis = colon ? std::string(colon + 1) : ""; while (!t.dis.empty() && (t.dis.back() == '\n' || t.dis.back() == '\r')) t.dis.pop_back();
        out.push_back(t);
    }
    fclose(f);
    return out;
}

struct IoRead { uint16_t addr, data, pc; };
static std::vector<IoRead> load_io(const char *path) {
    std::vector<IoRead> out; FILE *f = fopen(path, "r"); if (!f) { perror(path); exit(2); }
    unsigned a, d, p; while (fscanf(f, "%x %x %x", &a, &d, &p) == 3) out.push_back({(uint16_t)a, (uint16_t)d, (uint16_t)p});
    fclose(f); return out;
}

static void regs_now(uint16_t r[8], uint8_t &psw) {
    for (int i = 0; i < 8; i++) r[i] = top->rootp->tb_t11_top__DOT__cpu__DOT__r[i];
    psw = top->rootp->tb_t11_top__DOT__cpu__DOT__psw;
}

static bool same(const TraceLine &t, const uint16_t r[8], uint8_t psw, int *which) {
    for (int i = 0; i < 8; i++) if (r[i] != t.r[i]) { *which = i; return false; }
    if (psw != t.psw) { *which = 8; return false; }
    return true;
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    if (argc < 4) { fprintf(stderr, "usage: %s rom trace trace_io [max] [state.txt]\n", argv[0]); return 2; }
    long maxi = argc > 4 ? atol(argv[4]) : 100000000L;
    const char *state_path = argc > 5 ? argv[5] : nullptr;
    bool have_regs = false; unsigned sr[8], spsw = 0;
    FILE *rf = fopen(argv[1], "rb"); if (!rf) { perror(argv[1]); return 2; }
    std::vector<uint8_t> rom; { uint8_t buf[65536]; size_t n; while ((n = fread(buf, 1, sizeof buf, rf)) > 0) rom.insert(rom.end(), buf, buf + n); } fclose(rf);
    std::vector<TraceLine> trace = load_trace(argv[2]);
    std::vector<IoRead> io = load_io(argv[3]);
    printf("rom %zu bytes, trace %zu instructions, %zu io reads\n", rom.size(), trace.size(), io.size());
    if (trace.empty()) return 2;

    top = new Vtb_t11_top;
    // ROM image layout (docs/hardware.md section 9)
    for (int i = 0; i < 16384; i++) top->rootp->tb_t11_top__DOT__rom[i] = rom[i * 2] | (rom[i * 2 + 1] << 8);
    for (int i = 0; i < 262144; i++) top->rootp->tb_t11_top__DOT__bankrom[i] = rom[0x8000 + i * 2] | (rom[0x8000 + i * 2 + 1] << 8);
    // optional frozen state for a non-reset window
    if (state_path) {
        FILE *sf = fopen(state_path, "r"); if (!sf) { perror(state_path); return 2; }
        char line[64]; int sec = 0, idx = 0;
        while (fgets(line, sizeof line, sf)) {
            if (!strncmp(line, "PALETTE", 7)) { sec = 1; idx = 0; continue; }
            if (!strncmp(line, "ALPHA", 5)) { sec = 2; idx = 0; continue; }
            if (!strncmp(line, "MOB", 3)) { sec = 3; idx = 0; continue; }
            if (!strncmp(line, "PFT", 3)) { sec = 4; idx = 0; continue; }
            if (!strncmp(line, "PFB", 3)) { sec = 5; idx = 0; continue; }
            if (!strncmp(line, "RAM", 3)) { sec = 6; idx = 0; continue; }
            if (!strncmp(line, "BANK", 4)) { unsigned b1, b2; if (sscanf(line, "BANK %x %x", &b1, &b2) == 2) { top->init_bank1 = b1; top->init_bank2 = b2; } continue; }
            if (!strncmp(line, "SLAP", 4)) { unsigned b; if (sscanf(line, "SLAP %u", &b) == 1) top->init_slap = b; continue; }
            if (!strncmp(line, "REGS", 4)) { if (sscanf(line, "REGS %x %x %x %x %x %x %x %x %x", &sr[0], &sr[1], &sr[2], &sr[3], &sr[4], &sr[5], &sr[6], &sr[7], &spsw) == 9) have_regs = true; continue; }
            if (line[0] < '0' || sec == 0) continue;
            unsigned v = strtoul(line, nullptr, 16);
            switch (sec) {
                case 1: if (idx < 256) top->rootp->tb_t11_top__DOT__pal[idx++] = v; break;
                case 2: if (idx < 3072) top->rootp->tb_t11_top__DOT__alpha[idx++] = v; break;
                case 3: if (idx < 1024) top->rootp->tb_t11_top__DOT__mob[idx++] = v; break;
                case 4: if (idx < 4096) top->rootp->tb_t11_top__DOT__pft[idx++] = v; break;
                case 5: if (idx < 4096) top->rootp->tb_t11_top__DOT__pfb[idx++] = v; break;
                case 6: if (idx < 2048) top->rootp->tb_t11_top__DOT__ram[idx++] = v; break;
            }
        }
        fclose(sf);
    }

    top->reset = 1; top->cen = 0; top->cp = 0; top->io_rdata = 0xffff; top->init_en = 0;
    for (int i = 0; i < 4; i++) tick();
    top->reset = 0;
    bool entry_first = false;
    if (state_path) {
        top->init_en = 1; tick(); top->init_en = 0;
        if (have_regs) {
            // the dumped registers are the state before the first traced
            // instruction; if that is an interrupt entry, start the core at the
            // instruction boundary (S_PAD with the budget spent) with CP driven
            for (int i = 0; i < 8; i++) top->rootp->tb_t11_top__DOT__cpu__DOT__r[i] = sr[i];
            top->rootp->tb_t11_top__DOT__cpu__DOT__psw = spsw;
            if (trace[0].irq) {
                top->rootp->tb_t11_top__DOT__cpu__DOT__state = 17;   // S_PAD
                top->rootp->tb_t11_top__DOT__cpu__DOT__cyc = 0xff;
                top->rootp->tb_t11_top__DOT__cpu__DOT__budget = 0;
                top->cp = trace[0].irq; entry_first = true;
            }
        } else {
            for (int i = 0; i < 8; i++) top->rootp->tb_t11_top__DOT__cpu__DOT__r[i] = trace[0].r[i];
            top->rootp->tb_t11_top__DOT__cpu__DOT__psw = trace[0].psw;
        }
        top->eval();
    }

    size_t k = 0;                 // next trace line to match
    size_t ioi = 0;               // next io read to replay
    long steps = 0; int div = 0;
    std::deque<std::string> hist;
    bool irq_armed = false; size_t irq_line = 0;
    uint64_t t0 = cyc;
    // start state check against line 0 (unless the window opens on an interrupt entry,
    // whose result is line 0 and is compared after the core performs it)
    if (entry_first) { k = 0; irq_armed = true; irq_line = 0; }
    else { uint16_t r[8]; uint8_t psw; regs_now(r, psw); int w;
      if (!same(trace[0], r, psw, &w)) { printf("start state differs from trace line 0 (field %d)\n", w); }
      k = 1; }
    long mismatches = 0;
    // cycle accounting: the core's cen ticks at every matched trace line, against MAME's CYC
    long cens = 0; std::vector<long> rtl_cyc(trace.size(), -1); rtl_cyc[0] = 0;
    while (k < trace.size() && (long)k < maxi) {
        // arm the interrupt MAME took after the instruction about to run (trace[k-1]):
        // CP is held at MAME's code from that instruction's fetch until the core enters the handler
        if (!irq_armed && top->rootp->tb_t11_top__DOT__cpu__DOT__state == 1 /* S_FETCH */ && !top->rootp->tb_t11_top__DOT__bus_rd) {
            if (trace[k].irq) { top->cp = trace[k].irq; irq_armed = true; irq_line = k; }
        }
        div = (div + 1) % 10; top->cen = (div == 0) ? 1 : 0;   // 96/10 ~ close enough for pacing; the core's rate is budget-driven
        // io replay: value presented while the read is pending
        if (top->io_rd) {
            if (ioi < io.size()) {
                if (io[ioi].addr != (top->io_addr & 0xfffe) && io[ioi].addr != top->io_addr) {
                    printf("io read address mismatch at trace line %zu: rtl %04x, log %04x (log pc %04x)\n", k, top->io_addr, io[ioi].addr, io[ioi].pc);
                    mismatches++;
                }
                top->io_rdata = io[ioi].data;
            } else top->io_rdata = 0xffff;
        }
        // optional watch on a memory word: every write to it, with the trace position
        static long watch = getenv("TB_WATCH") ? strtol(getenv("TB_WATCH"), nullptr, 16) : -1;
        static int wr_seen = 0;
        if (watch >= 0 && top->bus_wr_o && (top->bus_addr_o & 0xfffe) == (watch & 0xfffe)) {
            if (!wr_seen) printf("   write %04x <- %04x (be %d) at trace line %zu, pc %04x\n", top->bus_addr_o, top->rootp->tb_t11_top__DOT__bus_wdata, top->rootp->tb_t11_top__DOT__bus_be, k, top->dbg_pc);
            wr_seen = 1;
        } else wr_seen = 0;
        tick();
        if (top->cen) cens++;
        if (top->io_ack) ioi++;
        if (top->dbg_done) {
            steps++;
            uint16_t r[8]; uint8_t psw; regs_now(r, psw); int w;
            if (irq_armed) {
                // the first dbg_done after arming is the instruction itself; its
                // successor is the interrupt entry, which must match trace[irq_line]
                static int phase = 0;
                // (an entry-first window: the S_PAD exit pulses dbg_done before the entry, same shape)
                if (phase == 0) { phase = 1; continue; }
                phase = 0; irq_armed = false; entry_first = false; top->cp = 0;
            }
            const TraceLine &t = trace[k];
            char buf[160]; snprintf(buf, sizeof buf, "%06o(%04x): %s", t.pc, t.pc, t.dis.c_str());
            hist.push_back(buf); if (hist.size() > 12) hist.pop_front();
            if (!same(t, r, psw, &w)) {
                static const char *names[9] = {"R0", "R1", "R2", "R3", "R4", "R5", "SP", "PC", "PSW"};
                printf("MISMATCH at trace line %zu (instruction %ld) in %s: rtl ", k, steps, names[w]);
                printf("R0=%04x R1=%04x R2=%04x R3=%04x R4=%04x R5=%04x SP=%04x PC=%04x PSW=%02x\n", r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], psw);
                printf("                                          mame R0=%04x R1=%04x R2=%04x R3=%04x R4=%04x R5=%04x SP=%04x PC=%04x PSW=%02x\n",
                       t.r[0], t.r[1], t.r[2], t.r[3], t.r[4], t.r[5], t.r[6], t.r[7], t.psw);
                printf("recent instructions (mame):\n"); for (auto &h : hist) printf("   %s\n", h.c_str());
                mismatches++;
                if (mismatches > 3) break;
                // resynchronise from MAME's state so later bugs can still be seen
                for (int i = 0; i < 8; i++) top->rootp->tb_t11_top__DOT__cpu__DOT__r[i] = t.r[i];
                top->rootp->tb_t11_top__DOT__cpu__DOT__psw = t.psw;
            }
            rtl_cyc[k] = cens;
            k++;
        }
        if (cyc - t0 > 4000000000ULL) { printf("timeout\n"); break; }
    }
    // cycle costs: trace line j's CYC delta to line j+1 is instruction j's cost (plus 114 for an
    // interrupt entry MAME took after it); the core's is its cen count between the two matches
    if (trace[0].cyc >= 0 && k > 1) {
        long tm = 0, tr = 0, shown = 0; std::map<std::string, std::pair<long, long>> by_op;
        for (size_t j = 1; j < k; j++) {
            if (trace[j].cyc < 0 || trace[j - 1].cyc < 0 || rtl_cyc[j] < 0 || rtl_cyc[j - 1] < 0) continue;
            long m = trace[j].cyc - trace[j - 1].cyc, r = rtl_cyc[j] - rtl_cyc[j - 1];
            tm += m; tr += r;
            std::string op = trace[j - 1].dis.substr(0, trace[j - 1].dis.find_first_of(" \t"));
            if (trace[j].irq) op += "+IRQ";
            auto &e = by_op[op]; e.first++; e.second += r - m;
            if (r != m && shown < 20) { shown++; printf("   cycles differ at line %zu: mame %ld rtl %ld  %06o(%04x): %s%s\n", j - 1, m, r, trace[j - 1].pc, trace[j - 1].pc, trace[j - 1].dis.c_str(), trace[j].irq ? "  (+interrupt entry)" : ""); }
        }
        printf("CYCLES: mame %ld, rtl %ld (%+.3f %%)\n", tm, tr, tm ? 100.0 * (tr - tm) / tm : 0.0);
        std::vector<std::pair<std::string, std::pair<long, long>>> v(by_op.begin(), by_op.end());
        std::sort(v.begin(), v.end(), [](auto &a, auto &b) { return labs(a.second.second) > labs(b.second.second); });
        for (size_t i = 0; i < v.size() && i < 24; i++) if (v[i].second.second) printf("   %-10s %8ld x, rtl-mame %+ld cycles (%+.2f per instruction)\n", v[i].first.c_str(), v[i].second.first, v[i].second.second, (double)v[i].second.second / v[i].second.first);
    }
    double secs = (cyc - t0) / 96e6;
    printf("matched %zu of %zu trace lines, %ld instructions, %zu of %zu io reads consumed, %.4f s simulated at 10 MHz pacing, %ld mismatches\n",
           k, trace.size(), steps, ioi, io.size(), secs, mismatches);
    printf("%s\n", (mismatches == 0 && k >= trace.size()) ? "PASS" : "FAIL");
    return (mismatches == 0 && k >= trace.size()) ? 0 : 1;
}
