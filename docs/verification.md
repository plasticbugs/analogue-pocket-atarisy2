# Verification status

What has been checked against MAME, how, and with what result. Every entry is
reproducible with the script named. An entry that is not here has not been
verified.

| Block | Bench | Oracle | Result (2026-09-04) |
|---|---|---|---|
| ROM image (`tools/mra_build.py`, `ssprint.mra`) | `tools/check_rom.lua` | MAME's loaded memory regions | byte-identical: all seven regions (maincpu 0x8000 + 0x80000, audiocpu, tiles, sprites (inverted), chars, eeprom), 0 mismatches |
| Reference frame renderer (`tools/render_model.py`) | `tools/capture_states.sh` | MAME snapshot PNG at the same frame | pixel-identical on 5 of 9 states (title 400, track 700, play 1100/1400/1800: 0 of 196,608 pixels differ); the other 4 differ in 700-1900 pixels that are all cars, because the game writes motion object RAM during the visible frame (lines 35-227) and MAME renders in 64-line bands while the dump is the end-of-frame state -- they are excluded from the gate, not explained away |
| T-11 CPU core (`rtl/t11/t11.sv`) + slapstic + bank select | `sim/run_t11.sh boot` | MAME debugger trace from reset (R0-R5, SP, PSW, PC per instruction), every I/O read replayed from a tap log | PASS: 29,956 of 29,956 instructions match (RAM tests, latch setup); 7 of 7 I/O reads consumed; simulated 0.052 s for MAME's 0.050 s |
| | `sim/run_t11.sh play` | the same over 2 gameplay frames from a dumped state, interrupts replayed at MAME's boundaries | PASS: 16,391 of 16,391 instructions, 20 interrupts (IRQ 1, 4, 12 = sound response, 32V, VBLANK+32V), 192 I/O reads |
| | `sim/run_t11.sh long` | 40 gameplay frames | PASS: 328,264 of 328,264 instructions, 3,896 I/O reads, 0 mismatches; 0.693 s simulated for 0.666 s of MAME (the bench's 9.6 MHz enable; the core's budget is MAME's cycle table) |
| Video (`rtl/ssprint_video.sv` + `sdram_ctrl`) | `sim/run_video.sh` | reference renderer / MAME PNG on frozen states | PASS: pixel-identical on all 5 gate states (0 differing pixels each), no line-render overrun (`line_late`), 0 SDRAM model errors |
| Sound board (`rtl/ssprint_sound.sv`, `pokey.sv`, T65, jt51) | `sim/run_sound.sh 15` | MAME command/response/reset log replayed at its times; the 6502's YM2151 / POKEY / latch writes compared in order; `-wavwrite` envelope | see "Sound board" below |
| Whole machine (`rtl/ssprint_core.sv`) | `sim/run_system.sh 460 50` | MAME boot timeline (per-frame PC, sound commands) and snapshots every 50 frames | see "Whole machine" below |
| Synthesis (Quartus 18.1, 5CEBA4) | `./build-local.sh map` | -- | Analysis & Synthesis: 0 errors; 23,075 logic cells, 687 RAM segments, 10 DSP blocks after synthesis (before fitting) |
| Hardware (Pocket) | -- | -- | not yet run |

## Lessons recorded on the way

- **MAME numbers plane 0 as the MOST significant pen bit.** `decode_tile`
  does `pen |= bit << (planes - 1 - plane)`; with the intuitive order every
  textured tile decoded wrong while flat backgrounds and the (pen 3 only)
  text looked right, so the first diff counts were 120-180k pixels with a
  plausible-looking screen. Found by searching the ROM for the bitplane bytes
  MAME's rendered tile implied (`tools/render_model.py` history).
- **The game writes the sound command as `MOVB` to 1680 then `CLRB` to
  1681.** The 8-bit latch sits on the even byte, so the odd-byte write is
  not a write to it; the main board originally took every write in the
  register's mirror range and the 6502 received 0x00 instead of 0x0d, never
  answered, and the boot sat in a 170-frame timeout before the title. The
  sound bench found it (the 6502's response writes: MAME 1484, RTL 1). All
  the 8-bit main-board registers are now gated on byte-lane 0, and the trace
  logs carry the byte mask so the benches replay only real writes.
- **MAME Lua taps must be held in a global table** (the S.T.U.N. Runner
  lesson, hit again): held in locals they were collected after ~160 events
  and the scroll register "changed" without any write being seen. And the
  scroll values a tap reports are not to be trusted over the memory share.
- **A T11 trace window that starts at `frame_done` starts on an interrupt
  entry** (the 32V interrupt fires at line 0, right after MAME's line-415
  `frame_done`), so the dumped RAM predates the push the handler's RTI pops.
  `tools/trace_t11.lua` records the registers at the dump and the bench
  performs the entry itself.
- **Latch the ALU result before updating the flags** when the write-back is a
  later state: MFPS to memory wrote the post-update PSW and ROR/ROL would have
  used the new carry. The 2-frame gameplay trace caught it at instruction
  1,739.
- **frame_done is line 415, not the vblank start**, and the game writes
  motion object RAM through the visible frame: a frozen state can only be a
  gate for frames where that did not change what MAME rendered.

## Sound board

`sim/run_sound.sh 15` (15 s of machine time from power-on: the boot
handshake, the attract-mode silence, the first coin at 10 s and the start at
11.7 s) replays MAME's T11-side events and compares the 6502's chip writes:

*(results are filled in from the run below)*

## Whole machine

`sim/run_system.sh 460 50` boots from the ROM image loaded through the
loader port (one byte per 8 clocks), with MAME's inputs idle:

*(results are filled in from the run below)*
