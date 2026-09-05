#!/usr/bin/env python3
"""Reference renderer: re-create a MAME frame from a dumped video state.

Reads the state written by tools/dumpstate.lua (palette, alphanumerics,
motion objects, both playfield halves, scroll registers), decodes the tile
graphics from the ROM image built by tools/mra_build.py, and produces the
512x384 frame exactly as atarisy2_v.cpp + atarimo.cpp + tilemap.cpp would
(docs/hardware.md section 5), then diffs it against the MAME snapshot PNG
taken at the same frame.

    render_model.py <state.txt> <ssprint.rom> <mame.png> [out_prefix]

Writes <out_prefix>_model.png and <out_prefix>_diff.png and prints the number
of differing pixels. Pure Python (zlib only).
"""
import sys, zlib, struct

W, H = 512, 384

ROM_TILES = 0x090000     # 512 KB, playfield
ROM_MO = 0x110000        # 256 KB, motion objects (inverted)
ROM_CHARS = 0x150000     # 16 KB, alphanumerics


def read_state(path):
    st = {"palette": [], "alpha": [], "mob": [], "pft": [], "pfb": []}
    sec = None
    with open(path) as f:
        for line in f:
            t = line.split()
            if not t:
                continue
            if t[0] in ("PALETTE", "ALPHA", "MOB", "PFT", "PFB"):
                sec = t[0].lower(); continue
            if t[0] in ("XSCROLL", "YSCROLL", "YSCROLL_LINE", "FRAME"):
                st[t[0].lower()] = int(t[1], 16 if t[0] in ("XSCROLL", "YSCROLL") else 10); continue
            st[sec].append(int(t[0], 16))
    return st


# ---- palette (RRRRGGGGBBBBIIII) -------------------------------------------
_ZB, _Z3, _Z2, _Z1, _Z0 = 115, 78, 37, 17, 9
INTENSITY = [0] + [_ZB + (_Z3 if i & 8 else 0) + (_Z2 if i & 4 else 0) + (_Z1 if i & 2 else 0) + (_Z0 if i & 1 else 0) for i in range(1, 16)]
COLOUR = [0x0, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xe, 0xf, 0xf]


def pal_rgb(raw):
    i = INTENSITY[raw & 15]
    return ((COLOUR[(raw >> 12) & 15] * i) >> 4, (COLOUR[(raw >> 8) & 15] * i) >> 4, (COLOUR[(raw >> 4) & 15] * i) >> 4)


# ---- graphics decode (MAME gfx_layout bit numbering: bit 0 = MSB of byte 0) --
class Gfx:
    """Decodes 4-bit-per-pixel tiles laid out as two 2-plane halves (pflayout,
    molayout) or 2bpp single-half (anlayout). Rows are `bpr` bytes per half;
    byte k of a row covers pixels 4k..4k+3, high nibble = the lower-numbered
    plane, which is the MORE significant pen bit."""

    def __init__(self, rom, base, half, width, height, planes4, invert=False):
        self.rom, self.base, self.half = rom, base, half
        self.w, self.h = width, height
        self.bpr = width // 4                    # bytes per row per half
        self.tsize = self.bpr * height           # bytes per tile per half
        self.planes4 = planes4
        self.inv = 0xff if invert else 0
        self.count = half // self.tsize if planes4 else (0x4000 // self.tsize)
        self.cache = {}

    def tile(self, code):
        code %= self.count
        t = self.cache.get(code)
        if t is not None:
            return t
        rows = []
        a0 = self.base + code * self.tsize
        a1 = a0 + self.half
        for y in range(self.h):
            row = []
            for x in range(self.w):
                # MAME numbers plane 0 as the MOST significant pen bit
                # (decode_tile: pen |= bit << (planes-1-plane)); plane 0 is the
                # first half's high nibble, plane 1 its low nibble, planes 2 and
                # 3 the second half's high and low nibbles; pixel 0 is the
                # nibble's MSB.
                k, b = x >> 2, 7 - (x & 3)
                v0 = self.rom[a0 + y * self.bpr + k] ^ self.inv
                p0 = (v0 >> b) & 1
                p1 = (v0 >> (b - 4)) & 1
                if self.planes4:
                    v1 = self.rom[a1 + y * self.bpr + k] ^ self.inv
                    p2 = (v1 >> b) & 1
                    p3 = (v1 >> (b - 4)) & 1
                    row.append(p0 << 3 | p1 << 2 | p2 << 1 | p3)
                else:
                    row.append(p0 << 1 | p1)
            rows.append(row)
        self.cache[code] = rows
        return rows


