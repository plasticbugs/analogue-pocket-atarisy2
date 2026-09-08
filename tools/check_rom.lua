-- Verify a built image (ROM=path) byte for byte against MAME's loaded
-- regions -- gaps, the sprite inversion and the header included. Run with the
-- game the image is for:
--   ROM=artifacts/ssprint.rom mame ssprint -rompath . -video none -sound none -nothrottle -autoboot_script tools/check_rom.lua
--   ROM=artifacts/apb.rom     mame apb     -rompath . ...
-- Image format 2 (docs/hardware.md section 9): fixed slots after a 512-byte
-- header; a sprite region smaller than its 1 MB slot keeps its two plane
-- halves at slot offsets 0 and 0x80000.
local m = manager.machine
local f = io.open(os.getenv("ROM") or "artifacts/ssprint.rom","rb"); local img = f:read("a"); f:close()
local IMG = { fixed = 0x000200, bank = 0x008200, sound = 0x088200, tiles = 0x094200, sprites = 0x114200, chars = 0x214200, eeprom = 0x218200, size = 0x218400 }
local total = 0
local function cmp(tag, imgoff, regoff, len, invert)
  local r = m.memory.regions[tag]
  if r == nil then print(tag .. ": no such region (skipped)"); return end
  local bad = 0
  for i = 0, len-1 do
    local a = img:byte(imgoff + i + 1)
    local b = r:read_u8(regoff + i)
    if invert then b = b ~ 0xff end
    if a ~= b then bad = bad + 1; if bad < 4 then print(string.format("%s mismatch at img %x (region +%x): img %02x reg %02x", tag, imgoff + i, regoff + i, a, b)) end end
  end
  total = total + bad
  print(string.format("%s: %d bytes%s, %d mismatches", tag, len, invert and " (inverted)" or "", bad))
end
-- header
local magic = img:sub(1, 4)
print(string.format("header: magic %s, format %d, game %d, slapstic %d, flags %#x, pf/mo code bits %d/%d, name %q; image %d bytes (%s)",
  magic, img:byte(5), img:byte(6), img:byte(7), img:byte(8), img:byte(9), img:byte(10), img:sub(17, 48):gsub("%z", ""), #img, #img == IMG.size and "expected size" or "WRONG SIZE"))
if magic ~= "ASY2" or img:byte(5) ~= 2 then total = total + 1; print("header: bad magic/format") end
cmp(":maincpu", IMG.fixed, 0x8000, 0x8000)
cmp(":maincpu", IMG.bank, 0x10000, 0x80000)
cmp(":audiocpu", IMG.sound, 0x4000, 0xc000)
local tl = m.memory.regions[":tiles"].size
if tl >= 0x80000 then
  cmp(":tiles", IMG.tiles, 0, 0x80000)
else
  -- a smaller region: its two plane halves at slot offsets 0 and 0x40000, zeros between (as the sprites)
  cmp(":tiles", IMG.tiles, 0, tl // 2)
  cmp(":tiles", IMG.tiles + 0x40000, tl // 2, tl // 2)
  local pad = 0
  for i = tl // 2, 0x3ffff do if img:byte(IMG.tiles + i + 1) ~= 0 then pad = pad + 1 end end
  for i = 0x40000 + tl // 2, 0x7ffff do if img:byte(IMG.tiles + i + 1) ~= 0 then pad = pad + 1 end end
  total = total + pad
  print(string.format(":tiles padding: %d nonzero bytes", pad))
end
local spr = m.memory.regions[":sprites"]
local sprlen = spr.size
if sprlen >= 0x100000 then
  cmp(":sprites", IMG.sprites, 0, 0x100000, true)
else
  -- two halves of a smaller region at slot offsets 0 and 0x80000, zeros between
  cmp(":sprites", IMG.sprites, 0, sprlen // 2, true)
  cmp(":sprites", IMG.sprites + 0x80000, sprlen // 2, sprlen // 2, true)
  local pad = 0
  for i = sprlen // 2, 0x7ffff do if img:byte(IMG.sprites + i + 1) ~= 0 then pad = pad + 1 end end
  for i = 0x80000 + sprlen // 2, 0xfffff do if img:byte(IMG.sprites + i + 1) ~= 0 then pad = pad + 1 end end
  total = total + pad
  print(string.format(":sprites padding: %d nonzero bytes", pad))
end
local cl = m.memory.regions[":chars"].size
cmp(":chars", IMG.chars, 0, cl)
if cl < 0x4000 then
  -- an 8 KB character ROM is stored twice so codes wrap at 512 as MAME's do
  local bad = 0
  for i = 0, 0x3fff - cl do if img:byte(IMG.chars + cl + i + 1) ~= img:byte(IMG.chars + (i % cl) + 1) then bad = bad + 1 end end
  total = total + bad
  print(string.format(":chars mirror: %d mismatches", bad))
end
if m.memory.regions[":eeprom"] then cmp(":eeprom", IMG.eeprom, 0, 0x200)
else
  local bad = 0
  for i = 0, 0x1ff do if img:byte(IMG.eeprom + i + 1) ~= 0xff then bad = bad + 1 end end
  total = total + bad
  print(string.format(":eeprom: no factory image in MAME, image holds 0xff: %d mismatches", bad))
end
print(total == 0 and "ROM CHECK PASS" or ("ROM CHECK FAIL: " .. total))
m:exit()
