#!/bin/sh
# Frozen-state video gate: every state listed (default: the ones the
# reference renderer matches pixel for pixel) is rendered by the RTL and
# diffed against the MAME snapshot. Zero differing pixels on every state is
# the pass condition.
#   sim/run_video.sh [state-name ...]
set -e
cd "$(dirname "$0")"
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME waivers.vlt \
    --top-module tb_video_top -Mdir obj_video \
    ../rtl/ssprint_pkg.sv ../rtl/ssprint_video.sv ../rtl/dpram_be.sv ../rtl/sdpram.sv ../rtl/sdram_ctrl.sv \
    sdram_model.sv tb_video_top.sv tb_video.cpp > obj_video.log 2>&1 || { tail -30 obj_video.log; exit 1; }
mkdir -p ../artifacts/diff
fail=0
if [ $# -gt 0 ]; then names="$@"; else names="attract_f00400 attract_f00700 play_f01100 play_f01400 play_f01800"; fi
for n in $names; do
    ./obj_video/Vtb_video_top ../artifacts/states/$n.txt ../artifacts/ssprint.rom ../artifacts/diff/${n}_rtl.rgb > ../artifacts/diff/${n}_rtl.log || { echo "$n: bench failed"; cat ../artifacts/diff/${n}_rtl.log; fail=1; continue; }
    tail -1 ../artifacts/diff/${n}_rtl.log
    python3 ../tools/diff_frames.py ../artifacts/diff/${n}_rtl.rgb ../artifacts/snap/$n.png ../artifacts/diff/${n}_rtldiff.png || fail=1
done
[ $fail = 0 ] && echo PASS || { echo FAIL; exit 1; }
