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
| | `sim/run_t11.sh wipe` | 64 frames of the title-to-table transition (the busiest attract stretch), MAME's trace carrying its cycle counter (`CYC=`) so every instruction's cost is compared | PASS: 618,185 of 618,185 instructions, 10,646 I/O reads, 0 mismatches; **cycle-exact: 10,649,457 cycles in both**, no instruction (interrupt entries included) costing a different number of cycles |
| Video (`rtl/ssprint_video.sv` + `sdram_ctrl`) | `sim/run_video.sh` | reference renderer / MAME PNG on frozen states | PASS: pixel-identical on all 5 gate states (0 differing pixels each), no line-render overrun (`line_late`), 0 SDRAM model errors |
| Sound board (`rtl/ssprint_sound.sv`, `pokey.sv`, T65, jt51) | `sim/run_sound.sh 15` | MAME command/response/reset log and inputs replayed at their times; the 6502's YM2151 / POKEY / latch writes compared in order; `-wavwrite` envelope | PASS: YM2151 18,626 / 18,626 writes identical (register and data, in order); POKEY 2 16,354 / 16,354 identical; POKEY 1 16,354 / 16,354 identical per register (the global interleaving of the IRQ handler's refresh with command handling differs from index 12,685); responses 1,484 / 1,484 identical; write timing median within 0.05 ms of MAME's; audio envelope ratio median 0.999 (-0.01 dB) over the active windows -- see "Sound board" below |
| Whole machine (`rtl/ssprint_core.sv`) | `sim/run_system.sh 460 50` | MAME snapshots every 50 frames of the boot, per-frame sound handshake counts | PASS: **pixel-identical to MAME at frames 100, 150, 200, 250, 350, 400 and 450** (title screen, then the high-score table); frame 300 differs by 13,287 pixels because the RTL is inside the title-to-table wipe there and MAME's frame 300 is not yet (see below); boot handshake identical (2 commands and 8 responses in frame 11 in both); 0 SDRAM model errors |
| Whole machine, a played race | `sim/run_system.sh 1850 100 600 700 760` | MAME's gameplay snapshots with the same inputs at the same frames (coin 600, start 700, pedal floored and wheel to 0x30 at 760) | runs the race end to end: 1,850 frames, 2,858 sound commands, 8,337 responses, the race audio at full level, 0 SDRAM model errors; frames 900, 1100, 1400 and 1800 differ from MAME's by 569, 1,021, 955 and 1,195 pixels -- every differing pixel is a car or a score digit (track, HUD and playfield identical), the cars being a few pixels along their paths from MAME's, the same 2-frame lead the title wipe shows (explained below); re-run unchanged, to the pixel, after the timing fixes to the T11, the EEPROM and the motion-object walk, with `line_late` never set |
| ROM image, APB (`apb.mra`) | `tools/check_rom.lua` (`GAME=apb`) | MAME's loaded regions | byte-identical: header, maincpu 0x8000 + 0x80000, audiocpu 48 KB, tiles, sprites 1 MB (inverted), chars; EEPROM 0xff (MAME has no factory image) |
| T-11, APB | `ROM=../artifacts/apb.rom sim/run_t11.sh apb_boot` | MAME's cycle-stamped boot trace (slapstic 110) | PASS: 29,149 of 29,149 instructions, cycle-exact (499,197 cycles in both), 5 I/O reads |
| Reference renderer, APB | `tools/capture_states.sh` (`GAME=apb`) + `tools/render_model.py` | MAME snapshots at frames 400, 700, 1000, 1500 (vertical game: the snapshot is un-rotated first) | pixel-identical on all 4 (the 1 MB sprite slot, 13-bit codes, the header's code widths) |
| Video, APB | `ROM=../artifacts/apb.rom sim/run_video.sh apb_attract_f00400 ...` | the same 4 states | PASS: pixel-identical on all 4, `line_late` 0 |
| Sound board, APB (with the TMS5220) | `GAME=apb COIN_FRAME=300 DSW0=00 DSW1=00 sim/run_sound.sh 15` | MAME's log with a coin at frame 300 | YM2151 20 / 20, POKEY 1 and 2 10,721 / 10,721 per register, responses 12,101 / 12,101, mixer 4 / 4, sound enable 6 / 6, misc switch 31 / 31: all identical; TMS5220 data 4,400 / 4,430 and strobes 8,802 / 8,862: the LPC bytes are the same, the 6502 writes 30 fewer of the 0xff filler bytes it feeds during the chip's reset sequence because the model releases /READY 41 ms after a stop frame where MAME takes 24 ms -- see "APB" below |
| Whole machine, APB boot | `ROM=../artifacts/apb.rom DSW0=00 DSW1=00 sim/run_system.sh 800 50 300` | MAME snapshots every 50 frames, coin at 300 | **pixel-identical at frames 100-550** (10 of 10 frames, the attract screens and the high-score table; the T11 keeps the 6502 in reset until frame 477 in both); from 600 on the RTL runs ahead of MAME's attract sequence by MAME's scheduler artefact, at this game's rate of ~60 responses per frame: MAME's 8,687 responses in frames 475-805 reach the T11 with 2.34 s of accumulated latency (1,761 of them over 0.3 ms, max 4.3 ms) |
| Synthesis (Quartus 18.1, 5CEBA4) | `./build-local.sh` | -- | **fits and closes timing**: 6,532 / 18,480 ALMs (35 %), 8,904 registers, block memory 982 kbit / 3,154 kbit (31 %, 140 of 308 M10K), 10 DSP blocks, 2 PLLs; bitstream produced and packaged. Slow 85 C corner: 96 MHz core clock **+0.19 ns** setup (TNS 0), clk_74a +2.78, dram_clk +3.06, 16 MHz video +56.8; every hold, recovery, removal and pulse-width check positive at all four corners. The first fit missed by 4.26 ns; "Timing" below lists the seven paths and fixes it took |
| Hardware (Pocket) | the 0.1.0 package on a Pocket | playing it | boots, attract, coin, start, races with sound; the only fault seen was the D-pad steering direction, reversed in 0.1.1 (the wheel's count now increases when turning right; MAME's track-select pointer had suggested the opposite). The analog stick is untested on hardware: it keeps the 0.1.0 mapping with a menu toggle ("Analog Stick Steering") to reverse it |

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
- **MAME hands sound-board responses to the main CPU up to a timeslice
  late.** Perfect interleave is only forced for main-to-sound commands, so
  a game that streams data back from the sound board (Super Sprint fetches
  its high-score table that way) runs the exchange slower in MAME than on
  the board, by 0.5-2.7 ms per exchange here. A whole-machine bench that
  reads responses promptly will lead MAME by frames; the tell-tale is
  response timestamps earlier than the read of the previous byte in MAME's
  own log. Compare the CPU's cycle costs and the interrupt positions before
  blaming the core (`sim/run_t11.sh wipe`, `TB_EVLOG`).
- **frame_done is line 415, not the vblank start**, and the game writes
  motion object RAM through the visible frame: a frozen state can only be a
  gate for frames where that did not change what MAME rendered.

## Sound board

`sim/run_sound.sh 15` (15 s of machine time from power-on: the boot
handshake, the attract-mode silence, the coin at 10 s, the start at 11.7 s
and the steering input at 12.65 s) replays MAME's T11-side events (274
commands, 1,484 response reads, the sound resets) and the coin and wheel
inputs at MAME's frames, and compares the 6502's chip writes:

