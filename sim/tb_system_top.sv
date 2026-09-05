// Whole-machine bench wrapper: ssprint_core with the SDRAM chip model.
`default_nettype none

module tb_system_top (
    input  logic        clk,
    input  logic        hw_reset,
    input  logic        reset,
    input  logic        dl_active,
    input  logic [24:0] dl_addr,
    input  logic  [7:0] dl_data,
    input  logic        dl_we,
    input  logic  [8:0] nv_addr,
    input  logic        nv_we,
    input  logic  [7:0] nv_wdata,
    output logic  [7:0] nv_rdata,
    output logic        nv_dirty,
    input  logic  [2:0] coin, start,
    input  logic        btn3,           // APB's siren (start)
    input  logic        service,
    input  logic  [7:0] pedal0, pedal1, pedal2, wheel0, wheel1, wheel2, dsw0, dsw1,
    output logic        cen_pix,
    output logic  [7:0] r, g, b,
    output logic        hsync, vsync, hblank, vblank, de,
    output logic signed [15:0] audio_l, audio_r,
    output logic        audio_valid,
    output logic [15:0] dbg_t11_pc,
    output logic        dbg_t11_done,
    output logic [15:0] dbg_6502_addr,
    output logic  [7:0] dbg_flags,
    output logic        dbg_snd_cmd_wr,
    output logic  [7:0] dbg_snd_cmd,
    output logic [31:0] model_errors
);
    wire  [15:0] dq;
    wire  [12:0] sa;
    wire   [1:0] sba;
    wire         dqml, dqmh, cs_n, we_n, ras_n, cas_n, cke, sclk;

    logic [7:0] cfg_game, cfg_slapstic, cfg_flags, cfg_pf_bits, cfg_mo_bits;
    wire unused_cfg = &{1'b0, cfg_game, cfg_slapstic, cfg_flags, cfg_pf_bits, cfg_mo_bits};
    ssprint_core #(.DBG_OVERLAY(0)) core (
        .clk(clk), .clk_sdram(clk), .hw_reset(hw_reset), .reset(reset), .rd_late(1'b1), .burst_slow(1'b0), .overlay(1'b0),
        .dl_active(dl_active), .dl_addr_in(dl_addr), .dl_data_in(dl_data), .dl_we_in(dl_we),
        .cfg_game(cfg_game), .cfg_slapstic(cfg_slapstic), .cfg_flags(cfg_flags), .cfg_pf_bits(cfg_pf_bits), .cfg_mo_bits(cfg_mo_bits),
        .nv_addr(nv_addr), .nv_we(nv_we), .nv_wdata(nv_wdata), .nv_rdata(nv_rdata), .nv_dirty(nv_dirty),
        .coin(coin), .start(start), .btn2(1'b0), .btn3(btn3), .service(service),
        .pedal0(pedal0), .pedal1(pedal1), .pedal2(pedal2), .wheel0(wheel0), .wheel1(wheel1), .wheel2(wheel2), .dsw0(dsw0), .dsw1(dsw1),
        .cen_pix(cen_pix), .r(r), .g(g), .b(b), .hsync(hsync), .vsync(vsync), .hblank(hblank), .vblank(vblank), .de(de),
        .audio_l(audio_l), .audio_r(audio_r), .audio_valid(audio_valid),
        .dram_dq(dq), .dram_a(sa), .dram_ba(sba), .dram_dqm_l(dqml), .dram_dqm_h(dqmh),
        .dram_cs_n(cs_n), .dram_ras_n(ras_n), .dram_cas_n(cas_n), .dram_we_n(we_n), .dram_cke(cke), .dram_clk(sclk),
        .dbg_t11_pc(dbg_t11_pc), .dbg_t11_done(dbg_t11_done), .dbg_6502_addr(dbg_6502_addr), .dbg_flags(dbg_flags),
        .dbg_snd_cmd_wr(dbg_snd_cmd_wr), .dbg_snd_cmd(dbg_snd_cmd)
    );
    sdram_model #(.AW(22)) chip (
        .clk(clk), .dq(dq), .a(sa), .ba(sba), .dqml(dqml), .dqmh(dqmh),
        .cs_n(cs_n), .ras_n(ras_n), .cas_n(cas_n), .we_n(we_n), .cke(cke)
    );
    assign model_errors = chip.errors;
    wire unused_ok = &{1'b0, sclk};
endmodule

`default_nettype wire
