#!/usr/bin/env python3
"""MAME's event timeline through a window, for the whole-machine bench's
TB_EVLOG: the T11's interrupt entries from a cycle-stamped trace
(tools/trace_t11.lua with CYC=) and the sound commands/responses from
tools/trace_sound.lua's log, each as time / frame / line.

    wipe_events.py <t11_trace.txt> <sound.txt> <from_frame> <to_frame>
"""
import sys, re
FRAME_US, LINE_US = 16640.0, 40.0
tr, snd, f0, f1 = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4])
ev = []
pend = None
for line in open(tr):
    m = re.match(r'\s*\(interrupted at (\d+), IRQ (\d+)\)', line)
    if m: pend = (int(m.group(1), 8), int(m.group(2))); continue
    m = re.search(r'CYC=(\d+) ', line)
    if m and pend:
        t = int(m.group(1)) / 10.0
        ev.append((t, 'IRQ', pend[1], pend[0])); pend = None
for line in open(snd):
    t = line.split()
    if len(t) < 5: continue
    us = float(t[0])
    if t[1] == 'CMD' and t[4] == '00ff': ev.append((us, 'CMD', int(t[3], 16), 0))
    elif t[1] == 'RESP': ev.append((us, 'RESP', int(t[3], 16), 0))
ev.sort()
for t, kind, a, pc in ev:
    f = int(t // FRAME_US); l = (t - f * FRAME_US) / LINE_US
    if f0 <= f <= f1:
        print(f"{t:12.1f} f={f:4d} l={l:6.1f} {kind:4s} {a:02x}" + (f" pc={pc:04x}" if kind == 'IRQ' else ''))
