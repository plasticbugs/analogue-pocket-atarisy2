-- Per-frame T11 / 6502 PC sample from power-on, to line the RTL's boot up
-- with MAME's (sim/run_system.sh prints the same per frame). Also prints a
-- few facts about the ROM regions. FRAMES=n (default 420).
local m = manager.machine
local cpu = m.devices[":maincpu"]
local snd = m.devices[":audiocpu"]
local frames = 0
local reg = m.memory.regions[":maincpu"]
print(string.format("region maincpu size %d, byte at 0x30000 = %02x, at 0x40000 = %02x, at 0x10000 = %02x", reg.size, reg:read_u8(0x30000), reg:read_u8(0x40000), reg:read_u8(0x10000)))
local sreg = m.memory.regions[":audiocpu"]
print(string.format("region audiocpu size %d, byte at 0x4000 = %02x at 0x8000 = %02x", sreg.size, sreg:read_u8(0x4000), sreg:read_u8(0x8000)))
emu.register_frame_done(function()
  frames = frames + 1
  if frames % 30 == 0 or frames < 10 then
    print(string.format("frame %d t11 PC %06o (%04x) SP %04x PSW %03o  6502 PC %04x", frames, cpu.state["PC"].value, cpu.state["PC"].value, cpu.state["SP"].value, cpu.state["PSW"].value, snd.state["PC"].value))
  end
  if frames >= tonumber(os.getenv("FRAMES") or "420") then m:exit() end
end)