def render(st, rom):
    pal = [pal_rgb(v) for v in st["palette"]]
    pf_gfx = Gfx(rom, ROM_TILES, 0x40000, 8, 8, True)
    mo_gfx = Gfx(rom, ROM_MO, 0x20000, 16, 16, True, invert=True)
    an_gfx = Gfx(rom, ROM_CHARS, 0, 8, 8, False)
    xs, ys = st["xscroll"], st["yscroll"]
    bank = [xs & 0xf, ys & 0xf]
    scrollx = (xs >> 6) & 0x3ff
    scrolly = (ys >> 6) & 0x1ff
    if not (ys & 0x10):
        # clocked in at once: the beam line at the write shows playfield line yscroll
        scrolly = (scrolly - st.get("yscroll_line", 0)) & 0x1ff

    # playfield: palette index and category per pixel (opaque)
    pf_idx = [[0] * W for _ in range(H)]
    pf_cat = [[0] * W for _ in range(H)]
    for ty in range(H // 8 + 1):
        row = (ty + (scrolly >> 3)) & 63
        for tx in range(W // 8 + 1):
            col = (tx + (scrollx >> 3)) & 127
            w = st["pft"][row * 128 + col] if row < 32 else st["pfb"][(row - 32) * 128 + col]
            code = (bank[(w >> 10) & 1] << 10) | (w & 0x3ff)
            colour = (w >> 11) & 7
            cat = (~w >> 14) & 3
            tile = pf_gfx.tile(code)
            base = 128 + colour * 16
            for yy in range(8):
                sy = ty * 8 + yy - (scrolly & 7)
                if sy < 0 or sy >= H:
                    continue
                for xx in range(8):
                    sx = tx * 8 + xx - (scrollx & 7)
                    if sx < 0 or sx >= W:
                        continue
                    pf_idx[sy][sx] = base + tile[yy][xx]
                    pf_cat[sy][sx] = cat

    # motion objects: linked list from entry 0, later entries overwrite
    mo = [[None] * W for _ in range(H)]      # (palette index, priority)
    mob = st["mob"]
    link, visited, order = 0, set(), []
    while link not in visited and len(order) < 1024:
        visited.add(link)
        e = mob[link * 4:link * 4 + 4]
        order.append(e)
        link = (e[3] >> 3) & 0xff
    last_x = 0
    for e in order:
        code = ((e[0] & 7) << 11) | (e[1] & 0x7ff)
        ypos = (e[0] >> 6) & 0x1ff
        hflip = (e[1] >> 14) & 1
        height = ((e[1] >> 11) & 7) + 1
        hold = (e[1] >> 15) & 1
        xpos = (e[2] >> 6) & 0x3ff
        colour = (e[3] >> 12) & 3
        prio = (e[3] >> 14) & 3
        y = (-ypos - height * 16) & 0x1ff
        if hold:
            xpos = (last_x + 16)
        last_x = xpos
        x = xpos & 0x3ff
        if x >= W:
            x -= 1024
        if y >= H:
            y -= 512
        base = colour * 16
        for t in range(height):
            tile = mo_gfx.tile(code + t)
            for yy in range(16):
                sy = y + t * 16 + yy
                if sy < 0 or sy >= H:
                    continue
                for xx in range(16):
                    sx = x + xx
                    if sx < 0 or sx >= W:
                        continue
                    pen = tile[yy][15 - xx] if hflip else tile[yy][xx]
                    if pen != 15:
                        mo[sy][sx] = (base + pen, prio)

    # merge, then the alphanumerics on top
    out = []
    for y in range(H):
        row = []
        for x in range(W):
            idx = pf_idx[y][x]
            m = mo[y][x]
            if m is not None:
                if ((m[1] + pf_cat[y][x]) & 2):
                    if not (idx & 8):
                        idx = m[0]
                else:
                    idx = m[0]
            row.append(idx)
        out.append(row)
    for ty in range(H // 8):
        for tx in range(W // 8):
            w = st["alpha"][ty * 64 + tx]
            code = w & 0x3ff
            colour = (w >> 13) & 7
            tile = an_gfx.tile(code)
            base = 64 + colour * 4
            for yy in range(8):
                for xx in range(8):
                    pen = tile[yy][xx]
                    if pen:
                        out[ty * 8 + yy][tx * 8 + xx] = base + pen
    return [[pal[i] for i in row] for row in out]


# ---- PNG I/O (8-bit RGB, no numpy) -----------------------------------------
def read_png(path):
    data = open(path, "rb").read()
    assert data[:8] == b"\x89PNG\r\n\x1a\n"
    pos, idat, w, h, ct, bd, pal = 8, b"", 0, 0, 0, 0, None
    while pos < len(data):
        ln, = struct.unpack(">I", data[pos:pos + 4]); typ = data[pos + 4:pos + 8]; body = data[pos + 8:pos + 8 + ln]
        if typ == b"IHDR":
            w, h, bd, ct = struct.unpack(">IIBB", body[:10])
        elif typ == b"PLTE":
            pal = [tuple(body[i:i + 3]) for i in range(0, len(body), 3)]
        elif typ == b"IDAT":
            idat += body
        pos += 12 + ln
    raw = zlib.decompress(idat)
    bpp = {2: 3, 6: 4, 3: 1, 0: 1}[ct]
    stride = w * bpp
    rows, prev, p = [], bytearray(stride), 0
    for y in range(h):
        flt = raw[p]; cur = bytearray(raw[p + 1:p + 1 + stride]); p += 1 + stride
        for i in range(stride):
            a = cur[i - bpp] if i >= bpp else 0
            b = prev[i]
            c = prev[i - bpp] if i >= bpp else 0
            if flt == 1: cur[i] = (cur[i] + a) & 255
            elif flt == 2: cur[i] = (cur[i] + b) & 255
            elif flt == 3: cur[i] = (cur[i] + ((a + b) >> 1)) & 255
            elif flt == 4:
                pa, pb, pc = abs(b - c), abs(a - c), abs(a + b - 2 * c)
                pr = a if (pa <= pb and pa <= pc) else (b if pb <= pc else c)
                cur[i] = (cur[i] + pr) & 255
        if ct == 3:
            rows.append([pal[v] for v in cur])
        else:
            rows.append([tuple(cur[i:i + 3]) for i in range(0, stride, bpp)])
        prev = cur
    return rows


def write_png(path, rows):
    h, w = len(rows), len(rows[0])
    raw = b"".join(b"\x00" + bytes(c for px in row for c in px) for row in rows)
    def chunk(t, d):
        return struct.pack(">I", len(d)) + t + d + struct.pack(">I", zlib.crc32(t + d) & 0xffffffff)
    with open(path, "wb") as f:
        f.write(b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 2, 0, 0, 0))
                + chunk(b"IDAT", zlib.compress(raw, 6)) + chunk(b"IEND", b""))


def diff(model, ref):
    n, first, img = 0, [], []
    for y in range(min(len(model), len(ref))):
        row = []
        for x in range(min(len(model[0]), len(ref[0]))):
            if model[y][x] != ref[y][x]:
                n += 1
                if len(first) < 8:
                    first.append((x, y, model[y][x], ref[y][x]))
                row.append((255, 0, 255))
            else:
                v = sum(model[y][x]) // 6
                row.append((v, v, v))
        img.append(row)
    return n, first, img


def main():
    if len(sys.argv) < 4:
        sys.exit(__doc__)
    st = read_state(sys.argv[1])
    rom = open(sys.argv[2], "rb").read()
    ref = read_png(sys.argv[3])
    prefix = sys.argv[4] if len(sys.argv) > 4 else "model"
    model = render(st, rom)
    write_png(prefix + "_model.png", model)
    n, first, img = diff(model, ref)
    write_png(prefix + "_diff.png", img)
    print(f"{sys.argv[1]}: {n} differing pixels of {W * H}")
    for f in first:
        print("  x=%d y=%d model=%s mame=%s" % f)
    return 0 if n == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
