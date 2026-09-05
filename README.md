# Super Sprint for Analogue Pocket

An openFPGA core for **Super Sprint** (Atari Games, 1986), reimplementing the
Atari System 2 board the game runs on: a DEC T-11 main CPU with the
137412-108 slapstic, the System 2 playfield / alphanumerics / motion object
video, and the sound board with its 6502, two POKEYs and a YM2151. All of it
is gateware; nothing is emulated in software.

> **ROMs are not included and never will be.** You supply your own MAME
> `ssprint` romset; the core reads one image built from it.

## Games

| game | MAME set | status |
|---|---|---|
| Super Sprint (1986) | `ssprint` | verified and played on hardware (below) |
| APB - All Points Bulletin (1987) | `apb` | in the benches: boots, attract mode, high-score table and the start of a game pixel-identical to MAME, the T11 cycle-exact, the sound board's chips written as MAME writes them through the attract mode, speech through the TMS5220 (in-game music order still being matched); not yet run on a Pocket |

## Status (0.2.0)

Verified against MAME as the oracle (details and numbers in
`docs/verification.md`):

* the T-11 core is instruction-trace-exact against MAME over the boot and
  over 40 frames of play (358,000 instructions, every I/O read replayed,
  every interrupt taken at the same instruction boundary)
* the video is pixel-identical to MAME on every frozen state in the gate
  (title, high-score table, three gameplay frames)
* the whole machine boots from the ROM image to the title screen, identical
  to MAME's frame at the same frame number
* the sound board's 6502 drives the POKEYs and the YM2151 with MAME's
  register write sequence, byte for byte, through 15 s of boot, coin, start
  and race (18,626 YM2151 writes, 32,708 POKEY writes, 1,484 responses),
  and the audio envelope matches MAME's within 0.01 dB
* the T-11's cycle costs are MAME's to the cycle over 618,000 instructions
  of the busiest attract stretch (10,649,457 cycles in both)
* a played race runs end to end in the whole-machine bench with the
  arcade's inputs; its frames differ from MAME's only in the cars' positions
  by a few pixels, a 2-frame lead traced to MAME's own CPU scheduling (see
  the verification notes), not to the core

* the core fits the Pocket's Cyclone V and closes timing at every corner
* one core, listed on the Pocket as "Atari System 2" with each game under
  its own name (instance files), per-game saves, one image format for all

* runs on the Pocket: boots, attract mode, coin, start and races with sound;
  0.1.1 reverses the D-pad steering direction the first hardware run showed
  wrong (the analog stick keeps its mapping, with a menu toggle to reverse it)

## Installing

1. Copy `Cores/`, `Platforms/` and `Assets/` from the release zip onto the
   root of the Pocket's SD card.
2. Build the ROM image for each game you have and copy it to
   `Assets/atarisy2/common/`:

   ```sh
   python3 mra_build.py ssprint.mra ssprint.zip     # -> ssprint.rom
   python3 mra_build.py apb.mra apb.zip             # -> apb.rom
   ```

   Nothing but Python 3 is needed. It checks every ROM's CRC32; every image
   is 2,196,480 bytes (format 2, `docs/hardware.md` section 9; images from
   0.1.x must be rebuilt). An already-extracted romset works too: pass the
   directory instead of the zip.

The Pocket lists the platform as "Atari System 2" and each game under it by
name; a game whose image is missing simply will not start.

## Controls

| Pocket | Arcade |
|---|---|
| D-pad left / right, or the left stick | steering wheel |
| A, B, X, Y, L or R | accelerator |
| Select | coin |
| Start | start |
| dock pads 2 and 3 | players 2 and 3 (their own wheel, pedal, coin and start) |

APB: D-pad or stick steers, B / X / L / R is the accelerator, A is the
siren (which also starts the game and picks the day; two coins by default),
Y is the game's other button, Select is coin 1. APB's screen is vertical:
the Pocket's scaler rotates it, and "Screen Shape" offers "Arcade" (3:4),
"Full screen" and two alternative vertical shapes (B and C) while the
scaler's aspect convention for rotated modes is being settled on hardware.
The settings menu has 16 entries, the Pocket's limit: coinage is shared by
both games, the other DIP switches are the "SS:" and "APB:" entries, and
both games' coin multipliers stay at their factory settings.

