#!/bin/sh
# T11 core bench: the core on the real ROM vs a MAME instruction trace with
# replayed I/O reads (tools/trace_t11.lua).
#   sim/run_t11.sh [window] [max_instructions]
# window = boot (default; from reset) or any artifacts/traces/t11_<window>.txt
# whose first line's registers describe the start state; a matching
# artifacts/states/<window>.txt (tools/dumpstate.lua with RAM) seeds memory.
set -e
cd "$(dirname "$0")"
W=${1:-boot}
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME -Wno-UNOPTFLAT waivers.vlt \
    --top-module tb_t11_top -Mdir obj_t11 \
    ../rtl/t11/t11.sv ../rtl/slapstic.sv tb_t11_top.sv tb_t11.cpp > obj_t11.log 2>&1 || { tail -40 obj_t11.log; exit 1; }
STATE=""
[ -f ../artifacts/states/t11_$W.txt ] && STATE=../artifacts/states/t11_$W.txt
./obj_t11/Vtb_t11_top ${ROM:-../artifacts/ssprint.rom} ../artifacts/traces/t11_$W.txt ../artifacts/traces/t11_${W}_io.txt ${2:-100000000} $STATE
