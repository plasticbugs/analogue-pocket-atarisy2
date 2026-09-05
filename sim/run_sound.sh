#!/bin/sh
# Sound board bench: replay MAME's command stream (tools/trace_sound.lua,
# artifacts/traces/sound.txt + artifacts/sound/mame.wav) and compare.
#   sim/run_sound.sh [seconds]
set -e
cd "$(dirname "$0")"
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME -Wno-UNOPTFLAT +1364-2005ext+v waivers.vlt \
    --top-module tb_sound_top -Mdir obj_sound \
    ../rtl/ssprint_sound.sv ../rtl/pokey.sv ../rtl/clk_enables.sv ../modules/cpu-t65/gen/t65.v $(ls ../modules/sound-jt51/hdl/*.v) \
    tb_sound_top.sv tb_sound.cpp > obj_sound.log 2>&1 || { tail -40 obj_sound.log; exit 1; }
S=${1:-10}
./obj_sound/Vtb_sound_top ../artifacts/ssprint.rom ../artifacts/traces/sound.txt $S ../artifacts/sound/rtl.txt ../artifacts/sound/rtl.wav
python3 ../tools/compare_sound.py ../artifacts/traces/sound.txt ../artifacts/sound/rtl.txt ../artifacts/sound/mame.wav ../artifacts/sound/rtl.wav $S
