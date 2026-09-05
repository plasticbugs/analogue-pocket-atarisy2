// Sound board bench wrapper: ssprint_sound with the core's clock enables.
`default_nettype none

module tb_sound_top (
    input  logic        clk,
    input  logic        reset,
    input  logic        cpu_reset,
    input  logic        snd_reset_pulse,
    input  logic        cmd_wr,
    input  logic  [7:0] cmd_data,
    output logic        cmd_full,
    output logic        cmd_rd_pulse,
    input  logic        resp_rd,
    output logic  [7:0] resp_data,
    output logic        resp_full,
    output logic        resp_wr_pulse,
    input  logic  [2:0] coins,
    input  logic        test,
    input  logic  [7:0] dsw0, dsw1,
    input  logic  [7:0] leta0,
    input  logic        rom_we,
    input  logic [14:0] rom_waddr,
    input  logic  [7:0] rom_wdata,
    input  logic        nv_we,
    input  logic  [8:0] nv_addr,
    input  logic  [7:0] nv_wdata,
    output logic signed [15:0] audio_l, audio_r,
    output logic        audio_valid,
    output logic        dbg_ym_wr, dbg_ym_a0, dbg_pk_wr, dbg_pk_sel,
    output logic  [3:0] dbg_pk_reg,
    output logic        dbg_io_wr,
    output logic  [2:0] dbg_io_reg,
    output logic  [7:0] dbg_d,
    output logic        dbg_sync,
    output logic [15:0] dbg_addr,
    output logic        cen_ym
);
    logic cen_pix, cen_10m, irq_tick;
    clk_enables cen (.clk(clk), .reset(reset), .cen_pix(cen_pix), .cen_10m(cen_10m), .cen_ym(cen_ym), .irq_tick(irq_tick));
    wire unused_ok = &{1'b0, cen_pix, cen_10m};
    logic [7:0] nv_rdata; logic nv_dirty;
    ssprint_sound dut (
        .clk(clk), .reset(reset), .cen_ym(cen_ym), .irq_tick(irq_tick), .cpu_reset(cpu_reset), .snd_reset_pulse(snd_reset_pulse),
        .cmd_wr(cmd_wr), .cmd_data(cmd_data), .cmd_full(cmd_full), .cmd_rd_pulse(cmd_rd_pulse),
        .resp_rd(resp_rd), .resp_data(resp_data), .resp_full(resp_full), .resp_wr_pulse(resp_wr_pulse),
        .coins(coins), .test(test), .dsw0(dsw0), .dsw1(dsw1), .leta0(leta0), .leta1(8'h00), .leta2(8'h00),
        .rom_we(rom_we), .rom_waddr(rom_waddr), .rom_wdata(rom_wdata),
        .nv_addr(nv_addr), .nv_we(nv_we), .nv_wdata(nv_wdata), .nv_rdata(nv_rdata), .nv_dirty(nv_dirty),
        .audio_l(audio_l), .audio_r(audio_r), .audio_valid(audio_valid),
        .dbg_ym_wr(dbg_ym_wr), .dbg_ym_a0(dbg_ym_a0), .dbg_pk_wr(dbg_pk_wr), .dbg_pk_sel(dbg_pk_sel), .dbg_pk_reg(dbg_pk_reg),
        .dbg_io_wr(dbg_io_wr), .dbg_io_reg(dbg_io_reg), .dbg_d(dbg_d), .dbg_sync(dbg_sync), .dbg_addr(dbg_addr)
    );
    wire unused_nv = &{1'b0, nv_rdata, nv_dirty};
endmodule

`default_nettype wire
