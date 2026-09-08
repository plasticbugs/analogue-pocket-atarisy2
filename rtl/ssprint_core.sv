//------------------------------------------------------------------------------
// Super Sprint: the whole machine (docs/hardware.md), platform-agnostic.
//
//   ssprint_main    T11 board: CPU, slapstic, RAM, fixed ROM, latches, ADC
//   ssprint_video   System 2 video: playfield, alphanumerics, motion objects
//   ssprint_sound   sound board: 6502, 2x POKEY, YM2151, EEPROM, latches
//   sdram_ctrl      one SDRAM for the banked program ROM and the graphics
//
// SDRAM: random client 0 = T11 banked ROM, 1 = loader; the burst port
// serves the video engines' tile-row fetches.
//------------------------------------------------------------------------------
`default_nettype none

module ssprint_core
    import ssprint_pkg::*;
#(
    parameter DBG_OVERLAY = 0
) (
    input  logic        clk,            // 96 MHz
    input  logic        clk_sdram,      // 96 MHz phase-shifted, SDRAM pin clock
    input  logic        hw_reset,       // PLL not locked: everything, including the loader path
    input  logic        reset,          // machine reset (menu / host)
    input  logic        rd_late,        // SDRAM read capture diagnostic
    input  logic        burst_slow,     // SDRAM burst spacing diagnostic
    input  logic        overlay,        // diagnostic overlay

    // ROM image download (tools/mra_build.py layout, docs/hardware.md 9)
    input  logic        dl_active,
    input  logic [24:0] dl_addr_in,
    input  logic  [7:0] dl_data_in,
    input  logic        dl_we_in,
    // from the image header (valid once the download has passed byte 9)
    output logic  [7:0] cfg_game,       // 1 Super Sprint, 2 APB, ...
    output logic  [7:0] cfg_slapstic,   // 105 .. 110
    output logic  [7:0] cfg_flags,      // bit 0 TMS5220 fitted, bit 1 vertical screen
    output logic  [7:0] cfg_pf_bits,    // playfield tile code width (codes wrap)
    output logic  [7:0] cfg_mo_bits,    // motion object code width

    // EEPROM external port (save file), 512 bytes
    input  logic  [8:0] nv_addr,
    input  logic        nv_we,
    input  logic  [7:0] nv_wdata,
    output logic  [7:0] nv_rdata,
    output logic        nv_dirty,

    // controls (active high)
    input  logic  [2:0] coin,           // 1, 2, 3
    input  logic  [2:0] start,          // players 1, 2, 3
    input  logic        btn2, btn3,     // APB's two buttons
    input  logic        service,        // self-test
    input  logic  [7:0] pedal0, pedal1, pedal2,   // 0xff released .. 0x3f floored
    input  logic  [7:0] wheel0, wheel1, wheel2,   // steering counters
    input  logic  [7:0] dsw0, dsw1,

    // video (valid on cen_pix)
    output logic        cen_pix,
    output logic  [7:0] r, g, b,
    output logic        hsync, vsync, hblank, vblank, de,

    // audio
    output logic signed [15:0] audio_l, audio_r,
    output logic        audio_valid,

    // SDRAM pins
    inout  wire  [15:0] dram_dq,
    output logic [12:0] dram_a,
    output logic  [1:0] dram_ba,
    output logic        dram_dqm_l, dram_dqm_h,
    output logic        dram_cs_n, dram_ras_n, dram_cas_n, dram_we_n, dram_cke, dram_clk,

    // diagnostics
    output logic [15:0] dbg_t11_pc,
    output logic        dbg_t11_done,
    output logic [15:0] dbg_6502_addr,
    output logic  [7:0] dbg_flags,      // {sd_ready, wdog, line_late, snd_cpu_reset, cp[3:0]}
    output logic        dbg_snd_cmd_wr,
    output logic  [7:0] dbg_snd_cmd
);
    // ------------------------------------------------------------------------
    // clocks and resets
    // ------------------------------------------------------------------------
    logic cen_10m, cen_ym, irq_tick, irq_sync, cen_tms625, cen_tms833;
    clk_enables cen (.clk(clk), .reset(hw_reset), .cen_pix(cen_pix), .cen_10m(cen_10m), .cen_ym(cen_ym), .irq_sync(irq_sync), .irq_tick(irq_tick), .cen_tms625(cen_tms625), .cen_tms833(cen_tms833));
    logic sd_ready, wdog_expired;
    // the watchdog reboots the machine: hold reset for a while after it fires
    logic [11:0] wdog_hold;
    always_ff @(posedge clk) begin
        if (hw_reset) wdog_hold <= '0;
        else if (wdog_expired) wdog_hold <= 12'hfff;
        else if (wdog_hold != 12'd0) wdog_hold <= wdog_hold - 12'd1;
    end
    wire mreset = reset | hw_reset | dl_active | ~sd_ready | (wdog_hold != 12'd0);

    // ------------------------------------------------------------------------
    // SDRAM
    // ------------------------------------------------------------------------
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
    always_comb for (int i = 2; i < 6; i++) begin c_req[i] = 1'b0; c_addr[i] = '0; c_we[i] = 1'b0; c_wdata[i] = '0; c_be[i] = '0; end

    sdram_ctrl sdram (
        .clk(clk), .clk_pin(clk_sdram), .init(hw_reset), .rd_late(rd_late), .burst_slow(burst_slow), .ready(sd_ready),
        .SDRAM_DQ(dram_dq), .SDRAM_A(dram_a), .SDRAM_DQML(dram_dqm_l), .SDRAM_DQMH(dram_dqm_h), .SDRAM_BA(dram_ba),
        .SDRAM_nCS(dram_cs_n), .SDRAM_nWE(dram_we_n), .SDRAM_nRAS(dram_ras_n), .SDRAM_nCAS(dram_cas_n),
        .SDRAM_CKE(dram_cke), .SDRAM_CLK(dram_clk),
        .c_addr(c_addr), .c_req(c_req), .c_we(c_we), .c_wdata(c_wdata), .c_be(c_be), .c_ack(c_ack), .rdata(sd_rdata),
        .b_addr(b_addr), .b_len(b_len), .b_req(b_req), .b_wr(b_wr), .b_idx(b_idx), .b_data(b_data), .b_done(b_done),
        .b_we(1'b0), .b_wdata(16'h0000), .b_be(2'b11), .b_widx(b_widx)
    );
    wire unused_sd = &{1'b0, b_widx, c_ack[2], c_ack[3], c_ack[4], c_ack[5]};

    // ------------------------------------------------------------------------
    // loader: image bytes to block RAMs directly, to SDRAM through a FIFO
    // ------------------------------------------------------------------------
    // the loader's inputs come from the framework's synchronisers (RAM shift
    // registers, slow to leave) and are registered once here before the
    // address arithmetic that routes them
    logic [24:0] dl_addr; logic [7:0] dl_data; logic dl_we;
    always_ff @(posedge clk) begin dl_addr <= dl_addr_in; dl_data <= dl_data_in; dl_we <= dl_we_in; end
    logic dl_we_d;
    wire  dl_pulse = dl_we && !dl_we_d;
    wire  dl_hdr     = (dl_addr < IMG_MAIN_FIXED);
    wire  dl_fixed   = (dl_addr >= IMG_MAIN_FIXED) && (dl_addr < IMG_MAIN_BANK);
    wire  dl_bank    = (dl_addr >= IMG_MAIN_BANK) && (dl_addr < IMG_SOUND);
    wire  dl_sound   = (dl_addr >= IMG_SOUND)     && (dl_addr < IMG_TILES);
    wire  dl_tiles   = (dl_addr >= IMG_TILES)     && (dl_addr < IMG_SPRITES);
    wire  dl_sprites = (dl_addr >= IMG_SPRITES)   && (dl_addr < IMG_CHARS);
    wire  dl_chars   = (dl_addr >= IMG_CHARS)     && (dl_addr < IMG_EEPROM);
    wire  dl_eeprom  = (dl_addr >= IMG_EEPROM)    && (dl_addr < IMG_END);
    // SDRAM destination word and byte lane for the three SDRAM parts
    logic [24:1] dl_sd_word;
    always_comb begin
        if (dl_tiles)        dl_sd_word = tiles_img_to_sd(19'(dl_addr - IMG_TILES));
        else if (dl_sprites) dl_sd_word = sprites_img_to_sd(20'(dl_addr - IMG_SPRITES));
        else                 dl_sd_word = SD_MAIN_BANK + 24'((dl_addr - IMG_MAIN_BANK) >> 1);
    end
    wire [7:0] dl_byte = dl_sprites ? ~dl_data : dl_data;     // ROMREGION_INVERT
    // the image header: which game this is and how its parts differ (defaults
    // are Super Sprint's, for an image that is somehow short of a header)
    always_ff @(posedge clk) begin
        if (hw_reset) begin cfg_game <= 8'd1; cfg_slapstic <= 8'd108; cfg_flags <= 8'h00; cfg_pf_bits <= 8'd14; cfg_mo_bits <= 8'd11; end
        else if (dl_pulse && dl_hdr) case (dl_addr[8:0])
            9'd5: cfg_game     <= dl_data;
            9'd6: cfg_slapstic <= dl_data;
            9'd7: cfg_flags    <= dl_data;
            9'd8: cfg_pf_bits  <= dl_data;
            9'd9: cfg_mo_bits  <= dl_data;
            default: ;
        endcase
    end
    logic [32:0] wfifo [0:63];      // {word[24:1], lane, byte}
    logic  [6:0] wf_wp, wf_rp;
    wire         wf_empty = (wf_wp == wf_rp);
    always_ff @(posedge clk) begin
        dl_we_d <= dl_we;
        if (hw_reset) begin wf_wp <= '0; wf_rp <= '0; c_req[1] <= 1'b0; c_we[1] <= 1'b0; c_addr[1] <= '0; c_wdata[1] <= '0; c_be[1] <= '0; end
        else begin
            if (dl_pulse && (dl_bank || dl_tiles || dl_sprites)) begin
                wfifo[wf_wp[5:0]] <= {dl_sd_word, dl_addr[0], dl_byte};
                wf_wp <= wf_wp + 7'd1;
            end
            if (!c_req[1] && !wf_empty) begin
                c_addr[1]  <= wfifo[wf_rp[5:0]][32:9];
                c_wdata[1] <= {wfifo[wf_rp[5:0]][7:0], wfifo[wf_rp[5:0]][7:0]};
                c_be[1]    <= wfifo[wf_rp[5:0]][8] ? 2'b10 : 2'b01;
                c_we[1]    <= 1'b1;
                c_req[1]   <= 1'b1;
                wf_rp      <= wf_rp + 7'd1;
            end else if (c_req[1] && c_ack[1]) begin
                c_req[1] <= 1'b0;
            end
        end
    end

    // ------------------------------------------------------------------------
    // main board
    // ------------------------------------------------------------------------
    logic [11:0] vr_addr;
    logic        vr_we;
    logic  [1:0] vr_be;
    logic [15:0] vr_wdata, vr_rdata;
    logic        vr_sel_pal, vr_sel_alpha, vr_sel_mob, vr_sel_pft, vr_sel_pfb;
    logic        xscroll_we, yscroll_we;
    logic [15:0] scroll_wdata;
    logic        irq_32v, irq_vbl;
    logic        snd_cmd_wr, snd_cpu_reset, snd_reset_pulse, snd_cmd_full, snd_cmd_rd, snd_resp_full, snd_resp_wr, snd_resp_rd;
    logic  [7:0] snd_cmd, snd_resp;
    logic  [1:0] slap_bank;
    logic  [3:0] cp;

    ssprint_main main (
        .cfg_slapstic(cfg_slapstic),
        .clk(clk), .reset(mreset), .cen_10m(cen_10m),
        .rom_we(dl_pulse && dl_fixed), .rom_waddr(15'(dl_addr - IMG_MAIN_FIXED)), .rom_wdata(dl_data),
        .brom_addr(c_addr[0]), .brom_req(c_req[0]), .brom_rdata(sd_rdata), .brom_ack(c_ack[0]),
        .vr_addr(vr_addr), .vr_we(vr_we), .vr_be(vr_be), .vr_wdata(vr_wdata),
        .vr_sel_pal(vr_sel_pal), .vr_sel_alpha(vr_sel_alpha), .vr_sel_mob(vr_sel_mob), .vr_sel_pft(vr_sel_pft), .vr_sel_pfb(vr_sel_pfb),
        .vr_rdata(vr_rdata), .xscroll_we(xscroll_we), .yscroll_we(yscroll_we), .scroll_wdata(scroll_wdata),
        .irq_32v(irq_32v), .irq_vbl(irq_vbl),
        .snd_cmd_wr(snd_cmd_wr), .snd_cmd(snd_cmd), .snd_cpu_reset(snd_cpu_reset), .snd_reset_pulse(snd_reset_pulse),
        .snd_cmd_full(snd_cmd_full), .snd_cmd_rd(snd_cmd_rd), .snd_resp_full(snd_resp_full), .snd_resp_wr(snd_resp_wr),
        .snd_resp(snd_resp), .snd_resp_rd(snd_resp_rd),
        .start(start), .btn2(btn2), .btn3(btn3), .service(service), .pedal0(pedal0), .pedal1(pedal1), .pedal2(pedal2),
        .wdog_expired(wdog_expired),
        .dbg_pc(dbg_t11_pc), .dbg_done(dbg_t11_done), .dbg_slap_bank(slap_bank), .dbg_cp(cp)
    );
    assign c_we[0] = 1'b0; assign c_wdata[0] = '0; assign c_be[0] = 2'b11;

    // ------------------------------------------------------------------------
    // video
    // ------------------------------------------------------------------------
    logic [7:0] v_r, v_g, v_b;
    logic       line_late;
    logic [8:0] vcount;
    ssprint_video video (
        .clk(clk), .reset(mreset), .cen_pix(cen_pix),
        .cpu_addr(vr_addr), .cpu_we(vr_we), .cpu_be(vr_be), .cpu_wdata(vr_wdata),
        .sel_pal(vr_sel_pal), .sel_alpha(vr_sel_alpha), .sel_mob(vr_sel_mob), .sel_pft(vr_sel_pft), .sel_pfb(vr_sel_pfb),
        .cpu_rdata(vr_rdata),
        .xscroll_we(xscroll_we), .yscroll_we(yscroll_we), .scroll_wdata(scroll_wdata),
        .chr_we(dl_pulse && dl_chars), .chr_waddr(14'(dl_addr - IMG_CHARS)), .chr_wdata(dl_data),
        .cfg_pf_bits(cfg_pf_bits[3:0]), .cfg_mo_bits(cfg_mo_bits[3:0]),
        .b_addr(b_addr), .b_len(b_len), .b_req(b_req), .b_wr(b_wr), .b_idx(b_idx), .b_data(b_data), .b_done(b_done),
        .r(v_r), .g(v_g), .b(v_b), .hsync(hsync), .vsync(vsync), .hblank(hblank), .vblank(vblank), .de(de),
        .vcount(vcount), .irq_32v(irq_32v), .irq_vbl(irq_vbl), .line_late(line_late)
    );
    wire unused_v = &{1'b0, vcount, overlay, slap_bank};
    generate if (DBG_OVERLAY) begin : g_ovl
        dbg_overlay ovl (
            .clk(clk), .cen_pix(cen_pix), .enable(overlay), .de(de), .vsync(vsync),
            .r_in(v_r), .g_in(v_g), .b_in(v_b),
            .status({16'd0, dbg_t11_pc, 16'd0, dbg_6502_addr, 8'd0, dbg_flags, 6'd0, slap_bank, dbg_snd_cmd}),
            .r_out(r), .g_out(g), .b_out(b)
        );
    end else begin : g_noovl
        assign r = v_r; assign g = v_g; assign b = v_b;
    end endgenerate

    // ------------------------------------------------------------------------
    // sound board
    // ------------------------------------------------------------------------
    // EEPROM: factory defaults from the image share the external port with the save file
    // the save port's inputs arrive from the framework's synchronisers (RAM
    // shift registers, slow to leave) and are registered once here before
    // the EEPROM's address decode; the path missed 96 MHz by 0.07 ns direct
    logic [8:0] nv_addr_q; logic nv_we_q; logic [7:0] nv_wdata_q;
    always_ff @(posedge clk) begin nv_addr_q <= nv_addr; nv_we_q <= nv_we; nv_wdata_q <= nv_wdata; end
    wire       nv_we_m    = (dl_active && dl_eeprom) ? dl_pulse : nv_we_q;
    wire [8:0] nv_addr_m  = (dl_active && dl_eeprom) ? 9'(dl_addr - IMG_EEPROM) : nv_addr_q;
    wire [7:0] nv_wdata_m = (dl_active && dl_eeprom) ? dl_data : nv_wdata_q;

    ssprint_sound sound (
        .clk(clk), .reset(mreset), .cen_ym(cen_ym), .irq_tick(irq_tick), .irq_sync(irq_sync),
        .cen_tms625(cen_tms625), .cen_tms833(cen_tms833), .cfg_tms(cfg_flags[0]),
        .cpu_reset(snd_cpu_reset), .snd_reset_pulse(snd_reset_pulse),
        .cmd_wr(snd_cmd_wr), .cmd_data(snd_cmd), .cmd_full(snd_cmd_full), .cmd_rd_pulse(snd_cmd_rd),
        .resp_rd(snd_resp_rd), .resp_data(snd_resp), .resp_full(snd_resp_full), .resp_wr_pulse(snd_resp_wr),
        .coins(coin), .test(service), .dsw0(dsw0), .dsw1(dsw1), .leta0(wheel0), .leta1(wheel1), .leta2(wheel2),
        .rom_we(dl_pulse && dl_sound), .rom_waddr(16'(dl_addr - IMG_SOUND)), .rom_wdata(dl_data),
        .nv_addr(nv_addr_m), .nv_we(nv_we_m), .nv_wdata(nv_wdata_m), .nv_rdata(nv_rdata), .nv_dirty(nv_dirty),
        .audio_l(audio_l), .audio_r(audio_r), .audio_valid(audio_valid),
        .dbg_ym_wr(), .dbg_ym_a0(), .dbg_pk_wr(), .dbg_pk_sel(), .dbg_pk_reg(), .dbg_io_wr(), .dbg_io_reg(), .dbg_d(), .dbg_in1_rd(), .dbg_in1(),
        .dbg_sync(), .dbg_addr(dbg_6502_addr)
    );

    assign dbg_flags = {sd_ready, wdog_expired, line_late, snd_cpu_reset, cp};
    assign dbg_snd_cmd_wr = snd_cmd_wr;
    assign dbg_snd_cmd = snd_cmd;
endmodule

`default_nettype wire
