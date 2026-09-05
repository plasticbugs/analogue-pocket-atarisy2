//------------------------------------------------------------------------------
// Atari slapstic 137412-105 .. 110 (docs/hardware.md section 6), from MAME's
// slapstic.cpp: the 103-110 state machine with the chip's table selected at
// run time by `chip` (the image header's slapstic type). Every T11 bus cycle
// presents its address here (`strobe` with `addr`, instruction fetches
// included); `bank` is the selected video RAM bank of the 2000-3fff window.
// Power-up bank 3.
//
// MAME's checker, for a 16-bit CPU with the chip at 8000-81ff: the table's
// masks and values are in chip address units (A0-A13 = CPU A1-A14), so a
// "test_in" is (a & (0xfe00 | mask << 1)) == (0x8000 | value << 1), a
// "test_any" (the alternate sequence's first step) is the same without the
// range, the reset is (a & 0xfffe) == 0x8000 and a bank select is
// (a & 0xfffe) == 0x8000 | bank_value << 1. Bit 0 of the address is ignored.
// The alternate sequence's third step carries the bank in a[2:1] (altshift 0
// for all six chips).
//------------------------------------------------------------------------------
`default_nettype none

module slapstic (
    input  logic        clk,
    input  logic        reset,
    input  logic  [7:0] chip,           // 105, 107, 108, 109, 110 (106 is Gauntlet II; also here)
    input  logic        strobe,         // one clock per bus cycle, address valid
    input  logic [15:0] addr,
    output logic  [1:0] bank,
    // bench only: load a known bank (a trace window that starts mid-game); tie init_en low
    input  logic        init_en,
    input  logic  [1:0] init_bank
);
    typedef enum logic [3:0] {
        IDLE, ACTIVE, ALT_VALID, ALT_SELECT, ALT_COMMIT, BIT_LOAD, BIT_SET_ODD, BIT_SET_EVEN
    } st_t;
    st_t  st;
    logic [1:0] loaded;

    // the table: bank select values, then mask/value pairs (chip address units)
    typedef struct packed {
        logic [13:0] b0, b1, b2, b3;
        logic [13:0] alt1_m, alt1_v, alt2_m, alt2_v, alt3_m, alt3_v, alt4_m, alt4_v;
        logic [13:0] bit1_m, bit1_v, bit2_m, bit2_v;
        logic [13:0] bit3_m, bit3_c0, bit3_s0, bit3_c1, bit3_s1;    // bit3 shares one mask; values c0/s0/c1/s1
        logic [13:0] bit4_m, bit4_v;
    } tab_t;
    tab_t t;
    always_comb begin
        case (chip)
            8'd105:  t = '{14'h0010, 14'h0014, 14'h0018, 14'h001c,  14'h007f, 14'h003d, 14'h3fff, 14'h0092, 14'h3ffc, 14'h00a4, 14'h3ff3, 14'h0010,
                          14'h3ff0, 14'h35b0, 14'h3ff3, 14'h0010,  14'h3ff3, 14'h35b0, 14'h35b1, 14'h35b2, 14'h35b3,  14'h3ff8, 14'h35c0};
            8'd106:  t = '{14'h0008, 14'h000a, 14'h000c, 14'h000e,  14'h007f, 14'h002b, 14'h3fff, 14'h0052, 14'h3ffc, 14'h0064, 14'h3ff9, 14'h0008,
                          14'h3ff0, 14'h3da0, 14'h3ff9, 14'h0008,  14'h3ff3, 14'h3da0, 14'h3da1, 14'h3da2, 14'h3da3,  14'h3ff8, 14'h3db0};
            8'd107:  t = '{14'h0018, 14'h001a, 14'h001c, 14'h001e,  14'h007f, 14'h006b, 14'h3fff, 14'h3d52, 14'h3ffc, 14'h3d64, 14'h3ff9, 14'h0018,
                          14'h3ff0, 14'h00a0, 14'h3ff9, 14'h0018,  14'h3ff3, 14'h00a0, 14'h00a1, 14'h00a2, 14'h00a3,  14'h3ff8, 14'h00b0};
            8'd109:  t = '{14'h0008, 14'h000a, 14'h000c, 14'h000e,  14'h007f, 14'h002b, 14'h3fff, 14'h0052, 14'h3ffc, 14'h0064, 14'h3ff9, 14'h0008,
                          14'h3ff0, 14'h3da0, 14'h3ff9, 14'h0008,  14'h3ff3, 14'h3da0, 14'h3da1, 14'h3da2, 14'h3da3,  14'h3ff8, 14'h3db0};
            8'd110:  t = '{14'h0040, 14'h0050, 14'h0060, 14'h0070,  14'h007f, 14'h002d, 14'h3fff, 14'h3d14, 14'h3ffc, 14'h3d24, 14'h3fcf, 14'h0040,
                          14'h3ff0, 14'h34c0, 14'h3fcf, 14'h0040,  14'h3ff3, 14'h34c0, 14'h34c1, 14'h34c2, 14'h34c3,  14'h3ff8, 14'h34d0};
            default: t = '{14'h0028, 14'h002a, 14'h002c, 14'h002e,  14'h007f, 14'h001f, 14'h3fff, 14'h3772, 14'h3ffc, 14'h3764, 14'h3ff9, 14'h0028,   // 108
                          14'h3ff0, 14'h0060, 14'h3ff9, 14'h0028,  14'h3ff3, 14'h0060, 14'h0061, 14'h0062, 14'h0063,  14'h3ff8, 14'h0070};
        endcase
    end

    wire [15:0] a = {addr[15:1], 1'b0};
    wire unused_a0 = &{1'b0, addr[0]};
    function automatic logic t_in(input logic [15:0] ad, input logic [13:0] m, input logic [13:0] v);
        t_in = ((ad & (16'hfe00 | {1'b0, m, 1'b0})) == (16'h8000 | {1'b0, v, 1'b0}));
    endfunction
    function automatic logic t_any(input logic [15:0] ad, input logic [13:0] m, input logic [13:0] v);
        t_any = ((ad & {1'b0, m, 1'b0}) == {1'b0, v, 1'b0});
    endfunction
    wire t_reset = ((a & 16'hfffe) == 16'h8000);
    wire t_bank0 = ((a & 16'hfffe) == (16'h8000 | {1'b0, t.b0, 1'b0}));
    wire t_bank1 = ((a & 16'hfffe) == (16'h8000 | {1'b0, t.b1, 1'b0}));
    wire t_bank2 = ((a & 16'hfffe) == (16'h8000 | {1'b0, t.b2, 1'b0}));
    wire t_bank3 = ((a & 16'hfffe) == (16'h8000 | {1'b0, t.b3, 1'b0}));
    wire t_alt1  = t_any(a, t.alt1_m, t.alt1_v);          // anywhere in memory
    wire t_alt2  = t_in(a, t.alt2_m, t.alt2_v);
    wire t_alt3  = t_in(a, t.alt3_m, t.alt3_v);
    wire t_alt4  = t_in(a, t.alt4_m, t.alt4_v);
    wire t_bit1  = t_in(a, t.bit1_m, t.bit1_v);
    wire t_bit2  = t_in(a, t.bit2_m, t.bit2_v);
    wire t_b_c0  = t_in(a, t.bit3_m, t.bit3_c0);          // "clear bit 0" on odd / "set bit 1" on even
    wire t_b_s0  = t_in(a, t.bit3_m, t.bit3_s0);          // "set bit 0" / "clear bit 1"
    wire t_b_c1  = t_in(a, t.bit3_m, t.bit3_c1);          // "clear bit 1" / "set bit 0"
    wire t_b_s1  = t_in(a, t.bit3_m, t.bit3_s1);          // "set bit 1" / "clear bit 0"
    wire t_bit4  = t_in(a, t.bit4_m, t.bit4_v);

    always_ff @(posedge clk) begin
        if (reset) begin
            st <= IDLE; bank <= 2'd3; loaded <= 2'd0;
        end else if (init_en) begin
            st <= IDLE; bank <= init_bank;
        end else if (strobe) begin
            case (st)
                IDLE: if (t_reset) st <= ACTIVE;
                ACTIVE: begin
                    if      (t_bank0) begin bank <= 2'd0; st <= IDLE; end
                    else if (t_bank1) begin bank <= 2'd1; st <= IDLE; end
                    else if (t_bank2) begin bank <= 2'd2; st <= IDLE; end
                    else if (t_bank3) begin bank <= 2'd3; st <= IDLE; end
                    else if (t_alt1)  st <= ALT_VALID;
                    else if (t_bit1)  st <= BIT_LOAD;
                end
                ALT_VALID: begin
                    if (t_reset)     st <= ACTIVE;
                    else if (t_alt2) st <= ALT_SELECT;
                    else             st <= ACTIVE;
                end
                ALT_SELECT: begin
                    if (t_reset)     st <= ACTIVE;
                    else if (t_alt3) begin loaded <= a[2:1]; st <= ALT_COMMIT; end
                    else             st <= ACTIVE;
                end
                ALT_COMMIT: begin
                    if (t_reset)     st <= ACTIVE;
                    else if (t_alt4) begin bank <= loaded; st <= IDLE; end
                end
                BIT_LOAD: begin
                    if (t_reset)     st <= ACTIVE;
                    else if (t_bit2) begin loaded <= bank; st <= BIT_SET_ODD; end
                end
                BIT_SET_ODD: begin
                    if (t_reset)      st <= ACTIVE;
                    else if (t_b_c0)  begin loaded[0] <= 1'b0; st <= BIT_SET_EVEN; end
                    else if (t_b_s0)  begin loaded[0] <= 1'b1; st <= BIT_SET_EVEN; end
                    else if (t_b_c1)  begin loaded[1] <= 1'b0; st <= BIT_SET_EVEN; end
                    else if (t_b_s1)  begin loaded[1] <= 1'b1; st <= BIT_SET_EVEN; end
                    else if (t_bit4)  begin bank <= loaded; st <= IDLE; end
                end
                BIT_SET_EVEN: begin
                    // the same four addresses with the roles swapped
                    if (t_reset)      st <= ACTIVE;
                    else if (t_b_s1)  begin loaded[0] <= 1'b0; st <= BIT_SET_ODD; end
                    else if (t_b_c1)  begin loaded[0] <= 1'b1; st <= BIT_SET_ODD; end
                    else if (t_b_s0)  begin loaded[1] <= 1'b0; st <= BIT_SET_ODD; end
                    else if (t_b_c0)  begin loaded[1] <= 1'b1; st <= BIT_SET_ODD; end
                    else if (t_bit4)  begin bank <= loaded; st <= IDLE; end
                end
                default: st <= IDLE;
            endcase
        end
    end
endmodule

`default_nettype wire
