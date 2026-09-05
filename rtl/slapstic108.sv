//------------------------------------------------------------------------------
// Atari slapstic 137412-108 as fitted to Super Sprint (docs/hardware.md
// section 6), from MAME's slapstic.cpp: the 103-110 state machine with the
// 108 table. Every T11 bus cycle presents its address here (`strobe` with
// `addr`, instruction fetches included); `bank` is the selected video RAM
// bank of the 2000-3fff window. Power-up bank 3.
//
// Addresses are T11 byte addresses; the chip's A0-A13 are the CPU's A1-A14,
// so bit 0 is ignored and the "/CS" range is 8000-81ff.
//------------------------------------------------------------------------------
`default_nettype none

module slapstic108 (
    input  logic        clk,
    input  logic        reset,
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

    wire [15:0] a = {addr[15:1], 1'b0};
    wire unused_a0 = &{1'b0, addr[0]};
    // the 108 table, masks and values already shifted onto CPU address bits
    wire t_reset  = (a == 16'h8000);
    // bank select words are 8050, 8054, 8058, 805c: value 0x28|b<<1 on A1.. -> byte address 0x8050 + 4b
    wire t_bank0  = (a == 16'h8050);
    wire t_bank1  = (a == 16'h8054);
    wire t_bank2  = (a == 16'h8058);
    wire t_bank3  = (a == 16'h805c);
    wire t_alt1   = (a & 16'h00fe) == 16'h003e;          // anywhere in memory
    wire t_alt2   = (a == 16'heee4);
    wire t_alt3   = (a & 16'hfff8) == 16'heec8;
    wire t_alt4   = (a & 16'hfff2) == 16'h8050;
    wire t_bit1   = (a & 16'hffe0) == 16'h80c0;
    wire t_bit2   = (a & 16'hfff2) == 16'h8050;
    wire t_b_c0   = (a & 16'hffe6) == 16'h80c0;          // "clear bit 0" on odd / "set bit 1" on even
    wire t_b_s0   = (a & 16'hffe6) == 16'h80c2;          // "set bit 0" / "clear bit 1"
    wire t_b_c1   = (a & 16'hffe6) == 16'h80c4;          // "clear bit 1" / "set bit 0"
    wire t_b_s1   = (a & 16'hffe6) == 16'h80c6;          // "set bit 1" / "clear bit 0"
    wire t_bit4   = (a & 16'hfff0) == 16'h80e0;

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
