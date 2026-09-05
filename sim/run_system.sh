#!/bin/sh
# Whole-machine bench: sim/run_system.sh [frames] [snap_every] [coin_frame] [start_frame] [pedal_frame]
set -e
cd "$(dirname "$0")"
verilator --cc --exe --build -j 8 -O2 -Wno-fatal -Wno-DECLFILENAME -Wno-UNOPTFLAT +1364-2005ext+v waivers.vlt \
    --top-module tb_system_top -Mdir obj_system \
    ../rtl/ssprint_pkg.sv ../rtl/ssprint_core.sv ../rtl/ssprint_main.sv ../rtl/ssprint_video.sv ../rtl/ssprint_sound.sv \
    ../rtl/t11/t11.sv ../rtl/slapstic108.sv ../rtl/pokey.sv ../rtl/clk_enables.sv ../rtl/dpram_be.sv ../rtl/sdpram.sv \
    ../rtl/sdram_ctrl.sv ../rtl/dbg_overlay.sv \
    ../modules/cpu-t65/gen/t65.v $(ls ../modules/sound-jt51/hdl/*.v) \
    sdram_model.sv tb_system_top.sv tb_system.cpp -LDFLAGS "-lz" > obj_system.log 2>&1 || { tail -40 obj_system.log; exit 1; }
mkdir -p ../artifacts/sim
./obj_system/Vtb_system_top ../artifacts/ssprint.rom ${1:-120} ${2:-30} ${3:--1} ${4:--1} ${5:--1}
