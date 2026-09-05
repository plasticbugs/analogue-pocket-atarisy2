#!/bin/sh
# Regenerate the frozen MAME states and snapshots used by the reference
# renderer and the RTL video bench. Needs the ssprint romset in ./ssprint (or
# set ROMPATH). Output: artifacts/states/<name>.txt and artifacts/snap/<name>.png
#   tools/capture_states.sh [prefix]     PREFIX names the set (default: attract)
#   env: FRAMES=600,1000 COIN=n START=n WHEEL=n PEDAL=n
set -e
cd "$(dirname "$0")/.."
ROMPATH=${ROMPATH:-.}
PREFIX=${1:-attract}
FRAMES=${FRAMES:-400,700,1000,1500,2500}
W=$(mktemp -d)
mkdir -p artifacts/states artifacts/snap "$W/cfg" "$W/nvram"
OUTDIR=artifacts/states FRAMES="$FRAMES" mame ssprint -rompath "$ROMPATH" -video none -sound none -nothrottle \
    -skip_gameinfo -cfg_directory "$W/cfg" -nvram_directory "$W/nvram" -snapshot_directory "$W/snap" \
    -autoboot_script tools/dumpstate.lua 2>&1 | grep -v "^Warning\|^Average"
i=0
for f in $(echo "$FRAMES" | tr ',' ' '); do
    n=$(printf %05d $f)
    mv "$W/snap/ssprint/$(printf %04d $i).png" "artifacts/snap/${PREFIX}_f$n.png"
    mv "artifacts/states/f$n.txt" "artifacts/states/${PREFIX}_f$n.txt"
    i=$((i+1))
done
rm -rf "$W"
ls -la artifacts/states artifacts/snap