```
YM2151 writes within 15.0 s: rtl 18626, mame 18626: IDENTICAL
   timing offset rtl-mame: median +0.020 ms, min -0.177, max +0.801
POKEY 1 writes: rtl 16354, mame 16354: global order differs at index 12685; per-register sequences IDENTICAL
POKEY 2 writes: rtl 16354, mame 16354: IDENTICAL
responses writes: rtl 1484, mame 1484: IDENTICAL   (median +0.044 ms)
mixer 1/1, sound enable 3/3: IDENTICAL
audio: envelope ratio rtl/mame over 6 active 0.5 s windows: median 0.999 (-0.01 dB)
PASS
```

Every register write the sound program makes in 15 s -- through the boot
handshake, two board resets, the coin's DIP-switch read (SKCTL/POTGO on
POKEY 1), the start and the first seconds of the race -- is the same byte
to the same register as in MAME, within a tenth of a millisecond. The POKEY
1 "global order" note is the one place two independent activities meet: the
244 Hz IRQ handler refreshes the POKEY channel registers and a T11 command
starts a pot scan, and which comes first within a 2 ms window depends on the
IRQ phase; the per-register sequences are identical.

Three bench lessons, each of which looked like a core bug first:

- the T11's `CLRB @#1681` after every command is not a command (byte lanes,
  above); replaying it as one made the 6502 play 0x00;
- the coin and the steering wheel are on the 6502's side of the machine, so
  the replay has to press them at MAME's frames (`COIN_FRAME`,
  `WHEEL_FRAME`/`WHEEL`) or the DIP-switch read and the steering responses
  do not happen;
- the 244 Hz IRQ divider must start when the board is released, not when the
  bench started loading ROM 0.37 ms earlier, or every IRQ-driven write lands
  0.37 ms early and the ordering against command-driven writes flips.

