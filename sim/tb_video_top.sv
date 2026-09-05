// Frozen-state video bench: ssprint_video with the real SDRAM controller and
// chip model. The C++ side loads a MAME state (tools/dumpstate.lua) into the
// video RAMs through the CPU port, the graphics ROMs into the chip model, and
// captures one frame on DE to diff against the reference renderer.
`default_nettype none

module tb_video_top (
    input  logic        clk,
    input  logic        reset,
    input  logic        cen_pix,
    // CPU port passthrough for loading
    input  logic [11:0] cpu_addr,
    input  logic        cpu_we,
    input  logic [15:0] cpu_wdata,
    input  logic        sel_pal, sel_alpha, sel_mob, sel_pft, sel_pfb,
    input  logic        xscroll_we, yscroll_we,
    input  logic [15:0] scroll_wdata,
    input  logic        chr_we,
    input  logic [13:0] chr_waddr,
    input  logic  [7:0] chr_wdata,
    // video out
    output logic        cen_out,
    output logic  [7:0] r, g, b,
    output logic        hsync, vsync, de,
    output logic        line_late,
    output logic        sd_ready,
    output logic [31:0] model_errors,
    output logic  [8:0] vcount
);
    wire  [15:0] dq;
    wire  [12:0] sa;
    wire   [1:0] sba;
    wire         dqml, dqmh, cs_n, we_n, ras_n, cas_n, cke, sclk;
    logic [24:1] c_addr  [6];
    logic        c_req   [6];
    logic        c_we    [6];
    logic [15:0] c_wdata [6];
    logic  [1:0] c_be    [6];
    logic        c_ack   [6];
    logic [15:0] sd_rdata;
    logic [24:1] b_addr;
    logic  [9:0] b_len, b_idx, b_widx;
    logic        b_req, b_wr, b_done;
    logic [15:0] b_data;
    always_comb for (int i = 0; i < 6; i++) begin c_req[i] = 1'b0; c_addr[i] = '0; c_we[i] = 1'b0; c_wdata[i] = '0; c_be[i] = '0; end

    sdram_ctrl sdram (
        .clk(clk), .clk_pin(clk), .init(reset), .rd_late(1'b1), .burst_slow(1'b0), .ready(sd_ready),
        .SDRAM_DQ(dq), .SDRAM_A(sa), .SDRAM_DQML(dqml), .SDRAM_DQMH(dqmh), .SDRAM_BA(sba),
        .SDRAM_nCS(cs_n), .SDRAM_nWE(we_n), .SDRAM_nRAS(ras_n), .SDRAM_nCAS(cas_n), .SDRAM_CKE(cke), .SDRAM_CLK(sclk),
        .c_addr(c_addr), .c_req(c_req), .c_we(c_we), .c_wdata(c_wdata), .c_be(c_be), .c_ack(c_ack), .rdata(sd_rdata),
        .b_addr(b_addr), .b_len(b_len), .b_req(b_req), .b_wr(b_wr), .b_idx(b_idx), .b_data(b_data), .b_done(b_done),
        .b_we(1'b0), .b_wdata(16'h0000), .b_be(2'b11), .b_widx(b_widx)
    );
    sdram_model #(.AW(22)) chip (
        .clk(clk), .dq(dq), .a(sa), .ba(sba), .dqml(dqml), .dqmh(dqmh),
        .cs_n(cs_n), .ras_n(ras_n), .cas_n(cas_n), .we_n(we_n), .cke(cke)
    );
    assign model_errors = chip.errors;
    wire unused_ok = &{1'b0, sd_rdata, b_widx, c_ack[0], c_ack[1], c_ack[2], c_ack[3], c_ack[4], c_ack[5]};

    logic hb, vb, irq32, irqv;
    logic [15:0] cpu_rdata;
    ssprint_video video (
        .clk(clk), .reset(reset | ~sd_ready), .cen_pix(cen_pix),
        .cpu_addr(cpu_addr), .cpu_we(cpu_we), .cpu_be(2'b11), .cpu_wdata(cpu_wdata),
        .sel_pal(sel_pal), .sel_alpha(sel_alpha), .sel_mob(sel_mob), .sel_pft(sel_pft), .sel_pfb(sel_pfb), .cpu_rdata(cpu_rdata),
        .xscroll_we(xscroll_we), .yscroll_we(yscroll_we), .scroll_wdata(scroll_wdata),
        .chr_we(chr_we), .chr_waddr(chr_waddr), .chr_wdata(chr_wdata),
        .b_addr(b_addr), .b_len(b_len), .b_req(b_req), .b_wr(b_wr), .b_idx(b_idx), .b_data(b_data), .b_done(b_done),
        .r(r), .g(g), .b(b), .hsync(hsync), .vsync(vsync), .hblank(hb), .vblank(vb), .de(de),
        .vcount(vcount), .irq_32v(irq32), .irq_vbl(irqv), .line_late(line_late)
    );
    wire unused_v = &{1'b0, hb, vb, irq32, irqv, cpu_rdata};
    always_ff @(posedge clk) cen_out <= cen_pix;
endmodule

`default_nettype wire
