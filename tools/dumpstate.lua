-- Dump the Super Sprint video state (palette, alpha, motion objects, both
-- playfield halves, scroll registers) at given frames, plus a MAME snapshot
-- of the same frame, for tools/render_model.py and the RTL video bench.
--   OUTDIR=dir FRAMES=600,1000 COIN=frame START=frame WHEEL=n PEDAL=n
local m = manager.machine
local frames = 0
local outdir = os.getenv("OUTDIR") or "."
local targets = {}
for t in string.gmatch(os.getenv("FRAMES") or "600", "%d+") do targets[tonumber(t)] = true end
local coin_f  = tonumber(os.getenv("COIN") or "-1")
local start_f = tonumber(os.getenv("START") or "-1")
local wheel   = tonumber(os.getenv("WHEEL") or "-1")
local pedal   = tonumber(os.getenv("PEDAL") or "-1")
local ports = m.ioport.ports
local sp = m.devices[":maincpu"].spaces["program"]
-- the scroll registers are written through handlers; tap them so the last
-- value written and the beam position at that write are known
local xscroll, yscroll, yscroll_line = 0, 0, 0
local last_x, last_y = 0, 0
local screen = m.screens[":screen"]
local scan_s = screen.scan_period   -- seconds, a plain number in this MAME
local t0 = m.time
local function beam_line() return math.floor((m.time - t0):as_double() / scan_s) end
-- taps must live in a global or Lua collects them after their first events
taps = {}
taps.x = sp:install_write_tap(0x1700, 0x177f, "xs", function(offset, data, mask) xscroll = data end)
taps.y = sp:install_write_tap(0x1780, 0x17ff, "ys", function(offset, data, mask) yscroll = data; yscroll_line = beam_line() end)
local function dump_share(f, tag, name, nwords)
  local s = m.memory.shares[tag]
  f:write(name .. "\n")
  for i = 0, nwords - 1 do f:write(string.format("%04x\n", s:read_u16(i * 2))) end
end
local function dump(tag)
  local f = io.open(string.format("%s/%s.txt", outdir, tag), "w")
  -- the registers themselves come from MAME's shares (the tap's data
  -- argument was seen to disagree with them); the tap only supplies the line
  local xs = m.memory.shares[":xscroll"]:read_u16(0)
  local ys = m.memory.shares[":yscroll"]:read_u16(0)
  f:write(string.format("XSCROLL %04x\nYSCROLL %04x\nYSCROLL_LINE %d\nFRAME %d\n", xs, ys, yscroll_line, frames))
  dump_share(f, ":palette", "PALETTE", 256)
  dump_share(f, ":alpha", "ALPHA", 3072)
  dump_share(f, ":mob", "MOB", 1024)
  dump_share(f, ":playfieldt", "PFT", 4096)
  dump_share(f, ":playfieldb", "PFB", 4096)
  f:close()
  print(string.format("dumped %s (xscroll %04x yscroll %04x, last y write at line %d)", tag, m.memory.shares[":xscroll"]:read_u16(0), m.memory.shares[":yscroll"]:read_u16(0), yscroll_line))
end
local last = 0
for k in pairs(targets) do if k > last then last = k end end
emu.register_frame_done(function()
  frames = frames + 1
  t0 = m.time
  if targets[frames] then
    dump(string.format("f%05d", frames))
    m.video:snapshot()
  end
  for k = 0, tonumber(os.getenv("COINS") or "1") - 1 do   -- COINS=n: n coins, 20 frames apart
    if frames == coin_f + 20 * k then ports[":IN1"].fields["Coin 1"]:set_value(1) end
    if frames == coin_f + 20 * k + 10 then ports[":IN1"].fields["Coin 1"]:clear_value() end
  end
  for k = 0, tonumber(os.getenv("STARTS") or "1") - 1 do   -- STARTS=n: n presses, 60 frames apart
    if frames == start_f + 60 * k then ports[":IN0"].fields[os.getenv("START_FIELD") or "1 Player Start"]:set_value(1) end
    if frames == start_f + 60 * k + 10 then ports[":IN0"].fields[os.getenv("START_FIELD") or "1 Player Start"]:clear_value() end
  end
  if pedal >= 0 and frames == start_f + 60 then for _, fl in pairs(ports[":ADC0"].fields) do fl:set_value(pedal) end end
  if wheel >= 0 and frames == start_f + 60 then for _, fl in pairs(ports[":LETA0"].fields) do fl:set_value(wheel) end end
  if frames > last + 2 then m:exit() end
end)