## Whole machine

`sim/run_system.sh 460 50` boots from the ROM image loaded through the
loader port (one byte per 8 clocks), with MAME's inputs idle. The T11
finishes its RAM tests in frame 6 as MAME does, releases the sound board,
sends the two boot commands in frame 11 and receives the 6502's eight
responses in the same frame (MAME's `tools/trace_sound.lua` log: frame 11,
CMD 2, RESP 8). The title screen is up by frame 100 and the frames at 100,
150, 200 and 250 are pixel-identical to MAME's, as are 350, 400 and 450
(the high-score table). At frame 300 the RTL is one or two frames into the
dithered wipe from the title to the table while MAME's frame 300 is still
the intact title -- a frame's difference in where the game's transition
timer lands, not a rendering difference (the frames either side match).
The T11 executes ~7,100 instructions per attract-mode frame; a frame is
1,597,440 clocks (60.096 Hz).

`sim/run_system.sh 1850 100 600 700 760` then plays a race with MAME's
inputs (`artifacts/sim/frame_*.png`): the coin and start sounds, the
track-select wheel, the race with its engine sound (the mix peaks at
~19,000), lap counting. The frames at 900, 1100, 1400 and 1800 differ from
MAME's snapshots only in the cars (a few pixels along their paths) and the
score digits; the track, playfield and text are identical.

**The 2-frame lead, and why it is MAME's.** The RTL reaches the title
wipe at its frame 300 where MAME does at 303, and the race cars run a
little ahead. Chasing it, in order:

- the sound commands the T11 sends (`TB_CMDLOG`) land in the same frames
  as MAME's -- the boot command in frame 11, the 32-frame heartbeat at 89,
  121, ... 281, the wipe's command 0x10 at 297 -- and then the next
  heartbeat comes at 357 in the RTL and 359 in MAME. So the lead is born
  inside the wipe (frames 297-359);
- the T11 is not faster: `sim/run_t11.sh wipe` compares the cycle cost of
  all 618,185 instructions of that stretch against MAME's cycle counter and
  they agree to the cycle (10,649,457);
- the interrupts are not misplaced: `TB_EVLOG` logs every interrupt entry
  with its raster position and `tools/wipe_events.py` derives MAME's from
  the trace; VBLANK and the 32V interrupts fall at the same lines
  (`tools/compare_events.py`);
- what differs is the high-score fetch. After command 0x10 the 6502 sends
  the T11 the table from its EEPROM, 151 bytes as `03`-separated records,
  each byte handed over through the response latch and polled by the T11
  between wipe steps. MAME's log (`tools/trace_sound.lua`) shows the T11
  reading each `03` 0.5-2.7 ms after the 6502 wrote it, 33 times, 54.7 ms
  of read latency over the fetch, which therefore spans 5 frames
  (26/35/30/35/25 bytes); in the RTL the same 151 bytes take 3 frames
  (65/75/11) with 3.3 ms of read latency in total and no read later than
  0.27 ms after its response.

The MAME latency is the scheduler's, not the game's: MAME runs the T11 and
the 6502 in alternating timeslices, bounded here by the 32V timer (2.56 ms)
and the 244 Hz sound IRQ, and only forces perfect interleave for 200 us
after a main-to-sound command (`atarisy2.cpp`, the `data_pending_callback`),
never for sound-to-main responses. A response written in the 6502's slice
is not seen by the T11 until its next slice. The log shows it directly:
response bytes carry timestamps *earlier* than the T11's read of the
previous byte (the 6502 wrote `e8` at 4945983 us, the T11 read the `03`
before it at 4946011 us), which no hardware handshake can produce. The
sound bench, which replays the T11's reads at MAME's times, agrees with
MAME byte for byte; the whole machine, whose T11 reads a response as soon
as it polls, runs the fetch as the board would. The lead is therefore not
treated as a core bug; the gate frames before the fetch (100-250) and after
the table has settled (350-450) stay pixel-identical, and the race frames
differ only by the resulting phase of the cars.

Before the byte-lane fix (lessons above) the same run sat on a black
screen for ~200 frames: the title came up at ~225 and the table only
after 450. The first per-frame comparison against MAME made the delay
obvious; the sound bench found the cause.

## APB (the multi-game branch)

