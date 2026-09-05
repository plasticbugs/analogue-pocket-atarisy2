//------------------------------------------------------------------------------
// Shared constants for the Super Sprint core: where the loader puts each part
// of the ROM image (docs/hardware.md section 9) and how the graphics ROMs are
// rearranged in SDRAM so that one tile row is one short burst.
//
// SDRAM word addresses (byte address >> 1):
//   0x000000  T11 banked program ROM, 64 x 8 KB, as the image (256K words)
//   0x100000  playfield tiles: word = {code[13:0], row[2:0], half}
//                 half 0 = planes 0/1 (image offset 0x00000 + code*16 + row*2),
//                 half 1 = planes 2/3 (image offset 0x40000 + ...); a tile row
//                 is 2 consecutive words
//   0x140000  motion objects: word = {code[10:0], row[3:0], half, w[0]}
//                 a 16-pixel row is 4 consecutive words (half 0 w0 w1, half 1
//                 w0 w1); bytes are stored inverted (ROMREGION_INVERT applied
//                 by the loader)
// The image byte offsets are in the same place (tools/mra_build.py layout).
//------------------------------------------------------------------------------
package ssprint_pkg;
    // ROM image byte offsets
    localparam logic [24:0] IMG_MAIN_FIXED = 25'h000000;   // 32 KB
    localparam logic [24:0] IMG_MAIN_BANK  = 25'h008000;   // 512 KB
    localparam logic [24:0] IMG_SOUND      = 25'h088000;   // 32 KB
    localparam logic [24:0] IMG_TILES      = 25'h090000;   // 512 KB
    localparam logic [24:0] IMG_SPRITES    = 25'h110000;   // 256 KB
    localparam logic [24:0] IMG_CHARS      = 25'h150000;   // 16 KB
    localparam logic [24:0] IMG_EEPROM     = 25'h154000;   // 512 B
    localparam logic [24:0] IMG_END        = 25'h154200;

    // SDRAM word addresses
    localparam logic [24:1] SD_MAIN_BANK = 24'h000000;
    localparam logic [24:1] SD_TILES     = 24'h100000;
    localparam logic [24:1] SD_SPRITES   = 24'h140000;

    // playfield tile row: 2 words at SD_TILES + {code, row, half}
    function automatic logic [24:1] pf_row_addr(input logic [13:0] code, input logic [2:0] row);
        pf_row_addr = SD_TILES + {6'd0, code, row, 1'b0};
    endfunction
    // motion object tile row: 4 words at SD_SPRITES + {code, row, half, w}
    function automatic logic [24:1] mo_row_addr(input logic [10:0] code, input logic [3:0] row);
        mo_row_addr = SD_SPRITES + {7'd0, code, row, 2'b00};
    endfunction
    // where the loader puts image byte `o` of the tiles region (o < 0x80000):
    // half = o[18], code = o[17:4], row = o[3:1], byte = o[0]
    function automatic logic [24:1] tiles_img_to_sd(input logic [18:0] o);
        tiles_img_to_sd = SD_TILES + {6'd0, o[17:4], o[3:1], o[18]};
    endfunction
    // sprites region (o < 0x40000): half = o[17], code = o[16:6], row = o[5:2], w = o[1], byte = o[0]
    function automatic logic [24:1] sprites_img_to_sd(input logic [17:0] o);
        sprites_img_to_sd = SD_SPRITES + {7'd0, o[16:6], o[5:2], o[17], o[1]};
    endfunction
endpackage
