#!/bin/sh
# Sound board bench: replay MAME's command stream (tools/trace_sound.lua,
# artifacts/traces/sound.txt + artifacts/sound/mame.wav) and compare.
#   sim/run_sound.sh [seconds]
set -e
cd "$(dirname "$0")"
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME -Wno-UNOPTFLAT +1364-2005ext+v waivers.vlt \
    --top-module tb_sound_top -Mdir obj_sound \
    ../rtl/ssprint_sound.sv ../rtl/pokey.sv ../rtl/clk_enables.sv ../rtl/dpram_be.sv ../modules/cpu-t65/gen/t65.v ../modules/sound-tms5220/gen/tms5220.v $(ls ../modules/sound-jt51/hdl/*.v) \
    tb_sound_top.sv tb_sound.cpp > obj_sound.log 2>&1 || { tail -40 obj_sound.log; exit 1; }
# GAME=apb selects that game's image, MAME log and wav (artifacts/apb.rom,
# artifacts/traces/apb_sound.txt, artifacts/sound/apb_mame.wav); the default
# is Super Sprint's (ssprint.rom, traces/sound.txt, sound/mame.wav). The
# bench's input replay (COIN_FRAME, WHEEL_FRAME, WHEEL, DSW0, DSW1) is taken
# from the environment.
S=${1:-10}
G=${GAME:-ssprint}
if [ "$G" = ssprint ]; then TRACE=../artifacts/traces/sound.txt; MWAV=../artifacts/sound/mame.wav; ROM=${ROM:-../artifacts/ssprint.rom}
else TRACE=../artifacts/traces/${G}_sound.txt; MWAV=../artifacts/sound/${G}_mame.wav; ROM=${ROM:-../artifacts/$G.rom}; fi
./obj_sound/Vtb_sound_top $ROM $TRACE $S ../artifacts/sound/${G}_rtl.txt ../artifacts/sound/${G}_rtl.wav
python3 ../tools/compare_sound.py $TRACE ../artifacts/sound/${G}_rtl.txt $MWAV ../artifacts/sound/${G}_rtl.wav $S