The core reads a format-2 image (docs/hardware.md section 9) whose header
names the game, its slapstic and what it fits; APB adds slapstic 110 (from
MAME's table, in the same state machine as 108, `rtl/slapstic.sv`), a 48 KB
6502 ROM, a 1 MB sprite slot with 13-bit codes, the TMS5220 speech chip
(vendored VHDL, GHDL-converted, `modules/sound-tms5220`) and a vertical
screen (the Pocket's scaler rotates; the benches un-rotate MAME's
snapshots). Every Super Sprint gate was re-run on the new image format and
is unchanged.

**The speech chip.** The vendored model reproduces MAME's LPC synthesis
but reported /READY as soon as it had taken a byte; MAME (true timing,
which this board's strobes select) holds /READY inactive for 16 chip
clocks after every /WS strobe, services the write then, and keeps it
inactive while the FIFO is full. With that timing added to the model
(`TMS5220.vhd`, marked `(plasticbugs)`) the 6502's speech stream matches
MAME byte for byte through the phrase; what remains is the chip's reaction
to a stop frame: the 6502 then feeds 0xff bytes (RESET commands) until the
chip accepts them, and the model accepts the first one 41 ms after the
stop frame where MAME does after 24 ms, so 30 of the 4,430 filler bytes
are not written. The attract mode only ever speaks silence frames (energy
0), so a voiced comparison needs a started game -- still to be captured
(APB needs two coins after the sound board is up, and its start is one of
its two buttons).

## Timing

Quartus 18.1, 5CEBA4F23C8, slow 1100 mV 85 C model. The first fit closed
every clock but the 96 MHz core clock, which missed setup by 4.26 ns. The
paths, in the order the worst-path report (`projects/worst85c.tcl`)
surfaced them, and what was done:

| Worst path | Slack | Fix |
|---|---|---|
| jt51 `kf` -> `keycode_II` (the YM2151's key-code arithmetic) | -4.26 ns | every jt51 state register advances on `cen` (3.58 MHz, one pulse per ~27 clocks) or `cen_p1`, so an 8/7 multicycle on jt51-internal paths, argued in the SDC |
| POKEY `counter` -> `sum` (MAME's whole `step_one_clock` in one clock) | -4.30 ns | the POKEYs step and take writes only on the 1.79 MHz enable (53 clocks), so the same 8/7 exception on `pokey:*` paths |
| framework synchroniser (built as a RAM shift register) -> `nv_rdata` / `eep[...]` | -2.73 ns | the EEPROM had two write ports (6502 and the save slot) so Quartus built it from 4,096 flops behind a 512-way mux; it is now a 256 x 16 `dpram_be` with byte enables, one port per writer. Logic fell from 12,947 to 6,257 ALMs (70 % to 34 %) |
| T11 `opsel` -> `r[n]` (operand select -> register mux -> autoincrement adder -> write-back) | -0.93 ns | every register's +1/+2/-1/-2 is computed ahead of the select, so the engine picks a sum instead of adding to a pick; `sim/run_t11.sh` boot/play/long/wipe re-run unchanged, cycle-exact |
| synchroniser -> `steer_wheel` accumulator (direction, deflection and the period multiply straight off the RAM shifter) | -0.89 ns | the wheel registers its inputs and its period before the counter |
| motion object RAM output -> `mo_baddr` / `mxpos` (the entry's Y, height and row arithmetic straight off the M10K) | -1.58 ns (surfaced once the above were fixed) | the list walk registers the entry's four words (MO_ENT2) and decodes them a clock later (MO_ENT3): one clock more per entry, `line_late` still 0 on every gate state, `sim/run_video.sh` pixel-identical |
| T65 address register -> POKEY write decode (`we`, the STIMER/SKCTL precedence) -> the step -> `borrow` | -0.55 ns | both ends move only on cen_cpu (the T65's registers change on its enable, the POKEY captures on the same one), so the T65 -> POKEY paths carry the same 8/7 exception; the jt51's write port samples every clock and is deliberately not covered |
| T11 `aop` (ALU operation) -> adder -> result mux -> `r[n]` | -0.52 ns | the ALU result is registered (`wr_val`) and written to the register in its own state (S_WRR), as it already was for memory destinations; the MAME cycle budget absorbs the clock. The autoincrement writes are also per register under their own compare so no r[i] takes a mux of all eight sums. T11 benches re-run: boot / play / long / wipe unchanged and cycle-exact |

The SDRAM output paths (`cur` -> `SDRAM_A`, -1.9 ns while the big
violations were unfixed) closed on their own once the fitter was no longer
spending its effort on them. Final: 96 MHz +0.19 ns at the slow 85 C
corner with zero total negative slack, no negative slack anywhere in the
four-corner summary; the logic shrank from 70 % to 35 % of the ALMs on the
way (the EEPROM). Every RTL change was re-gated (the T11 benches, the video
gate, the boot gate and the race) before its compile.
