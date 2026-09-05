// Image format 2 layout (rtl/ssprint_pkg.sv, docs/hardware.md section 9)
#pragma once
#include <cstdint>
static const uint32_t IMG_HEADER = 0x000000, IMG_MAIN_FIXED = 0x000200, IMG_MAIN_BANK = 0x008200, IMG_SOUND = 0x088200,
                      IMG_TILES = 0x094200, IMG_SPRITES = 0x114200, IMG_CHARS = 0x214200, IMG_EEPROM = 0x218200, IMG_END = 0x218400;
static const uint32_t SD_MAIN_BANK = 0x000000, SD_TILES = 0x100000, SD_SPRITES = 0x200000;   // word addresses
