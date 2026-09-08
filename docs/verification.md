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
| Sound board (`rtl/ssprint_sound.sv`, `pokey.sv`, T65, jt51) | `sim/run_sound.sh 15` | MAME command/response/reset log and inputs replayed at their times; the 6502's YM2151 / POKEY / latch writes compared in order; `-wavwrite` envelope | PASS over MAME's whole 14.976 s log: YM2151 18,626 / 18,626 writes identical (register and data, in order); POKEY 1 and POKEY 2 16,354 / 16,354 identical, in global order too (the IRQ handler's refresh interleaving matched once the IRQ phase followed the reset); responses 1,484 / 1,484 identical; write timing median within 0.05 ms of MAME's; audio envelope ratio median 1.000 over the active windows -- see "Sound board" below |
| Whole machine (`rtl/ssprint_core.sv`) | `sim/run_system.sh 460 50` | MAME snapshots every 50 frames of the boot, per-frame sound handshake counts | PASS: **pixel-identical to MAME at frames 100, 150, 200, 250, 350, 400 and 450** (title screen, then the high-score table); frame 300 differs by 13,287 pixels because the RTL is inside the title-to-table wipe there and MAME's frame 300 is not yet (see below); boot handshake identical (2 commands and 8 responses in frame 11 in both); 0 SDRAM model errors |
| Whole machine, a played race | `sim/run_system.sh 1850 100 600 700 760` | MAME's gameplay snapshots with the same inputs at the same frames (coin 600, start 700, pedal floored and wheel to 0x30 at 760) | runs the race end to end: 1,850 frames, 2,858 sound commands, 8,337 responses, the race audio at full level, 0 SDRAM model errors; frames 900, 1100, 1400 and 1800 differ from MAME's by 569, 1,021, 955 and 1,195 pixels -- every differing pixel is a car or a score digit (track, HUD and playfield identical), the cars being a few pixels along their paths from MAME's, the same 2-frame lead the title wipe shows (explained below); re-run unchanged, to the pixel, after the timing fixes to the T11, the EEPROM and the motion-object walk, with `line_late` never set |
| ROM image, APB (`apb.mra`) | `tools/check_rom.lua` (`GAME=apb`) | MAME's loaded regions | byte-identical: header, maincpu 0x8000 + 0x80000, audiocpu 48 KB, tiles, sprites 1 MB (inverted), chars; EEPROM 0xff (MAME has no factory image) |
| T-11, APB | `ROM=../artifacts/apb.rom sim/run_t11.sh apb_boot` | MAME's cycle-stamped boot trace (slapstic 110) | PASS: 29,149 of 29,149 instructions, cycle-exact (499,197 cycles in both), 5 I/O reads |
| Reference renderer, APB | `tools/capture_states.sh` (`GAME=apb`) + `tools/render_model.py` | MAME snapshots at frames 400, 700, 1000, 1500 (vertical game: the snapshot is un-rotated first) | pixel-identical on all 4 (the 1 MB sprite slot, 13-bit codes, the header's code widths) |
| Video, APB | `ROM=../artifacts/apb.rom sim/run_video.sh apb_attract_f00400 ...` | the same 4 attract states and 5 in-game states (frames 900-1300 of a started game, `apb_game_*`) | PASS on the 4 attract states and on the in-game frames 900, 1000, 1100 (pixel-identical, `line_late` 0); frames 1200 and 1300 differ by 501 and 1,290 pixels, exactly the reference renderer's counts on the same states (writes during the visible frame), so they are excluded from the gate as Super Sprint's were. The in-game states found the Y scroll bug below |
| Sound board, APB, started game | `GAME=apb COIN_FRAME=650 COINS=3 DSW0=00 DSW1=00 sim/run_sound.sh 25` | MAME's log of a started game (three coins at 650, the siren at 800, 860, 920), 25 s with speech and music | over MAME's whole 24.96 s log: the TMS5220 data stream identical for all 11,697 of MAME's writes (the speech, and every idle byte) once the chip's frame timing restarted on a reset as MAME's does; POKEY 1 20,452 / 20,452 identical per register, mixer, enables and switches identical; responses identical but for one status byte at 9.365 s: two reports 0.35 ms apart after the second sound reset, where MAME's 6502 says no interrupt ran in between (bit 2 of its flags) and the RTL's says one did -- a race of the 6502's IRQ latency (its acknowledges are 2-3 us behind MAME's) against the report; the YM2151 order differs from 18.2 s and POKEY 2's from 11.36 s where the T11's command (an NMI, replayed at MAME's logged time) lands inside the RTL's IRQ handler a few us later than in MAME, so a command's register writes interleave with the handler's differently (37,666 / 37,630 YM writes); audio envelope median 1.003 (+0.03 dB) over 19 windows, peaks 14,283 / 14,585 |
| Sound board, APB, attract mode | (the first 10.8 s of the started-game log above: the boot, the attract mode with its speech, the second sound reset at 9.17 s) | | as the row above: the speech stream, POKEYs, mixer and switches identical; the earlier attract-only capture was superseded by the started-game log (a run against it with one coin at frame 300 differs from 11.7 s only because the credits it reports are not the log's three) |
| Whole machine, APB boot | `ROM=../artifacts/apb.rom DSW0=00 DSW1=00 sim/run_system.sh 800 50 300` | MAME snapshots every 50 frames, coin at 300 | **pixel-identical at frames 100-550** (10 of 10 frames, the attract screens and the high-score table; the T11 keeps the 6502 in reset until frame 477 in both); from 600 on the RTL runs ahead of MAME's attract sequence by MAME's scheduler artefact, at this game's rate of ~60 responses per frame: MAME's 8,687 responses in frames 475-805 reach the T11 with 2.34 s of accumulated latency (1,761 of them over 0.3 ms, max 4.3 ms), the RTL's 14,270 exchanges over the same frames with 0.38 s (84 over 0.3 ms, max 1.1 ms; `TB_EVLOG`) |
| Whole machine, APB started game | `ROM=../artifacts/apb.rom DSW0=00 DSW1=00 COINS=3 STARTS=3 sim/run_system.sh 1300 100 650 800` | MAME snapshots at 900-1300 with the same inputs (three coins from 650, the siren at 800, 860, 920) | the game starts as in MAME: **frames 900 and 1000 pixel-identical** (day select, the practice prompt); by 1100 the RTL is driving in the precinct lot while MAME is still on the practice prompt, the same scheduler lead as the attract mode at this game's ~60 responses per frame; 1,300 frames, 3,108 commands, 15,783 responses, audio playing, 0 SDRAM model errors |
| ROM image, Championship Sprint (`csprint.mra`) | `tools/check_rom.lua` (`GAME=csprint`) | MAME's loaded regions | byte-identical: header, maincpu 0x8000 + 0x80000 (the 32 KB pairs stored twice, as `init_csprint` expands them), audiocpu, tiles, sprites (Super Sprint's eight ROMs), chars, EEPROM |
| T-11, Championship Sprint | `ROM=../artifacts/csprint.rom sim/run_t11.sh cs_boot` | MAME's cycle-stamped boot trace (slapstic 109) | PASS: 29,956 of 29,956 instructions, cycle-exact (499,191 cycles in both), 7 I/O reads |
| Video, Championship Sprint | `ROM=../artifacts/csprint.rom sim/run_video.sh cs_attract_f00400 ...` | MAME snapshots at frames 400, 700, 1000, 1500 | frame 400 pixel-identical; 700, 1000 and 1500 differ by 469, 711 and 189 pixels, exactly the reference renderer's counts (cars written during the visible frame), `line_late` 0 |
| Whole machine, Championship Sprint boot | `ROM=../artifacts/csprint.rom sim/run_system.sh 460 50` | MAME snapshots every 50 frames | **pixel-identical at frames 100-350 and 450** (7 of 8); frame 400 differs by 36,864 pixels, a screen transition the RTL is a frame or two into, as Super Sprint's frame 300; 0 SDRAM model errors |
| Sound board, Championship Sprint | `GAME=csprint COIN_FRAME=600 COIN_BIT=1 WHEEL_FRAME=760 WHEEL=0x30 DSW0=00 DSW1=40 sim/run_sound.sh 15` | MAME's log with a coin at 600 (this game's coin 1 is IN1 bit 6, hence `COIN_BIT=1`), start at 700, wheel at 760 | over MAME's whole 14.976 s log: responses 968 / 968 identical; YM2151 identical for the RTL's 21,914 writes (MAME's last 10, in its final 5 ms, are the ones its 6502 wrote from an interrupt it serviced twice at 14.647 s, 0.7 ms apart, then irregularly -- MAME's 6502 falls behind in the T11's status-report exchanges, see the sound board notes -- while the RTL keeps its 4,096 us period; 3,627 / 3,621 acknowledges); POKEY 2 16,335 / 16,335 identical, POKEY 1 identical per register (order differing from 16,180, in that same last stretch); write timing median within 0.05 ms of MAME's; the POKEY level is still the open item below (envelope median 1.343, +2.56 dB, on the boot chime) |
| ROM image, Paperboy (`paperboy.mra`) | `tools/check_rom.lua` (`GAME=paperboy`) | MAME's loaded regions | byte-identical: header, maincpu 0x8000 + 0x80000 (16 KB pairs stored four times, as `init_paperboy` expands them), audiocpu 48 KB, tiles (128 KB region as two halves at slot offsets 0 / 0x40000), sprites, chars (8 KB stored twice), EEPROM (the set's dump or MAME's, `crc="a|b"`) |
| T-11, Paperboy | `ROM=../artifacts/paperboy.rom sim/run_t11.sh pb_boot` | MAME's cycle-stamped boot trace (slapstic 105) | PASS: 29,238 of 29,238 instructions, cycle-exact (499,194 cycles in both), 6 I/O reads |
| Reference renderer and video, Paperboy | `tools/capture_states.sh` (`GAME=paperboy`) + `render_model.py`; `ROM=../artifacts/paperboy.rom sim/run_video.sh pb_attract_f00400 ...` | MAME snapshots at frames 400, 700, 1000, 1500 | frames 400, 700 and 1000 pixel-identical in both the renderer and the RTL (12-bit tile codes, the 8 KB character ROM); 1500 differs by 869 pixels in both (cars written mid-frame) |
| Whole machine, Paperboy boot | `ROM=../artifacts/paperboy.rom DSW0=00 DSW1=00 sim/run_system.sh 460 50` | MAME snapshots every 50 frames | pixel-identical at frames 200, 300 and 450; 250, 350 and 400 differ by 314 pixels (one small element, see the diff image); 100 and 150 are the boot's striped test pattern in both, at a different point of its colour cycle (the RTL ahead, as the other games' boots); 0 SDRAM model errors |
| Sound board, Paperboy (with the TMS5220) | `GAME=paperboy COIN_FRAME=600 COIN_BIT=1 WHEEL_FRAME=-1 DSW0=00 DSW1=c0 sim/run_sound.sh 15` | MAME's log with a coin at 600 and button 1 at 700 (9,729 speech data writes); DSW1 is 0xc0, MAME's default (its two unused switches read 1) | PASS over MAME's whole 14.976 s log: YM2151 7,964 / 7,964 writes identical, POKEY 1 14,687 / 14,687 and POKEY 2 14,678 / 14,678 identical (global order too), responses 465 / 465 identical, mixer and enables identical; write timing within 0.06 ms of MAME's (median +0.002 to +0.024 ms) once the sound IRQ phase follows the reset; the TMS5220 data stream (9,729 writes) identical but for one extra idle 0xff byte the FIFO accepts at 1.17 s (19 before its first stall, MAME 18), the 253 ms speech stall and the 33 ms stop-frame halt at the same times; audio envelope median 0.993 (-0.06 dB) over 9 active windows. Found on the way: the model's RESET command held /READY active (fixed), the sound IRQ phase (fixed), the fast start (fixed), and the bench's replay of the T11's response reads (fixed) -- see the sound board section |
| ROM image, 720 Degrees (`720.mra`) | `tools/check_rom.lua` (`GAME=720`) | MAME's loaded regions | byte-identical: header, maincpu 0x8000 + 0x80000 (three 64 KB pairs, the rest empty), audiocpu 48 KB, tiles (256 KB region as two halves at slot offsets 0 / 0x40000), sprites 1 MB (each ROM's second half below its first, MAME's `ROM_CONTINUE`), chars 16 KB, EEPROM (the set's dump or MAME's) |
| T-11, 720 Degrees | `ROM=../artifacts/720.rom sim/run_t11.sh t720_boot t720_long` | MAME's cycle-stamped traces (slapstic 107): the boot, and 40 frames of the first skate-park demo (frames 600-639) | PASS: 29,236 of 29,236 boot instructions (499,194 cycles in both, 6 I/O reads); 322,347 of 322,347 demo instructions (6,655,854 cycles in both, 11,752 I/O reads, 280 interrupts), cycle-exact |
| Reference renderer and video, 720 Degrees | `tools/capture_states.sh` (`GAME=720`, prefix `t720_attract`) + `render_model.py`; `ROM=../artifacts/720.rom sim/run_video.sh t720_attract_f00400 ...` | MAME snapshots at frames 400, 700, 1000, 1500, 2500 | 400, 700, 1500 and 2500 pixel-identical in both the renderer and the RTL (13-bit tile and motion object codes); 1000 (the title) differs by 1,444 pixels in both, the same pixels (the state written mid-frame) |
| Whole machine, 720 Degrees boot | `ROM=../artifacts/720.rom DSW0=00 DSW1=55 sim/run_system.sh 460 50` | MAME snapshots every 50 frames | pixel-identical at 100, 150, 250 and 300; 200 differs by 271 pixels (the GAME OVER / INSERT COIN line, which blinks every 32 frames from 169: the RTL is at the next phase), 350 by 2,409 (inside the dithered wipe), 400 by 101 (its end), 450 by 1,259 (the park demo's two skaters, a step further along) -- the one-frame lead seen in the other games; 0 SDRAM model errors |
| Sound board, 720 Degrees (with the TMS5220) | `GAME=720 COIN_FRAME=600 COIN_BIT=1 WHEEL_FRAME=-1 DSW0=00 DSW1=55 sim/run_sound.sh 15` | MAME's log with a coin at 600 and button 1 at 700 (10,083 speech data writes); DSW1 is 0x55, MAME's default | over MAME's whole 14.976 s log: POKEY 1 15,200 / 15,200 and POKEY 2 15,200 / 15,200 writes identical (global order too); the TMS5220 stream 10,083 / 10,083 identical, in timing too (median +0.002 ms) once the chip's frame timing restarted on a reset; mixer, enables and switches identical; every response matches except the 94 bytes of the 47 `RANDOM` reports (command 0x18: the 6502 sends two POKEY RANDOM bytes to the T11, and MAME's value is the polynomial counter of its POKEY *device* wherever the scheduler's timeslice left it -- `pokey_device::read` resyncs the scheduler but does not step the counters to the read -- so the bytes are not reproducible by hardware); YM2151 7,404 / 7,404 writes, 11 data values differ at 13.07 s and 14.26 s (a tune's variation, after those random bytes); write timing within 0.12 ms of MAME's; audio envelope median 0.990 (-0.09 dB) over 9 windows |
| Synthesis, multi-game core, five games (Quartus 18.1, 5CEBA4), 0.3.0 | `./build-local.sh` | -- | fits at 8,689 / 18,480 ALMs (47 %), 10220 registers, block memory 1,113,565 / 3,153,920 bits (35 %, 156 of 308 M10K); slow 85 C **+0.86 ns** on the 96 MHz clock, no negative slack at any corner with fitter seed 5 (seeds 3 and 4 missed hold by 30 and 49 ps at the fast 0 C corner on a jt51 register -> RAM shift-register path once the POKEY reset and TMS5220 timing reset went in; the earlier three-game netlist fit at 46 % with +0.99 ns) |
| Synthesis, Super Sprint core 0.1.2 (Quartus 18.1, 5CEBA4) | `./build-local.sh` | -- | **fits and closes timing**: 6,532 / 18,480 ALMs (35 %), 8,904 registers, block memory 982 kbit / 3,154 kbit (31 %, 140 of 308 M10K), 10 DSP blocks, 2 PLLs; bitstream produced and packaged. Slow 85 C corner: 96 MHz core clock **+0.19 ns** setup (TNS 0), clk_74a +2.78, dram_clk +3.06, 16 MHz video +56.8; every hold, recovery, removal and pulse-width check positive at all four corners. The first fit missed by 4.26 ns; "Timing" below lists the seven paths and fixes it took |
| Hardware (Pocket) | the 0.1.0 to 0.3.0 packages on a Pocket | playing it | 0.1.0: boots, attract, coin, start, races with sound; the only fault seen was the D-pad steering direction, reversed in 0.1.1 (the wheel's count now increases when turning right; MAME's track-select pointer had suggested the opposite). The analog stick is untested on hardware: it keeps the 0.1.0 mapping with a menu setting ("Analog Stick": Reversed) to reverse it. 0.2.x/0.3.0 (the owner's reports): APB plays great with speech and the rotated screen, Championship Sprint works great, and Paperboy and 720 Degrees play fine with no obvious issues; the 0.2.x APB run found the accelerator held (the pedal value, 0xc0 floored) and the car stalling (the ADC read during a conversion), both fixed |

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
- **The Pocket reads interact.json through two fixed buffers: about 8 KB
  for the file and about 5 KB for a line.** The multi-game menu,
  pretty-printed at 9,462 bytes, gave "error in interact" while a
  7,849-byte one loaded; minified to a single line, 4,747 and 5,120 bytes
  loaded and 5,233 did not. The documented limits (16 entries, 23-character
  names) are real too but were not the cause. `package-pocket.py` writes
  the packaged copy compact with one entry per line and refuses a file over
  7,000 bytes or a line over 3,000 characters.
- **Lua's `set_value` on an analog field writes the port's final value,
  bypassing PORT_INVERT.** The pedal's "fully pressed" value was measured
  that way as 0x3f and built into the core; a real key press in MAME gives
  0xc0 (0xff at rest, inverted from the 0..0x3f raw range). Super Sprint
  takes 0x3f as pressed all the same, so every gate passed; APB reads the
  pedal as a throttle, takes anything below 0xc0 as a hard brake and creeps
  at 0xff, and the Pocket showed it: the car drove itself and stopped when
  the gas was held. Measure an input the way the player produces it.
- **A game that never scrolls cannot verify the scroll registers.** Super
  Sprint's playfield sits still (its Y scroll register only ever carries
  bank bits), so every gate passed with the RTL taking the Y scroll from
  bit 7 up instead of MAME's `>> 6`; APB's scrolling road, in the first
  in-game state, showed the playfield at half its scroll. A second game on
  the same hardware is the cheapest way to exercise the registers the
  first one leaves alone.
- **frame_done is line 415, not the vblank start**, and the game writes
  motion object RAM through the visible frame: a frozen state can only be a
  gate for frames where that did not change what MAME rendered.

## Sound board

`sim/run_sound.sh 15` (15 s of machine time from power-on: the boot
handshake, the attract-mode silence, the coin at 10 s, the start at 11.7 s
and the steering input at 12.65 s) replays MAME's T11-side events (274
commands, 1,484 response reads, the sound resets) and the coin and wheel
inputs at MAME's frames, and compares the 6502's chip writes. The T11's
reads of the response latch are replayed in step with the RTL's 6502, not
at their logged times: MAME stamps each CPU's accesses with its own
timeslice clock, so a read is logged up to a slice after (or before) the
write it consumed while MAME's 6502 sees the latch emptied before that
time. The bench pairs each read with the response it consumed (in order,
by value) and issues it once the RTL's 6502 has written that response, as
the T11 polls P2TALK for it; a read that found the latch empty is replayed
at its logged time, on an empty latch. Before this, a tight exchange
(Paperboy's 6502 streaming its report at a byte per ~50 us) let a read land
before the RTL's write, leaving that response unread and the 6502 waiting on
P2TALK for good (at 13.15 s in Paperboy's run):

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
0); a started game (three coins after the sound board is up at frame 477,
then the siren, IN0 bit 3, which starts it and picks the day) speaks and
plays music, and over 25 s of it the RTL's audio envelope is MAME's within
0.01 dB while the 6502's write sequence parts at 11.0 s: its status report
to the T11 carries a bit (the chip's /READY, IN1 bit 2, most likely) one
IRQ tick before MAME's, and the music it then plays takes a different path.
The likely cause is the same: the model's speech FIFO fills a little
earlier than MAME's around a stop frame. Finding the exact difference
means comparing the model's frame state machine (TALK, TALKD, SPEN, DDIS)
against MAME's `process()` cycle by cycle, which is the next step for the
branch. Until then APB plays with the right music and speech content but
not always in MAME's order.

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
