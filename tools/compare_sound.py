#!/usr/bin/env python3
"""Hold the sound board bench to MAME: the YM2151 and POKEY register write
sequences must be identical (register, data, in order) and the audio
envelopes must match window by window.

    compare_sound.py <mame_log.txt> <rtl_log.txt> <mame.wav> <rtl.wav> <seconds>

MAME's log is tools/trace_sound.lua's (T11 and 6502 events); the RTL log is
sim/tb_sound.cpp's. Both carry microsecond times: the RTL's time base is
the moment the bench released the board, MAME's is the machine's, so only
the first SRST write's time aligns them.
"""
import sys, struct, math


def read_log(path, limit_us):
    ev = []
    for line in open(path):
        t = line.split()
        if len(t) < 4:
            continue
        us = float(t[0])
        if us > limit_us:
            break
        ev.append((us, t[1], int(t[2], 16), int(t[3], 16)))
    return ev


def read_wav(path):
    d = open(path, "rb").read()
    assert d[:4] == b"RIFF"
    pos, rate, ch, bits, data = 12, 0, 0, 0, b""
    while pos + 8 <= len(d):
        tag, ln = d[pos:pos + 4], struct.unpack("<I", d[pos + 4:pos + 8])[0]
        body = d[pos + 8:pos + 8 + ln]
        if tag == b"fmt ":
            ch, rate, bits = struct.unpack("<H", body[2:4])[0], struct.unpack("<I", body[4:8])[0], struct.unpack("<H", body[14:16])[0]
        elif tag == b"data":
            data = body
        pos += 8 + ln + (ln & 1)
    n = len(data) // (2 * ch)
    samples = struct.unpack("<%dh" % (n * ch), data[:n * ch * 2])
    mono = [sum(samples[i * ch:(i + 1) * ch]) / ch for i in range(n)]
    return rate, mono


def rms(v):
    return math.sqrt(sum(x * x for x in v) / len(v)) if v else 0.0


def main():
    mame_path, rtl_path, mame_wav, rtl_wav, seconds = sys.argv[1:6]
    seconds = float(seconds)
    mame = read_log(mame_path, 1e12)
    rtl = read_log(rtl_path, 1e12)
    # align on the first SRST (MAME) = the bench's t=0 is when it started
    # replaying, so MAME time - first machine time... the bench replays at
    # MAME's absolute times, so both are on the same base already
    limit = seconds * 1e6
    ok = True
    for tag, name in (("YM", "YM2151"), ("PK1", "POKEY 1"), ("PK2", "POKEY 2"), ("RESP", "responses"), ("MIX", "mixer"), ("SEN", "sound enable")):
        m = [(e[0], e[2] & 0xf if tag.startswith("PK") else e[2] & 1, e[3]) for e in mame if e[1] == tag and e[0] <= limit]
        r = [(e[0], e[2] & 0xf if tag.startswith("PK") else e[2] & 1, e[3]) for e in rtl if e[1] == tag and e[0] <= limit]
        mseq = [(a, d) for _, a, d in m]
        rseq = [(a, d) for _, a, d in r]
        common = 0
        while common < len(mseq) and common < len(rseq) and mseq[common] == rseq[common]:
            common += 1
        ident = (mseq == rseq)
        print(f"{name} writes within {seconds:.1f} s: rtl {len(rseq)}, mame {len(mseq)}: {'IDENTICAL' if ident else 'DIFFER at index %d' % common}")
        if not ident:
            ok = False
            for i in range(max(0, common - 3), min(common + 5, len(mseq), len(rseq))):
                print(f"   {i}: mame {mseq[i][0]:x}={mseq[i][1]:02x} @ {m[i][0]:.0f}us   rtl {rseq[i][0]:x}={rseq[i][1]:02x} @ {r[i][0]:.0f}us")
        if common:
            offs = sorted(r[i][0] - m[i][0] for i in range(common))
            print(f"   timing offset rtl-mame over the matching prefix: median {offs[len(offs)//2]/1000:+.3f} ms, min {offs[0]/1000:+.3f}, max {offs[-1]/1000:+.3f}")
    # audio envelopes
    mr, mw = read_wav(mame_wav)
    rr, rw = read_wav(rtl_wav)
    win = 0.5
    n = int(min(len(mw) / mr, len(rw) / rr, seconds) / win)
    ratios = []
    print(f"audio: mame {len(mw)} samples at {mr} Hz, rtl {len(rw)} at {rr} Hz; peak mame {max(abs(x) for x in mw):.0f} rtl {max(abs(x) for x in rw):.0f}")
    for i in range(n):
        a = rms(mw[int(i * win * mr):int((i + 1) * win * mr)])
        b = rms(rw[int(i * win * rr):int((i + 1) * win * rr)])
        if a > 200:
            ratios.append(b / a)
    if ratios:
        ratios.sort()
        med = ratios[len(ratios) // 2]
        print(f"   envelope ratio rtl/mame over {len(ratios)} active {win} s windows: median {med:.3f} ({20*math.log10(med):+.2f} dB), min {ratios[0]:.3f}, max {ratios[-1]:.3f}")
        if not (0.84 < med < 1.19):
            ok = False
    print("PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
