//------------------------------------------------------------------------------
// Atari System 2 sound board as fitted to Super Sprint (docs/hardware.md
// section 7): a 6502 (T65) at 1.789772 MHz with 4 KB RAM, a 32 KB program
// ROM, the 2804 EEPROM, two POKEYs (rtl/pokey.sv) at the CPU clock, a
// YM2151 (jt51) at 3.579545 MHz, the command/response latches to the T11,
// the steering (LETA) and input ports, and the mixer. No TMS5220 on this game.
//
// Clocking as in the S.T.U.N. Runner JSA II board: the 6502 enable is every
// other YM2151 enable, so the CPU, the POKEYs and the FM chip stay phase
// locked as on the PCB. T65 presents A/DO/R_W_n right after an Enable edge
// and samples DI on the next one; every read here is a registered or
// combinational lookup of the stable address, writes happen on the Enable
// edge itself.
//
// Audio: signed 16-bit stereo, MAME's routing (YM2151 0.60 x mixer gain,
// each POKEY 1.35 x mixer gain, POKEY 1 left and POKEY 2 right), recomputed
// on every YM2151 clock; audio_valid strobes with it.
//------------------------------------------------------------------------------
`default_nettype none

module ssprint_sound (
    input  logic        clk,
    input  logic        reset,          // core reset
    input  logic        cen_ym,         // 3.579545 MHz
    input  logic        irq_tick,       // one-clock pulses at 244.14 Hz (the timed 6502 IRQ)
    input  logic        cpu_reset,      // level from the T11's 15a0 bit 0 (1 = hold the 6502 in reset)
    input  logic        snd_reset_pulse,// T11 wrote 15a0: puts the YM2151 into reset (sndrst_6502_w(0))

    // T11 latches
    input  logic        cmd_wr,         // T11 write of 1680
    input  logic  [7:0] cmd_data,
    output logic        cmd_full,       // P1TALK
    output logic        cmd_rd_pulse,   // the 6502 read the command (-> T11 IRQ0)
    input  logic        resp_rd,        // T11 read of 1c00
    output logic  [7:0] resp_data,
    output logic        resp_full,      // P2TALK
    output logic        resp_wr_pulse,  // the 6502 wrote a response (-> T11 IRQ1)

    // inputs
    input  logic  [2:0] coins,          // active high, 1 2 3
    input  logic        test,           // self-test switch, 1 = on
    input  logic  [7:0] dsw0, dsw1,
    input  logic  [7:0] leta0, leta1, leta2,   // steering counters

    // program ROM load (32 KB, 8000-ffff)
    input  logic        rom_we,
    input  logic [14:0] rom_waddr,
    input  logic  [7:0] rom_wdata,

    // EEPROM external port (load / save), 512 bytes
    input  logic  [8:0] nv_addr,
    input  logic        nv_we,
    input  logic  [7:0] nv_wdata,
    output logic  [7:0] nv_rdata,
    output logic        nv_dirty,       // toggles on every 6502 write to the EEPROM

    // mixed output
    output logic signed [15:0] audio_l, audio_r,
    output logic        audio_valid,

    // bench observability: the 6502's writes to the sound chips and latches
    output logic        dbg_ym_wr,      // with dbg_ym_a0 / dbg_d
    output logic        dbg_ym_a0,
    output logic        dbg_pk_wr,      // with dbg_pk_sel (0 = POKEY 1) / dbg_pk_reg / dbg_d
    output logic        dbg_pk_sel,
    output logic  [3:0] dbg_pk_reg,
    output logic        dbg_io_wr,      // 1874/1876/1878/187a/187c/187e: dbg_io_reg = A[3:1]
    output logic  [2:0] dbg_io_reg,
    output logic  [7:0] dbg_d,
    output logic        dbg_sync,
    output logic [15:0] dbg_addr
);
    // -------------------------------------------------------------------------
    // clock enables and reset
    // -------------------------------------------------------------------------
    logic cpu_phase;
    always_ff @(posedge clk) begin
        if (reset) cpu_phase <= 1'b0;
        else if (cen_ym) cpu_phase <= ~cpu_phase;
    end
    wire cen_cpu = cen_ym & cpu_phase;

    // the T11's reset bit holds the board; make sure T65 sees a clean edge
    logic [3:0] rst_cnt;
    always_ff @(posedge clk) begin
        if (reset || cpu_reset) rst_cnt <= 4'hf;
        else if (cen_cpu && rst_cnt != 4'd0) rst_cnt <= rst_cnt - 4'd1;
    end
    wire board_rst = reset | cpu_reset | (rst_cnt != 4'd0);

    // -------------------------------------------------------------------------
    // CPU
    // -------------------------------------------------------------------------
    wire [23:0] A24;
    wire [15:0] A = A24[15:0];
    wire  [7:0] cpu_do;
    wire        rw_n;
    wire        wr = ~rw_n;
    logic [7:0] cpu_di;
    logic       timed_int;
    wire        sync;

    T65 u_cpu (
        .Mode    (2'b00),
        .BCD_en  (1'b1),
        .Res_n   (~board_rst),
        .Enable  (cen_cpu),
        .Clk     (clk),
        .Rdy     (1'b1),
        .Abort_n (1'b1),
        .IRQ_n   (~timed_int),
        .NMI_n   (~cmd_full),
        .SO_n    (1'b1),
        .R_W_n   (rw_n),
        .Sync    (sync),
        .EF      (), .MF (), .XF (), .ML_n (), .VP_n (), .VDA (), .VPA (),
        .A       (A24),
        .DI      (cpu_di),
        .DO      (cpu_do),
        .Regs    (),
        .NMI_ack ()
    );
    assign dbg_sync = sync & cen_cpu;
    assign dbg_addr = A;
    wire unused_a = &{1'b0, A24[23:16], io[0]};

    // -------------------------------------------------------------------------
    // address decode (hardware.md 7.1; mirrors folded)
    // -------------------------------------------------------------------------
    wire sel_ram  = (A[15:14] == 2'b00) && (A[12] == 1'b0);                 // 0000-0fff, 2000-2fff
    wire sel_eep  = (A[15:14] == 2'b00) && (A[12] == 1'b1) && (A[11] == 1'b0);  // 1000-17ff mirrors
    wire sel_io   = (A[15:14] == 2'b00) && (A[12] == 1'b1) && (A[11] == 1'b1);  // 1800-1fff mirrors
    wire sel_rom  = A[15];                                                   // 8000-ffff
    wire [6:0] io = A[6:0];
    wire sel_pk1  = sel_io && (io[6:4] == 3'b000);                          // 00-0f
    wire sel_leta = sel_io && (io[6:4] == 3'b001);                          // 10-1f
    wire sel_pk2  = sel_io && (io[6:4] == 3'b011);                          // 30-3f
    wire sel_in1  = sel_io && (io[6:4] == 3'b100);                          // 40-4f
    wire sel_ym   = sel_io && (io[6:4] == 3'b101);                          // 50-5f
    wire sel_crd  = sel_io && (io[6:4] == 3'b110);                          // 60-6f
    wire sel_wr7  = sel_io && (io[6:4] == 3'b111);                          // 70-7f: write registers on A[3:1]
    wire [2:0] io7 = io[3:1];

    // -------------------------------------------------------------------------
    // RAM, ROM, EEPROM
    // -------------------------------------------------------------------------
    logic [7:0] ram [4096];
    logic [7:0] ram_q;
    always_ff @(posedge clk) begin
        if (cen_cpu && wr && sel_ram) ram[A[11:0]] <= cpu_do;
        ram_q <= ram[A[11:0]];
    end
    logic [7:0] rom [32768];
    logic [7:0] rom_q;
    always_ff @(posedge clk) begin
        if (rom_we) rom[rom_waddr] <= rom_wdata;
        rom_q <= rom[A[14:0]];
    end
    // EEPROM: no lock on this board (MAME's 2804 without lock_after_write).
    // 256 x 16 in a true dual-port block RAM (dpram_be) so the 6502 and the
    // Pocket's save port each own a write port: as a 512 x 8 array with two
    // write ports it inferred 4,096 flops behind a 512-way read mux, which
    // missed 96 MHz by 2.7 ns. Both reads keep their one-clock latency (the
    // RAM's registered word, then the byte picked by the address's bit 0).
    logic [15:0] eep_a_q, eep_b_q;
    dpram_be #(.AW(8)) u_eep (
        .clk(clk),
        .a_addr(A[8:1]), .a_we(cen_cpu && wr && sel_eep), .a_be({A[0], ~A[0]}), .a_wdata({cpu_do, cpu_do}), .a_rdata(eep_a_q),
        .b_addr(nv_addr[8:1]), .b_we(nv_we), .b_be({nv_addr[0], ~nv_addr[0]}), .b_wdata({nv_wdata, nv_wdata}), .b_rdata(eep_b_q)
    );
    wire [7:0] eep_q = A[0] ? eep_a_q[15:8] : eep_a_q[7:0];
    logic nv_a0_q;
    assign nv_rdata = nv_a0_q ? eep_b_q[15:8] : eep_b_q[7:0];
    always_ff @(posedge clk) begin
        nv_a0_q <= nv_addr[0];
        if (cen_cpu && wr && sel_eep) nv_dirty <= ~nv_dirty;
        if (reset) nv_dirty <= 1'b0;
    end

    // -------------------------------------------------------------------------
    // latches to / from the T11
    // -------------------------------------------------------------------------
    logic [7:0] cmd_byte;
    wire  rd_cmd  = cen_cpu && ~wr && sel_crd;
    wire  wr_resp = cen_cpu &&  wr && sel_wr7 && io7 == 3'd2;
    always_ff @(posedge clk) begin
        cmd_rd_pulse <= 1'b0; resp_wr_pulse <= 1'b0;
        if (reset) begin
            cmd_full <= 1'b0; cmd_byte <= 8'h00; resp_full <= 1'b0; resp_data <= 8'h00;
        end else begin
            if (cmd_wr) begin cmd_full <= 1'b1; cmd_byte <= cmd_data; end
            else if (rd_cmd) begin cmd_full <= 1'b0; cmd_rd_pulse <= 1'b1; end
            if (wr_resp) begin resp_full <= 1'b1; resp_data <= cpu_do; resp_wr_pulse <= 1'b1; end
            else if (resp_rd) resp_full <= 1'b0;
        end
    end

    // -------------------------------------------------------------------------
    // timed interrupt: 244.14 Hz, cleared by a write to 1878
    // -------------------------------------------------------------------------
    wire irq_ack = cen_cpu && wr && sel_wr7 && io7 == 3'd4;
    always_ff @(posedge clk) begin
        if (board_rst) timed_int <= 1'b0;
        else begin
            if (irq_ack) timed_int <= 1'b0;
            if (irq_tick) timed_int <= 1'b1;
        end
    end

    // -------------------------------------------------------------------------
    // mixer / sound enable / misc latches
    // -------------------------------------------------------------------------
    logic [2:0] ym_vol;
    logic [1:0] pk_vol;
    logic       snd_state;          // MAME m_sound_reset_state
    logic       ym_reset_n;         // YM2151 reset line (0 = held in reset)
    wire wr_mix = cen_cpu && wr && sel_wr7 && io7 == 3'd5;
    wire wr_sen = cen_cpu && wr && sel_wr7 && io7 == 3'd7;
    always_ff @(posedge clk) begin
        if (reset) begin
            ym_vol <= 3'd7; pk_vol <= 2'd3;            // gains 1.0 until the program writes the mixer
            snd_state <= 1'b0; ym_reset_n <= 1'b1;    // MAME: the chip starts out of reset, the state bit at 0
        end else begin
            if (wr_mix) begin ym_vol <= cpu_do[2:0]; pk_vol <= cpu_do[4:3]; end
            if (snd_reset_pulse) begin                 // sndrst_6502_w(0)
                if (snd_state) begin snd_state <= 1'b0; ym_reset_n <= 1'b0; end
            end
            if (wr_sen && cpu_do[0] != snd_state) begin
                snd_state  <= cpu_do[0];
                ym_reset_n <= cpu_do[0];
                if (cpu_do[0]) begin ym_vol <= 3'd0; pk_vol <= 2'd0; end   // mixer_w(0) on the 0->1 edge
            end
        end
    end

    // -------------------------------------------------------------------------
    // POKEYs (1.789772 MHz = the CPU enable)
    // -------------------------------------------------------------------------
    logic [7:0] pk1_q, pk2_q;
    logic [5:0] pk1_sum, pk2_sum;
    pokey u_pk1 (.clk(clk), .reset(board_rst), .cen(cen_cpu), .addr(A[3:0]), .we(cen_cpu && wr && sel_pk1), .wdata(cpu_do), .rdata(pk1_q), .allpot(dsw0), .sum(pk1_sum));
    pokey u_pk2 (.clk(clk), .reset(board_rst), .cen(cen_cpu), .addr(A[3:0]), .we(cen_cpu && wr && sel_pk2), .wdata(cpu_do), .rdata(pk2_q), .allpot(dsw1), .sum(pk2_sum));

    // -------------------------------------------------------------------------
    // YM2151: write strobe held for the whole CPU cycle (the BUSY flag is
    // sampled on the chip's own enable); writes while in reset are dropped
    // -------------------------------------------------------------------------
    logic       ym_wr_p, ym_a0_p;
    logic [7:0] ym_d_p;
    always_ff @(posedge clk) begin
        if (board_rst) ym_wr_p <= 1'b0;
        else if (cen_cpu) begin
            ym_wr_p <= wr && sel_ym && ym_reset_n;
            ym_a0_p <= A[0];
            ym_d_p  <= cpu_do;
        end
    end
    logic ym_rst;
    always_ff @(posedge clk) ym_rst <= board_rst | ~ym_reset_n;
    wire  [7:0] ym_dout;
    wire signed [15:0] ym_l, ym_r;
    jt51 u_ym (
        .rst    (ym_rst),
        .clk    (clk),
        .cen    (cen_ym),
        .cen_p1 (cen_cpu),
        .cs_n   (~ym_wr_p),
        .wr_n   (~ym_wr_p),
        .a0     (ym_a0_p),
        .din    (ym_d_p),
        .dout   (ym_dout),
        .ct1    (), .ct2 (), .irq_n (), .sample (),
        .left   (), .right (),
        .xleft  (ym_l),
        .xright (ym_r)
    );

    // -------------------------------------------------------------------------
    // CPU read mux
    // -------------------------------------------------------------------------
    // IN1: coins (active low) 7:5, self-test 4 (1 = off), 3 = 0, 2 = 1 (no TMS), 1 = P2TALK, 0 = P1TALK
    wire [7:0] in1 = {~coins[2], ~coins[1], ~coins[0], ~test, 1'b0, 1'b1, resp_full, cmd_full};
    wire [7:0] leta_q = (A[1:0] == 2'd0) ? leta0 : (A[1:0] == 2'd1) ? leta1 : (A[1:0] == 2'd2) ? leta2 : 8'hff;
    always_comb begin
        if      (sel_rom)  cpu_di = rom_q;
        else if (sel_ram)  cpu_di = ram_q;
        else if (sel_eep)  cpu_di = eep_q;
        else if (sel_pk1)  cpu_di = pk1_q;
        else if (sel_pk2)  cpu_di = pk2_q;
        else if (sel_leta) cpu_di = leta_q;
        else if (sel_in1)  cpu_di = in1;
        else if (sel_ym)   cpu_di = ym_dout;
        else if (sel_crd)  cpu_di = cmd_byte;
        else               cpu_di = 8'h00;            // 4000-7fff: no ROM fitted; unmapped I/O
    end

    // bench observability
    always_ff @(posedge clk) begin
        dbg_ym_wr  <= cen_cpu && wr && sel_ym;
        dbg_ym_a0  <= A[0];
        dbg_pk_wr  <= cen_cpu && wr && (sel_pk1 || sel_pk2);
        dbg_pk_sel <= sel_pk2;
        dbg_pk_reg <= A[3:0];
        dbg_io_wr  <= cen_cpu && wr && sel_wr7;
        dbg_io_reg <= io7;
        dbg_d      <= cpu_do;
    end

    // -------------------------------------------------------------------------
    // mixer (hardware.md 7.4), 12-bit fixed point gains:
    //   ym:    0.60 x gain(ym_vol)    pokey: 1.35 x gain(pk_vol)
    //   POKEY sample = min(sum x 745, 32767) (MAME LEGACY_LINEAR, 32767/11/4)
    // -------------------------------------------------------------------------
    function automatic logic [12:0] k_ym(input logic [2:0] v);
        case (v) 3'd0: k_ym = 13'd508; 3'd1: k_ym = 13'd567; 3'd2: k_ym = 13'd651; 3'd3: k_ym = 13'd751;
                 3'd4: k_ym = 13'd958; 3'd5: k_ym = 13'd1191; 3'd6: k_ym = 13'd1638; default: k_ym = 13'd2458; endcase
    endfunction
    function automatic logic [12:0] k_pk(input logic [1:0] v);
        case (v) 2'd0: k_pk = 13'd1275; 2'd1: k_pk = 13'd1690; 2'd2: k_pk = 13'd2679; default: k_pk = 13'd5530; endcase
    endfunction
    function automatic logic signed [15:0] pk_sample(input logic [5:0] s);
        logic [15:0] p;
        p = 16'(s) * 16'd745;
        pk_sample = (p > 16'd32767) ? 16'sd32767 : 16'(p);
    endfunction
    logic signed [15:0] pk1_s, pk2_s;
    logic signed [29:0] yl, yr, pl, pr;
    logic signed [19:0] ml, mr;
    logic [2:0] ph;
    always_ff @(posedge clk) begin
        if (reset) begin
            pk1_s <= '0; pk2_s <= '0; yl <= '0; yr <= '0; pl <= '0; pr <= '0; ml <= '0; mr <= '0;
            audio_l <= '0; audio_r <= '0; audio_valid <= 1'b0; ph <= '0;
        end else begin
            audio_valid <= 1'b0;
            ph <= {ph[1:0], cen_ym};
            if (cen_ym) begin pk1_s <= pk_sample(pk1_sum); pk2_s <= pk_sample(pk2_sum); end
            if (ph[0]) begin
                yl <= ym_l * $signed({1'b0, k_ym(ym_vol)});
                yr <= ym_r * $signed({1'b0, k_ym(ym_vol)});
                pl <= pk1_s * $signed({1'b0, k_pk(pk_vol)});
                pr <= pk2_s * $signed({1'b0, k_pk(pk_vol)});
            end
            if (ph[2]) begin
                ml <= 20'(yl >>> 12) + 20'(pl >>> 12);
                mr <= 20'(yr >>> 12) + 20'(pr >>> 12);
                audio_valid <= 1'b1;
            end
            if (audio_valid) begin
                audio_l <= (ml > 20'sd32767) ? 16'sh7fff : (ml < -20'sd32768) ? 16'sh8000 : 16'(ml);
                audio_r <= (mr > 20'sd32767) ? 16'sh7fff : (mr < -20'sd32768) ? 16'sh8000 : 16'(mr);
            end
        end
    end
endmodule

`default_nettype wire
