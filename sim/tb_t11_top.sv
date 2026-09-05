// T11 CPU bench wrapper: the core, the slapstic and the main board's memories
// (work RAM, palette RAM, the four video RAM banks, fixed and banked program
// ROM) with single-cycle acks, plus an I/O port the C++ side answers from a
// MAME read log (tools/trace_t11.lua) so every I/O read returns exactly what
// MAME's did. Writes to the I/O page only act on the bank select registers.
`default_nettype none

module tb_t11_top (
    input  logic        clk,
    input  logic        reset,
    input  logic        cen,
    input  logic  [3:0] cp,
    // window start state
    input  logic        init_en,
    input  logic  [5:0] init_bank1, init_bank2,
    input  logic  [1:0] init_slap,
    // I/O page 1400-1fff reads: level while the read is pending; the C++
    // drives io_rdata before the ack edge; io_ack pulses when it was consumed
    output logic        io_rd,
    output logic [15:0] io_addr,
    input  logic [15:0] io_rdata,
    output logic        io_ack,
    output logic        io_wr_pulse,
    output logic [15:0] io_wdata,
    // observability
    output logic        dbg_done,
    output logic [15:0] dbg_pc,
    output logic  [7:0] dbg_psw,
    output logic        dbg_wait,
    output logic  [1:0] slap_bank,
    output logic        bus_strobe,
    output logic [15:0] bus_addr_o,
    output logic        bus_wr_o,
    output logic  [5:0] bank1, bank2
);
    logic [15:0] bus_addr, bus_wdata, bus_rdata;
    logic        bus_rd, bus_wr, bus_ack, bus_fetch;
    logic  [1:0] bus_be;

    t11 cpu (
        .clk(clk), .reset(reset), .cen(cen),
        .bus_addr(bus_addr), .bus_rd(bus_rd), .bus_wr(bus_wr), .bus_be(bus_be), .bus_wdata(bus_wdata),
        .bus_rdata(bus_rdata), .bus_ack(bus_ack), .bus_fetch(bus_fetch),
        .cp(cp),
        .dbg_pc(dbg_pc), .dbg_done(dbg_done), .dbg_psw(dbg_psw), .dbg_wait(dbg_wait)
    );
    wire unused_ok = &{1'b0, bus_fetch};

    // ---- memories (public for the C++ loader) ----------------------------
    logic [15:0] ram    [0:2047]   /* verilator public_flat_rw */;   // 0000-0fff
    logic [15:0] pal    [0:255]    /* verilator public_flat_rw */;   // 1000-11ff (mirror 1200)
    logic [15:0] alpha  [0:3071]   /* verilator public_flat_rw */;   // bank 0 2000-37ff
    logic [15:0] mob    [0:1023]   /* verilator public_flat_rw */;   // bank 0 3800-3fff
    logic [15:0] pft    [0:4095]   /* verilator public_flat_rw */;   // bank 2
    logic [15:0] pfb    [0:4095]   /* verilator public_flat_rw */;   // bank 3
    logic [15:0] rom    [0:16383]  /* verilator public_flat_rw */;   // 8000-ffff
    logic [15:0] bankrom[0:262143] /* verilator public_flat_rw */;   // 64 x 8 KB

    // ---- decode -------------------------------------------------------------
    wire [15:0] a = bus_addr;
    wire sel_ram  = (a[15:12] == 4'h0);
    wire sel_pal  = (a[15:10] == 6'b000100);          // 1000-13ff
    wire sel_io   = (a[15:10] == 6'b000101) || (a[15:11] == 5'b00011);   // 1400-1fff
    wire sel_vram = (a[15:13] == 3'b001);             // 2000-3fff
    wire sel_bnk1 = (a[15:13] == 3'b010);             // 4000-5fff
    wire sel_bnk2 = (a[15:13] == 3'b011);             // 6000-7fff
    wire sel_rom  = a[15];                            // 8000-ffff
    wire sel_alpha = sel_vram && slap_bank == 2'd0 && a[12:11] != 2'b11;
    wire sel_mob   = sel_vram && slap_bank == 2'd0 && a[12:11] == 2'b11;
    wire sel_pft   = sel_vram && slap_bank == 2'd2;
    wire sel_pfb   = sel_vram && slap_bank == 2'd3;

    // bank select (bankselect_w): b = ((data >> 10) & 0x3f) ^ 3; bank = {b5,b4,b1,b0,b3,b2}
    wire [5:0] bsel = bus_wdata[15:10] ^ 6'b000011;
    wire [5:0] bnum = {bsel[5], bsel[4], bsel[1], bsel[0], bsel[3], bsel[2]};

    // ---- slapstic sees every cycle ---------------------------------------
    wire req = (bus_rd | bus_wr);
    logic req_d;
    always_ff @(posedge clk) req_d <= req & ~bus_ack;      // rises once per access
    assign bus_strobe = req && !req_d && !bus_ack;         // first clock of a request
    slapstic108 slap (.clk(clk), .reset(reset), .strobe(bus_strobe), .addr(bus_addr), .bank(slap_bank), .init_en(init_en), .init_bank(init_slap));
    assign bus_addr_o = bus_addr;
    assign bus_wr_o = bus_wr;

    // ---- access: ack one clock after the request, data registered with it ----
    logic ack_q;
    assign bus_ack = ack_q;
    assign io_rd   = bus_rd && sel_io && !ack_q;
    assign io_addr = bus_addr;
    always_ff @(posedge clk) begin
        io_ack <= 1'b0; io_wr_pulse <= 1'b0;
        if (reset) begin ack_q <= 1'b0; bank1 <= 6'd0; bank2 <= 6'd0; end
        else if (init_en) begin bank1 <= init_bank1; bank2 <= init_bank2; end
        else begin
            ack_q <= req && !ack_q;
            if (req && !ack_q) begin
                // read data
                if (sel_ram)        bus_rdata <= ram[a[11:1]];
                else if (sel_pal)   bus_rdata <= pal[a[8:1]];
                else if (sel_io)    begin bus_rdata <= io_rdata; if (bus_rd) io_ack <= 1'b1; end
                else if (sel_alpha) bus_rdata <= alpha[a[12:1]];
                else if (sel_mob)   bus_rdata <= mob[a[10:1]];
                else if (sel_pft)   bus_rdata <= pft[a[12:1]];
                else if (sel_pfb)   bus_rdata <= pfb[a[12:1]];
                else if (sel_bnk1)  bus_rdata <= bankrom[{bank1, a[12:1]}];
                else if (sel_bnk2)  bus_rdata <= bankrom[{bank2, a[12:1]}];
                else if (sel_rom)   bus_rdata <= rom[a[14:1]];
                else                bus_rdata <= 16'hffff;
                // writes
                if (bus_wr) begin
                    if (sel_ram) begin
                        if (bus_be[0]) ram[a[11:1]][7:0]  <= bus_wdata[7:0];
                        if (bus_be[1]) ram[a[11:1]][15:8] <= bus_wdata[15:8];
                    end
                    if (sel_pal) begin
                        if (bus_be[0]) pal[a[8:1]][7:0]  <= bus_wdata[7:0];
                        if (bus_be[1]) pal[a[8:1]][15:8] <= bus_wdata[15:8];
                    end
                    if (sel_alpha) begin
                        if (bus_be[0]) alpha[a[12:1]][7:0]  <= bus_wdata[7:0];
                        if (bus_be[1]) alpha[a[12:1]][15:8] <= bus_wdata[15:8];
                    end
                    if (sel_mob) begin
                        if (bus_be[0]) mob[a[10:1]][7:0]  <= bus_wdata[7:0];
                        if (bus_be[1]) mob[a[10:1]][15:8] <= bus_wdata[15:8];
                    end
                    if (sel_pft) begin
                        if (bus_be[0]) pft[a[12:1]][7:0]  <= bus_wdata[7:0];
                        if (bus_be[1]) pft[a[12:1]][15:8] <= bus_wdata[15:8];
                    end
                    if (sel_pfb) begin
                        if (bus_be[0]) pfb[a[12:1]][7:0]  <= bus_wdata[7:0];
                        if (bus_be[1]) pfb[a[12:1]][15:8] <= bus_wdata[15:8];
                    end
                    if (sel_io) begin
                        io_wr_pulse <= 1'b1; io_wdata <= bus_wdata;
                        // 1400-1403 mirror 0x7c: 1400 = bank 1, 1402 = bank 2
                        if (a[15:7] == 9'b000101000 && a[1] == 1'b0) bank1 <= bnum;
                        if (a[15:7] == 9'b000101000 && a[1] == 1'b1) bank2 <= bnum;
                    end
                end
            end
        end
    end
endmodule

`default_nettype wire
