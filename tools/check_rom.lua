-- Verify a built ssprint.rom (ROM=path, default artifacts/ssprint.rom) byte
-- for byte against MAME's loaded regions, gaps and the sprite inversion
-- included. Run: mame ssprint -rompath . -video none -sound none -nothrottle -autoboot_script tools/check_rom.lua
-- verify the built image against MAME's regions byte for byte
local m = manager.machine
local f = io.open(os.getenv("ROM") or "artifacts/ssprint.rom","rb"); local img = f:read("a"); f:close()
local function cmp(tag, imgoff, regoff, len)
  local r = m.memory.regions[tag]
  local bad = 0
  for i = 0, len-1 do
    local a = img:byte(imgoff + i + 1)
    local b = r:read_u8(regoff + i)
    if tag == ":sprites" then b = b end
    if a ~= b then bad = bad + 1; if bad < 4 then print(string.format("%s mismatch at %x: img %02x reg %02x", tag, i, a, b)) end end
  end
  print(string.format("%s: %d bytes, %d mismatches", tag, len, bad))
end
cmp(":maincpu", 0x0, 0x8000, 0x8000)
cmp(":maincpu", 0x8000, 0x10000, 0x80000)
cmp(":audiocpu", 0x88000, 0x8000, 0x8000)
cmp(":tiles", 0x90000, 0, 0x80000)
-- sprites are inverted in MAME's region
do
  local r = m.memory.regions[":sprites"]; local bad = 0
  for i = 0, 0x3ffff do local a = img:byte(0x110000 + i + 1); local b = r:read_u8(i) ~ 0xff; if a ~= b then bad = bad + 1 end end
  print(string.format(":sprites (inverted): %d mismatches", bad))
end
cmp(":chars", 0x150000, 0, 0x4000)
cmp(":eeprom", 0x154000, 0, 0x200)
m:exit()
