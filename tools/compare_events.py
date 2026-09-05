#!/usr/bin/env python3
"""Align MAME's event timeline (tools/wipe_events.py) with the whole-machine
bench's TB_EVLOG lines and show where the two machines' timelines part:
events are matched in order by kind (IRQ code / CMD value / RESP); the
rtl-mame time offset is printed whenever it moves by more than a line.

    compare_events.py <mame_events.txt> <rtl_log.txt> [max_lines]
"""
import sys, re
def load(path, rtl):
    ev = []
    for line in open(path):
        if rtl and not line.startswith('EV '): continue
        m = re.match(r'\s*(?:EV\s+)?([\d.]+)\s+f=\s*(\d+)\s+l=\s*([\d.]+)\s+(\w+)\s+(\S+)(?:\s+pc=(\w+))?', line)
        if not m: continue
        ev.append((float(m.group(1)), int(m.group(2)), float(m.group(3)), m.group(4), m.group(5), m.group(6) or ''))
    return ev
m, r = load(sys.argv[1], False), load(sys.argv[2], True)
maxl = int(sys.argv[3]) if len(sys.argv) > 3 else 60
print(f"mame {len(m)} events, rtl {len(r)} events")
# the RTL log begins at its TB_EVLOG frame, MAME's at its from-frame: start both at the first
# VBLANK interrupt (code 0c) at or after the later of the two first frames
def first_vbl(ev, f):
    for i, e in enumerate(ev):
        if e[3] == 'IRQ' and e[4] == '0c' and e[1] >= f: return i
    return 0
f_start = max(m[0][1], r[0][1]) + 1
i, j = first_vbl(m, f_start), first_vbl(r, f_start)
off0 = r[j][0] - m[i][0]
print(f"aligned on the VBLANK of MAME frame {m[i][1]} (rtl frame {r[j][1]}): rtl-mame = {off0:.1f} us")
last_off, shown, n = off0, 0, 0
while i < len(m) and j < len(r):
    a, b = m[i], r[j]
    if a[3] != b[3] or (a[3] != 'RESP' and a[4] != b[4]):
        print(f"ORDER differs: mame {a[0]:.1f} f={a[1]} l={a[2]:.1f} {a[3]} {a[4]} {a[5]}   rtl {b[0]:.1f} f={b[1]} l={b[2]:.1f} {b[3]} {b[4]} {b[5]}")
        shown += 1
        if shown > maxl: break
        # resync: skip the one that is earlier in its own timeline
        if (b[0] - off0) < a[0]: j += 1
        else: i += 1
        continue
    off = b[0] - a[0]
    if abs(off - last_off) > 40 or (a[3] == 'IRQ' and a[5] != b[5] and shown < maxl):
        print(f"{'drift' if abs(off - last_off) > 40 else 'pc   '}: mame f={a[1]} l={a[2]:6.1f} {a[3]} {a[4]} pc={a[5]}   rtl f={b[1]} l={b[2]:6.1f} {b[3]} {b[4]} pc={b[5]}   rtl-mame {off:.1f} us (was {last_off:.1f})")
        shown += 1
        if shown > maxl: break
    last_off = off; i += 1; j += 1; n += 1
print(f"{n} events matched in order; final rtl-mame offset {last_off:.1f} us")
