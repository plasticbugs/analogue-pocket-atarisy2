//------------------------------------------------------------------------------
// Atari System 2 video for Super Sprint (docs/hardware.md section 5): the
// 512x384 raster at 16 MHz, the 128x64 playfield, the 64x48 alphanumerics,
// the linked-list motion objects and the 256-entry RRRRGGGGBBBBIIII palette,
// written from tools/render_model.py (the executable spec, pixel-identical
// to MAME) and checked against it by sim/run_video.sh.
//
// Structure: each raster line is rendered one line ahead into line buffers
// (playfield: palette index + priority category; motion objects: index,
// priority, valid; alphanumerics: index, valid) by two engines that share
// the SDRAM burst port -- the playfield/alpha engine and the motion object
// engine -- and the scan-out merges the three buffers with the priority rule
// of atarisy2_v.cpp and looks the palette up. The video RAMs are true
// dual-port block RAMs with the CPU on port A. Tile graphics come from SDRAM
// laid out so one tile row is one 2-word (playfield) or 4-word (motion
// object) burst (rtl/ssprint_pkg.sv); the 16 KB character ROM is block RAM.
//
// Motion objects are evaluated per line by walking the list from entry 0 as
// the hardware does (MAME walks it per 64-line band); the frozen-state gate
// covers frames where the list did not change mid-frame.
//------------------------------------------------------------------------------
`default_nettype none

module ssprint_video
    import ssprint_pkg::*;
(
    input  logic        clk,
    input  logic        reset,
    input  logic        cen_pix,           // 16 MHz

    // CPU port into the video RAMs: word address, one-hot selects held for
    // the access; cpu_rdata is valid two clocks after the access is presented
    input  logic [11:0] cpu_addr,
    input  logic        cpu_we,
    input  logic  [1:0] cpu_be,
    input  logic [15:0] cpu_wdata,
    input  logic        sel_pal, sel_alpha, sel_mob, sel_pft, sel_pfb,
    output logic [15:0] cpu_rdata,

    // scroll / tile bank registers (the 1700 / 1780 writes)
    input  logic        xscroll_we, yscroll_we,
    input  logic [15:0] scroll_wdata,

    // character ROM load (bytes)
    input  logic        chr_we,
    input  logic [13:0] chr_waddr,
    input  logic  [7:0] chr_wdata,
    // tile code widths from the image header: a code wraps at 2^bits, as
    // MAME's gfx element count does (Super Sprint 14 / 11, APB 14 / 13)
    input  logic  [3:0] cfg_pf_bits,
    input  logic  [3:0] cfg_mo_bits,

    // SDRAM burst port
    output logic [24:1] b_addr,
    output logic  [9:0] b_len,
    output logic        b_req,
    input  logic        b_wr,
    input  logic  [9:0] b_idx,
    input  logic [15:0] b_data,
    input  logic        b_done,

    // video out, valid on cen_pix
    output logic  [7:0] r, g, b,
    output logic        hsync, vsync, hblank, vblank, de,
    output logic  [8:0] vcount,
    output logic        irq_32v,           // one-clock pulses at the start of lines 0, 64, ... 384
    output logic        irq_vbl,           // ... and of line 384
    output logic        line_late          // sticky: a line's render was still running when its scan-out began
);
    // ------------------------------------------------------------------------
    // raster
    // ------------------------------------------------------------------------
    logic [9:0] hcnt;
    logic [8:0] vcnt;
    always_ff @(posedge clk) begin
        if (reset) begin hcnt <= '0; vcnt <= '0; end
        else if (cen_pix) begin
            if (hcnt == 10'd639) begin
                hcnt <= '0;
                vcnt <= (vcnt == 9'd415) ? 9'd0 : vcnt + 9'd1;
            end else hcnt <= hcnt + 10'd1;
        end
    end
    assign vcount = vcnt;
    wire sol = cen_pix && (hcnt == 10'd639);              // the next pixel is hcnt 0 of the next line
    wire [8:0] vnext = (vcnt == 9'd415) ? 9'd0 : vcnt + 9'd1;
    // the line about to start is `vnext`; render vnext + 1 into the other buffer
    wire [8:0] rl_next = (vnext == 9'd415) ? 9'd0 : vnext + 9'd1;
    always_ff @(posedge clk) begin
        irq_32v <= sol && (vnext[5:0] == 6'd0);
        irq_vbl <= sol && (vnext == 9'd384);
    end

    // ------------------------------------------------------------------------
    // scroll registers
    // ------------------------------------------------------------------------
    logic [9:0] scrollx;
    logic [8:0] scrolly;
    logic [8:0] pend_y;
    logic       pend_valid;
    logic [3:0] bank0, bank1;
    always_ff @(posedge clk) begin
        if (reset) begin
            scrollx <= '0; scrolly <= '0; pend_y <= '0; pend_valid <= 1'b0; bank0 <= '0; bank1 <= '0;
        end else begin
            if (xscroll_we) begin scrollx <= scroll_wdata[15:6]; bank0 <= scroll_wdata[3:0]; end
            if (yscroll_we) begin
                bank1 <= scroll_wdata[3:0];
                if (scroll_wdata[4]) begin pend_y <= scroll_wdata[15:7]; pend_valid <= 1'b1; end
                else scrolly <= scroll_wdata[15:7] - vcnt;          // clocked in at once: this line shows row yscroll
            end
            // a held value takes effect at the top of the next frame: the render
            // of line 0 starts one line early, so apply it when that render starts
            if (sol && rl_next == 9'd0 && pend_valid) begin scrolly <= pend_y; pend_valid <= 1'b0; end
        end
    end

    // ------------------------------------------------------------------------
    // video RAMs (port A = CPU, port B = render / scan-out)
    // ------------------------------------------------------------------------
    logic [15:0] pal_q_a, alpha_q_a, pft_q_a, pfb_q_a;
    wire [13:0] pf_mask = 14'((15'd1 << cfg_pf_bits) - 15'd1);
    wire [13:0] mo_mask = 14'((15'd1 << cfg_mo_bits) - 15'd1);
    logic [15:0] mob_q_a [4];
    logic [15:0] pal_q_b, alpha_q_b, pft_q_b, pfb_q_b;
    logic [15:0] mob_q_b [4];
    logic  [7:0] pal_addr_b;
    logic [11:0] alpha_addr_b, pf_addr_b;
    logic  [7:0] mob_addr_b;

    dpram_be #(.AW(8)) u_pal (
        .clk(clk),
        .a_addr(cpu_addr[7:0]), .a_we(cpu_we && sel_pal), .a_be(cpu_be), .a_wdata(cpu_wdata), .a_rdata(pal_q_a),
        .b_addr(pal_addr_b), .b_we(1'b0), .b_be(2'b00), .b_wdata(16'h0000), .b_rdata(pal_q_b));
    dpram_be #(.AW(12)) u_alpha (
        .clk(clk),
        .a_addr(cpu_addr), .a_we(cpu_we && sel_alpha), .a_be(cpu_be), .a_wdata(cpu_wdata), .a_rdata(alpha_q_a),
        .b_addr(alpha_addr_b), .b_we(1'b0), .b_be(2'b00), .b_wdata(16'h0000), .b_rdata(alpha_q_b));
    dpram_be #(.AW(12)) u_pft (
        .clk(clk),
        .a_addr(cpu_addr), .a_we(cpu_we && sel_pft), .a_be(cpu_be), .a_wdata(cpu_wdata), .a_rdata(pft_q_a),
        .b_addr(pf_addr_b), .b_we(1'b0), .b_be(2'b00), .b_wdata(16'h0000), .b_rdata(pft_q_b));
    dpram_be #(.AW(12)) u_pfb (
        .clk(clk),
        .a_addr(cpu_addr), .a_we(cpu_we && sel_pfb), .a_be(cpu_be), .a_wdata(cpu_wdata), .a_rdata(pfb_q_a),
        .b_addr(pf_addr_b), .b_we(1'b0), .b_be(2'b00), .b_wdata(16'h0000), .b_rdata(pfb_q_b));
    // motion object RAM: the four words of an entry in four RAMs so the
    // renderer reads a whole entry per clock
    genvar gi;
    generate for (gi = 0; gi < 4; gi++) begin : g_mob
        dpram_be #(.AW(8)) u_mob (
            .clk(clk),
            .a_addr(cpu_addr[9:2]), .a_we(cpu_we && sel_mob && cpu_addr[1:0] == gi[1:0]), .a_be(cpu_be), .a_wdata(cpu_wdata), .a_rdata(mob_q_a[gi]),
            .b_addr(mob_addr_b), .b_we(1'b0), .b_be(2'b00), .b_wdata(16'h0000), .b_rdata(mob_q_b[gi]));
    end endgenerate

    // CPU read mux, two clocks after the access
    logic sel_pal_d, sel_alpha_d, sel_mob_d, sel_pft_d, sel_pfb_d;
    logic [1:0] mob_col_d;
    always_ff @(posedge clk) begin
        sel_pal_d <= sel_pal; sel_alpha_d <= sel_alpha; sel_mob_d <= sel_mob; sel_pft_d <= sel_pft; sel_pfb_d <= sel_pfb;
        mob_col_d <= cpu_addr[1:0];
        cpu_rdata <= sel_pal_d   ? pal_q_a :
                     sel_alpha_d ? alpha_q_a :
                     sel_mob_d   ? mob_q_a[mob_col_d] :
                     sel_pft_d   ? pft_q_a :
                     sel_pfb_d   ? pfb_q_a : 16'hffff;
    end

    // character ROM: 8192 x 16 (word = code*8 + row; low byte = pixels 0-3)
    (* ramstyle = "no_rw_check" *) logic [1:0][7:0] chr [0:8191] /* verilator public_flat_rw */;
    logic [12:0] chr_addr_b;
    logic [15:0] chr_q_b;
    always_ff @(posedge clk) begin
        if (chr_we) chr[chr_waddr[13:1]][chr_waddr[0]] <= chr_wdata;
        chr_q_b <= chr[chr_addr_b];
    end

    // ------------------------------------------------------------------------
    // line buffers (two lines each; bit 9 of the address = line parity)
    // ------------------------------------------------------------------------
    logic        pfbuf_we, mobuf_we, albuf_we;
    logic  [9:0] pfbuf_wa, mobuf_wa, albuf_wa, buf_ra;
    logic  [9:0] pfbuf_wd, pfbuf_q;          // {cat[1:0], index[7:0]}
    logic  [8:0] mobuf_wd, mobuf_q;          // {valid, prio[1:0], colour[1:0], pen[3:0]}
    logic  [5:0] albuf_wd, albuf_q;          // {valid, colour[2:0], pen[1:0]}
    sdpram #(.AW(10), .DW(10)) u_pfbuf (.clk(clk), .we(pfbuf_we), .waddr(pfbuf_wa), .wdata(pfbuf_wd), .raddr(buf_ra), .q(pfbuf_q));
    sdpram #(.AW(10), .DW(9))  u_mobuf (.clk(clk), .we(mobuf_we), .waddr(mobuf_wa), .wdata(mobuf_wd), .raddr(buf_ra), .q(mobuf_q));
    sdpram #(.AW(10), .DW(6))  u_albuf (.clk(clk), .we(albuf_we), .waddr(albuf_wa), .wdata(albuf_wd), .raddr(buf_ra), .q(albuf_q));

    // ------------------------------------------------------------------------
    // render start: at the start of each line, render the next one
    // ------------------------------------------------------------------------
    logic [8:0] rl;                 // line being rendered
    logic       rpar;               // its buffer parity
    logic       start;              // one-clock pulse
    logic       pa_busy, mo_busy;
    always_ff @(posedge clk) begin
        start <= 1'b0;
        if (reset) begin rl <= 9'd1; rpar <= 1'b1; line_late <= 1'b0; end
        else if (sol) begin
            rl <= rl_next; rpar <= rl_next[0];
            start <= 1'b1;
            if (pa_busy || mo_busy) line_late <= 1'b1;
        end
    end
    wire render_visible = (rl < 9'd384);

    // ------------------------------------------------------------------------
    // burst port arbiter: playfield first, then motion objects
    // ------------------------------------------------------------------------
    logic [24:1] pf_baddr, mo_baddr;
    logic  [9:0] pf_blen, mo_blen;
    logic        pf_breq, mo_breq;
    logic        bsel, bbusy;       // 0 = playfield owns the port, 1 = motion objects
    always_ff @(posedge clk) begin
        if (reset) begin bbusy <= 1'b0; bsel <= 1'b0; end
        else if (!bbusy) begin
            if (pf_breq)      begin bbusy <= 1'b1; bsel <= 1'b0; end
            else if (mo_breq) begin bbusy <= 1'b1; bsel <= 1'b1; end
        end else if (b_done) bbusy <= 1'b0;
    end
    assign b_req  = bbusy && (bsel ? mo_breq : pf_breq);
    assign b_addr = bsel ? mo_baddr : pf_baddr;
    assign b_len  = bsel ? mo_blen : pf_blen;
    wire pf_bwr   = b_wr && !bsel;
    wire mo_bwr   = b_wr && bsel;
    wire pf_bdone = b_done && !bsel;
    wire mo_bdone = b_done && bsel;

    // ------------------------------------------------------------------------
    // playfield + alphanumerics engine
    // ------------------------------------------------------------------------
    // pen from a tile row: half0/half1 bytes for pixel i (0-7 or 0-15):
    // plane 0 = half0 bit 7-(i&3) (pen bit 3), plane 1 = half0 bit 3-(i&3),
    // plane 2 = half1 bit 7-(i&3), plane 3 = half1 bit 3-(i&3) (pen bit 0)
    function automatic logic [3:0] pen4(input logic [7:0] h0, input logic [7:0] h1, input logic [1:0] i);
        pen4 = {h0[3'd7 - {1'b0, i}], h0[3'd3 - {1'b0, i}], h1[3'd7 - {1'b0, i}], h1[3'd3 - {1'b0, i}]};
    endfunction

    typedef enum logic [3:0] { PA_IDLE, PA_TRD, PA_TRD2, PA_WAIT, PA_PIX, PA_ARD, PA_ARD2, PA_ARD3, PA_APIX } pa_t;
    pa_t        pa_st;
    logic [6:0] tx;                 // tile column being rendered (0-64)
    logic [8:0] py;                 // playfield row of this line
    logic [15:0] w0, w1;            // the tile row (half 0, half 1)
    logic [2:0] pcnt;               // pixel within the tile
    logic [4:0] colour_cat;         // {cat[1:0], colour[2:0]} of the tile
    logic [6:0] cx;                 // character column
    logic [2:0] al_colour;
    logic [15:0] chr_row;
    wire  [6:0] pf_col = 7'(tx + {1'b0, scrollx[9:3]});    // wraps at 128
    wire [10:0] pf_x0  = {tx, 3'b000} - {8'd0, scrollx[2:0]};   // screen x of pixel 0 of this tile (may be negative)
    wire [10:0] pf_x   = pf_x0 + {8'd0, pcnt};
    wire  [7:0] h0byte = pcnt[2] ? w0[15:8] : w0[7:0];
    wire  [7:0] h1byte = pcnt[2] ? w1[15:8] : w1[7:0];
    wire  [3:0] pf_pen = pen4(h0byte, h1byte, pcnt[1:0]);

    assign pf_addr_b    = {py[7:3], pf_col};
    assign alpha_addr_b = {rl[8:3], cx[5:0]};
    always_ff @(posedge clk) begin
        pfbuf_we <= 1'b0; albuf_we <= 1'b0;
        if (reset) begin
            pa_st <= PA_IDLE; pa_busy <= 1'b0; pf_breq <= 1'b0; pf_blen <= 10'd2; pf_baddr <= '0;
            tx <= '0; py <= '0; w0 <= '0; w1 <= '0; pcnt <= '0; colour_cat <= '0; cx <= '0; al_colour <= '0; chr_row <= '0;
            chr_addr_b <= '0;
        end else case (pa_st)
            PA_IDLE: begin
                pa_busy <= 1'b0;
                if (start && render_visible) begin
                    pa_busy <= 1'b1; tx <= '0; py <= rl + scrolly;
                    pa_st <= PA_TRD;
                end
            end
            PA_TRD:  pa_st <= PA_TRD2;                       // RAM address settled (py/tx) -> data next clock
            PA_TRD2: begin
                // pft for rows 0-31, pfb for rows 32-63
                automatic logic [15:0] w = py[8] ? pfb_q_b : pft_q_b;
                pf_baddr <= pf_row_addr({w[10] ? bank1 : bank0, w[9:0]} & pf_mask, py[2:0]);
                pf_blen  <= 10'd2;
                pf_breq  <= 1'b1;
                colour_cat <= {~w[15:14], w[13:11]};
                pa_st <= PA_WAIT;
            end
            PA_WAIT: begin
                if (pf_bwr) begin
                    if (b_idx[0]) w1 <= b_data; else w0 <= b_data;
                end
                if (pf_bdone) begin pf_breq <= 1'b0; pcnt <= '0; pa_st <= PA_PIX; end
            end
            PA_PIX: begin
                if (!pf_x[10] && pf_x < 11'd512) begin
                    pfbuf_we <= 1'b1;
                    pfbuf_wa <= {rpar, pf_x[8:0]};
                    pfbuf_wd <= {colour_cat[4:3], 1'b1, colour_cat[2:0], pf_pen};   // 128 + colour*16 + pen
                end
                pcnt <= pcnt + 3'd1;
                if (pcnt == 3'd7) begin
                    if (tx == 7'd64) begin cx <= '0; pa_st <= PA_ARD; end
                    else begin tx <= tx + 7'd1; pa_st <= PA_TRD; end
                end
            end
            // alphanumerics: 64 characters of this line
            PA_ARD: begin                                     // alpha RAM address settled -> data next clock
                pa_st <= PA_ARD2;
            end
            PA_ARD2: begin
                chr_addr_b <= {alpha_q_b[9:0], rl[2:0]};
                al_colour  <= alpha_q_b[15:13];
                pcnt <= '0;
                pa_st <= PA_ARD3;
            end
            PA_ARD3: pa_st <= PA_APIX;                       // ROM address settled -> word next clock
            PA_APIX: begin
                // the ROM word arrives on the first PA_APIX clock (chr_q_b is one
                // clock behind chr_addr_b): pixel 0 takes it from the port, the rest
                // from the copy
                chr_row <= chr_q_b;
                begin
                    automatic logic [15:0] rowv = (pcnt == 3'd0) ? chr_q_b : chr_row;
                    automatic logic [7:0] cb = pcnt[2] ? rowv[15:8] : rowv[7:0];
                    automatic logic [1:0] pen = {cb[3'd7 - {1'b0, pcnt[1:0]}], cb[3'd3 - {1'b0, pcnt[1:0]}]};
                    albuf_we <= 1'b1;
                    albuf_wa <= {rpar, cx[5:0], pcnt};
                    albuf_wd <= {pen != 2'd0, al_colour, pen};
                end
                pcnt <= pcnt + 3'd1;
                if (pcnt == 3'd7) begin
                    if (cx == 7'd63) pa_st <= PA_IDLE;
                    else begin cx <= cx + 7'd1; pa_st <= PA_ARD; end
                end
            end
            default: pa_st <= PA_IDLE;
        endcase
    end

    // ------------------------------------------------------------------------
    // motion object engine
    // ------------------------------------------------------------------------
    typedef enum logic [2:0] { MO_IDLE, MO_CLR, MO_ENT, MO_ENT2, MO_ENT3, MO_WAIT, MO_PIX } mo_t;
    mo_t         mo_st;
    logic  [9:0] mclr;              // clear counter
    logic  [7:0] link;
    logic  [8:0] mcount;
    logic [255:0] visited;
    logic  [9:0] last_x;
    logic [15:0] m0, m1, m2, m3;    // the 4 words of the row: half0 w0 w1, half1 w0 w1
    logic  [4:0] mpx;               // pixel 0-15
    logic  [9:0] mxpos;
    logic        mhflip;
    logic  [1:0] mprio, mcolour;
    // entry decode, from the entry's words registered off the RAM in MO_ENT2
    // (the M10K output straight into the row arithmetic missed 96 MHz by
    // 1.6 ns), valid in MO_ENT3
    logic [15:0] mo_e [4];
    wire  [8:0] e_y      = mo_e[0][14:6];
    wire [13:0] e_code   = {mo_e[0][2:0], mo_e[1][10:0]};
    wire        e_hflip  = mo_e[1][14];
    wire  [3:0] e_height = {1'b0, mo_e[1][13:11]} + 4'd1;
    wire        e_hold   = mo_e[1][15];
    wire  [9:0] e_x      = mo_e[2][15:6];
    wire  [1:0] e_colour = mo_e[3][13:12];
    wire  [1:0] e_prio   = mo_e[3][15:14];
    wire  [7:0] e_link   = mo_e[3][10:3];
    wire  [8:0] e_ypos   = 9'd0 - e_y - {e_height, 4'b0000};     // (-Y - height*16) & 511
    wire  [8:0] e_row    = rl - e_ypos;                          // & 511
    wire        e_covers = ({1'b0, e_row[8:4]} < {2'b00, e_height});
    wire [13:0] e_code_t = e_code + {9'd0, e_row[8:4]};          // tile t of the object (wraps at 2^cfg_mo_bits)
    wire  [9:0] e_xpos   = e_hold ? last_x + 10'd16 : e_x;
    // pixel: source column (hflip mirrors), the 4 row bytes
    wire  [3:0] msrc  = mhflip ? 4'd15 - mpx[3:0] : mpx[3:0];
    wire  [7:0] mh0   = msrc[3] ? (msrc[2] ? m1[15:8] : m1[7:0]) : (msrc[2] ? m0[15:8] : m0[7:0]);
    wire  [7:0] mh1   = msrc[3] ? (msrc[2] ? m3[15:8] : m3[7:0]) : (msrc[2] ? m2[15:8] : m2[7:0]);
    wire  [3:0] mpen  = pen4(mh0, mh1, msrc[1:0]);
    wire [10:0] mxx   = {1'b0, mxpos} + {7'd0, mpx[3:0]};       // 0..1039
    // xpos >= 512 means xpos - 1024 (negative): visible only if the pixel wraps past 1023
    wire        mvis  = mxpos[9] ? mxx[10] : (mxx < 11'd512);
    wire  [8:0] msx   = mxx[8:0];

    assign mob_addr_b = link;
    always_ff @(posedge clk) begin
        mobuf_we <= 1'b0;
        if (reset) begin
            mo_st <= MO_IDLE; mo_busy <= 1'b0; mo_breq <= 1'b0; mo_blen <= 10'd4; mo_baddr <= '0;
            mclr <= '0; link <= '0; mcount <= '0; visited <= '0; last_x <= '0;
            m0 <= '0; m1 <= '0; m2 <= '0; m3 <= '0; mpx <= '0; mxpos <= '0; mhflip <= 1'b0; mprio <= '0; mcolour <= '0;
        end else case (mo_st)
            MO_IDLE: begin
                mo_busy <= 1'b0;
                if (start && render_visible) begin
                    mo_busy <= 1'b1; mclr <= '0; mo_st <= MO_CLR;
                end
            end
            MO_CLR: begin
                mobuf_we <= 1'b1; mobuf_wa <= {rpar, mclr[8:0]}; mobuf_wd <= 9'd0;
                mclr <= mclr + 10'd1;
                if (mclr == 10'd511) begin
                    link <= 8'd0; mcount <= '0; visited <= '0; last_x <= '0;
                    mo_st <= MO_ENT;
                end
            end
            MO_ENT: mo_st <= MO_ENT2;                        // RAM address = link settled -> data next clock
            MO_ENT2: begin                                   // RAM data valid: take the entry's words
                for (int i = 0; i < 4; i++) mo_e[i] <= mob_q_b[i];
                mo_st <= MO_ENT3;
            end
            MO_ENT3: begin
                if (visited[link] || mcount == 9'd256) mo_st <= MO_IDLE;
                else begin
                    visited[link] <= 1'b1;
                    mcount <= mcount + 9'd1;
                    last_x <= e_xpos;
                    link   <= e_link;
                    if (e_covers) begin
                        mo_baddr <= mo_row_addr(e_code_t & mo_mask, e_row[3:0]);
                        mo_blen  <= 10'd4;
                        mo_breq  <= 1'b1;
                        mxpos <= e_xpos; mhflip <= e_hflip; mprio <= e_prio; mcolour <= e_colour;
                        mo_st <= MO_WAIT;
                    end else mo_st <= MO_ENT;
                end
            end
            MO_WAIT: begin
                if (mo_bwr) case (b_idx[1:0])
                    2'd0: m0 <= b_data; 2'd1: m1 <= b_data; 2'd2: m2 <= b_data; default: m3 <= b_data;
                endcase
                if (mo_bdone) begin mo_breq <= 1'b0; mpx <= '0; mo_st <= MO_PIX; end
            end
            MO_PIX: begin
                if (mvis && mpen != 4'hf) begin
                    mobuf_we <= 1'b1; mobuf_wa <= {rpar, msx}; mobuf_wd <= {1'b1, mprio, mcolour, mpen};
                end
                mpx <= mpx + 5'd1;
                if (mpx[3:0] == 4'd15) mo_st <= MO_ENT;
            end
            default: mo_st <= MO_IDLE;
        endcase
    end

    // ------------------------------------------------------------------------
    // scan-out: buffers -> priority merge -> palette -> RGB, pipelined at clk,
    // registered on cen_pix for pixel hcnt
    // ------------------------------------------------------------------------
    assign buf_ra = {vcnt[0], hcnt[8:0]};
    logic  [7:0] idx;
    logic        vis_s1, vis_s2;
    logic  [7:0] mo_idx;
    always_comb begin
        // stage 1: merge (buffer outputs are for buf_ra registered a clock ago)
        idx = pfbuf_q[7:0];
        mo_idx = {2'b00, mobuf_q[5:0]};
        if (mobuf_q[8]) begin
            if (((mobuf_q[7:6] + pfbuf_q[9:8]) & 2'b10) != 2'b00) begin
                if (!pfbuf_q[3]) idx = mo_idx;
            end else idx = mo_idx;
        end
        if (albuf_q[5]) idx = {3'b010, albuf_q[4:0]};   // 64 + colour*4 + pen
    end
    assign pal_addr_b = idx;
    // stage 2: palette word -> RGB
    logic [8:0] inten;
    logic [3:0] cr, cg, cb;
    function automatic logic [8:0] f_inten(input logic [3:0] i);
        // 0, then 115 + 78*bit3 + 37*bit2 + 17*bit1 + 9*bit0
        f_inten = (i == 4'd0) ? 9'd0 : 9'd115 + (i[3] ? 9'd78 : 9'd0) + (i[2] ? 9'd37 : 9'd0) + (i[1] ? 9'd17 : 9'd0) + (i[0] ? 9'd9 : 9'd0);
    endfunction
    function automatic logic [3:0] f_col(input logic [3:0] c);
        case (c) 4'd0: f_col = 4'h0; 4'd1: f_col = 4'h3; 4'd2: f_col = 4'h4; 4'd3: f_col = 4'h5; 4'd4: f_col = 4'h6; 4'd5: f_col = 4'h7;
                 4'd6: f_col = 4'h8; 4'd7: f_col = 4'h9; 4'd8: f_col = 4'ha; 4'd9: f_col = 4'hb; 4'd10: f_col = 4'hc; 4'd11: f_col = 4'hd;
                 4'd12: f_col = 4'he; 4'd13: f_col = 4'he; default: f_col = 4'hf; endcase
    endfunction
    logic [12:0] pr, pg, pb;
    always_ff @(posedge clk) begin
        inten <= f_inten(pal_q_b[3:0]);
        cr <= f_col(pal_q_b[15:12]); cg <= f_col(pal_q_b[11:8]); cb <= f_col(pal_q_b[7:4]);
        pr <= cr * inten; pg <= cg * inten; pb <= cb * inten;
        vis_s1 <= (hcnt < 10'd512) && (vcnt < 9'd384);
        vis_s2 <= vis_s1;
        if (cen_pix) begin
            r <= vis_s2 ? pr[11:4] : 8'h00;
            g <= vis_s2 ? pg[11:4] : 8'h00;
            b <= vis_s2 ? pb[11:4] : 8'h00;
            hblank <= (hcnt >= 10'd512);
            vblank <= (vcnt >= 9'd384);
            de     <= (hcnt < 10'd512) && (vcnt < 9'd384);
            hsync  <= (hcnt >= 10'd544) && (hcnt < 10'd608);
            vsync  <= (vcnt >= 9'd392) && (vcnt < 9'd396);
        end
    end
    wire unused_px = &{1'b0, pr[12], pg[12], pb[12], pr[3:0], pg[3:0], pb[3:0], scroll_wdata[5], b_idx[9:2], alpha_q_b[12:10]};
endmodule

`default_nettype wire
