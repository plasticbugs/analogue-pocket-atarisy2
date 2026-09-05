# RTL conventions for the Super Sprint core

Shared rules so the blocks fit together without a second pass. Read
`docs/hardware.md` first. These follow the S.T.U.N. Runner core's conventions.

## Language and tools

- SystemVerilog only (`.sv`), `default_nettype none`, one module per file,
  synthesisable with Quartus 18.1 **and** clean under
  `verilator --lint-only -Wall` (`sim/lint.sh`; waivers in `sim/waivers.vlt`,
  which must not contain comments -- Verilator's config parser stops at the
  first `//` line). The two vendored cores, T65 (GHDL-converted VHDL) and
  jt51, are waived by path.
- No `initial` blocks for logic, no latches, no asynchronous resets: a single
  synchronous active-high `reset` input per module.
- Block RAMs: 2D-packed byte lanes (`logic [1:0][7:0] mem [N]`) for
  byte-enable writes (METHODOLOGY 5.5). Register the read data (1-cycle
  latency) so Quartus infers M10K; `rtl/dpram_be.sv` (true dual port) and
  `rtl/sdpram.sv` (simple dual port) are the two shapes used.
- Verilator benches are C++ (`sim/tb_*.cpp`) driving a small SV wrapper
  (`sim/tb_*_top.sv`), run by a `sim/run_*.sh` script that prints PASS/FAIL
  and exits non-zero on failure. Every block ships with one.

## Clocks

One system clock, **`clk` = 96 MHz** (`core_pll` outclk_0), for everything
except the Pocket's video/audio output domains. Each machine part runs on a
clock-enable pulse from `rtl/clk_enables.sv`:

| enable | rate | derivation |
|---|---|---|
| `cen_pix` | 16.000 MHz | 96 / 6 -- the pixel clock; `clk_vid` (PLL outclk_1) is the same division |
| `cen_10m` | 10.000 MHz | phase accumulator -- T11 cycle budget |
| `cen_ym`  | 3.579545 MHz | phase accumulator -- YM2151; the 6502 and the POKEYs take every other pulse |
| `irq_tick` | 244.140625 Hz | 96e6 / 393216 exactly -- the sound board's timed IRQ |

A block must never gate `clk`; it samples its `cen`. The T11 is not
enable-stepped internally: `cen` only counts its per-instruction cycle
budget, the sequencer runs on every `clk` and bus accesses complete on any
clock. So nothing in it, in the video engines or in the POKEYs is
multicycled; `projects/ssprint_pocket.sdc` carries only the SDRAM and T65
exceptions, each with its argument.

## Bus and memory interfaces

**T11 bus** (`rtl/t11/t11.sv`): 16-bit, byte addressed, little-endian.
`bus_rd`/`bus_wr` are levels held until `bus_ack` (one-clock pulse, data
valid with it); address, byte enables (`bus_be[0]` = the even byte) and
write data are stable for the request. The main board answers block RAM
and I/O one clock after the request, the video RAMs three, SDRAM when it
acks. The slapstic sees the first clock of every request.

**Memory request interface** (SDRAM random clients), as in the S.T.U.N.
Runner core:

```systemverilog
output logic [24:1] m_addr;    // SDRAM word address
output logic        m_req;     // level: held high until m_ack
output logic        m_we;      // 1 = write
output logic [15:0] m_wdata;
output logic [1:0]  m_be;      // byte enables for writes ([0] = D7:0)
input  logic [15:0] m_rdata;   // valid on the cycle m_ack is high
input  logic        m_ack;     // one-cycle pulse
```

**Burst port**: `b_addr`, `b_len` (1..512 words), `b_req` level until
`b_done`; every word arrives as a `b_wr` pulse with `b_idx` and `b_data`.
The video's playfield engine (2-word rows) and motion object engine (4-word
rows) share it through a small arbiter in `ssprint_video`.

## SDRAM map (word addresses)

| range | content |
|---|---|
| 0x000000-0x03ffff | T11 banked program ROM, 64 x 8 KB as the image |
| 0x100000-0x13ffff | playfield tiles, `{code[13:0], row[2:0], half}` |
| 0x140000-0x15ffff | motion objects, `{code[10:0], row[3:0], half, w}`, bytes inverted |

`rtl/ssprint_pkg.sv` holds the constants and the image-offset-to-SDRAM
functions; `sim/tb_video.cpp` repeats the mapping in C++ and the whole-
machine bench loads through the real loader, which keeps the two honest.

## Video RAM port

`ssprint_video` owns the palette, alphanumerics, motion object and playfield
RAMs (true dual port, CPU on port A). The main board presents a word address,
one-hot selects and `cpu_we`/`cpu_be`/`cpu_wdata`; `cpu_rdata` is valid two
clocks later. Writes take effect on the clock they are presented (the main
board asserts `cpu_we` for one clock only).

## Sound board latches

The T11 side: `cmd_wr` + `cmd_data` (one clock), `resp_rd` (one clock),
`cpu_reset` level, `snd_reset_pulse`; the board reports `cmd_full`,
`resp_full`, `cmd_rd_pulse`, `resp_wr_pulse`, `resp_data`. Audio is signed
16-bit stereo recomputed on every `cen_ym`, with `audio_valid` strobing;
`core_top` samples it at 48 kHz and hands it to `clk_74b` with a toggle
flag (METHODOLOGY 5.4).