The wheel turns while a direction is held; its speed is set from the
Pocket's core settings menu ("Steering Speed"). A dock pad's left stick
turns it in proportion to its deflection; the "Analog Stick" entry makes
it half or twice as reactive and reverses it if it steers the wrong way
(the D-pad's direction was checked on hardware, the stick's has not been
yet). The DIP switches (coinage,
difficulty, obstacles, wrenches) and the self-test switch are in the same
menu. Settings and high scores (the board's EEPROM) are saved to
`Saves/atarisy2/plasticbugs.atarisy2/<game>.sav`, one file per game.

## Repository layout

| Path | What |
|---|---|
| `docs/hardware.md` | the machine, from MAME's driver and Lua probes -- read first |
| `docs/rtl-conventions.md` | clocks, memory interfaces, block interfaces |
| `docs/verification.md` | what has been checked against MAME, how, with what result |
| `rtl/` | the core: `ssprint_core.sv` (machine), `ssprint_main.sv` (T11 board), `t11/` (the CPU), `slapstic108.sv`, `ssprint_video.sv`, `ssprint_sound.sv`, `pokey.sv`, `sdram_ctrl.sv` |
| `modules/` | reused cores: T65 (6502, GHDL-converted VHDL), jt51 (YM2151) |
| `sim/` | Verilator benches: `run_t11.sh`, `run_video.sh`, `run_sound.sh`, `run_system.sh`, `lint.sh` |
| `tools/` | `mra_build.py` (ROM image), `render_model.py` (reference frame renderer), MAME Lua probes (`dumpstate.lua`, `trace_t11.lua`, `trace_sound.lua`), `compare_sound.py`, the two machines' event timelines (`wipe_events.py`, `compare_events.py`) |
| `ref/mame/` | the MAME sources the RTL was written from |
| `target/pocket/`, `platform/pocket/`, `projects/`, `pkg/pocket/` | Analogue Pocket integration, Quartus project, core package |
| `artifacts/` | scratch outputs (MAME snapshots, state dumps, traces, diffs); gitignored |

## Building

```sh
./build-local.sh map      # quartus_map only, ~2 min: catches syntax/inference errors
./build-local.sh          # full compile in Docker (raetro/quartus:pocket) + package
./sim/lint.sh             # Verilator lint of everything that synthesises
```

CI (`.github/workflows/compile.yml`) lints, compiles, checks timing closure
and block-RAM fit, and publishes the SD-card package.

## Credits

The Super Sprint-specific RTL and verification harness are original; the
rest of the core is built on other people's work.

**Platform & toolchain**

* the **Analogue Pocket** openFPGA framework (APF) -- Analogue Enterprises
  Limited
* **boogermann (Marcus Andrade)** / OpenGateware -- the Pocket integration
  framework `platform/pocket/` is built from, and the `raetro/quartus:pocket`
  Docker image; the hiscore/NVRAM support carries earlier copyright from Alan
  Steremberg and Jim Gregory
* the S.T.U.N. Runner and Xenophobe Pocket cores (plasticbugs) -- the
  platform tree, the SDRAM controller (whose pin-level timing comes from the
  Punch-Out!! core's `sdram16.sv`), the bench and release tooling, and the
  method in `METHODOLOGY.md`
* **GHDL** -- converts the vendored VHDL 6502 to Verilog
* **Verilator** -- every simulation bench in `sim/`

**Vendored cores** (`modules/`, see `modules/VENDOR.md`)

* **T65**, the 6502 core from FPGAARCADE (Daniel Wallner, Mike Johnson,
  Wolfgang Scherr and other contributors) -- `modules/cpu-t65`
* **JT51** (YM2151) by Jose Tejada (jotego) -- `modules/sound-jt51`

**Reference & verification**

* **MAME** -- the `atarisy2` driver, `atarimo`, `slapstic`, the T11 CPU core
  and the POKEY emulator are the behavioural reference the RTL was written
  from and verified against (`docs/hardware.md`, `docs/verification.md`,
  `METHODOLOGY.md`)
