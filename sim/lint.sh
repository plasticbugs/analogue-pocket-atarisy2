#!/bin/sh
# Lint every RTL file the core synthesises. The vendored cores (T65, jt51)
# are waived by path in sim/waivers.vlt; nothing under rtl/ is waived wholesale.
set -e
cd "$(dirname "$0")/.."
verilator --version >/dev/null 2>&1 || { echo "verilator not found"; exit 2; }
FLAGS="-Wall -Wno-DECLFILENAME -Wno-UNOPTFLAT -Wno-PINCONNECTEMPTY -Wno-PINMISSING -Wno-GENUNNAMED +1364-2005ext+v sim/waivers.vlt"
RTL="rtl/ssprint_pkg.sv $(ls rtl/*.sv rtl/t11/*.sv | grep -v ssprint_pkg)"
VENDOR="modules/cpu-t65/gen/t65.v $(ls modules/sound-jt51/hdl/*.v)"
for top in t11 slapstic108 pokey ssprint_video ssprint_sound ssprint_main; do
    echo "--- $top ---"
    verilator --lint-only $FLAGS --top-module $top $RTL $VENDOR
done
echo "--- whole machine ---"
verilator --lint-only $FLAGS --top-module ssprint_core $RTL $VENDOR
echo "lint clean"
