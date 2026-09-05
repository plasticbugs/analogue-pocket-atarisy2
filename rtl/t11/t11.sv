//------------------------------------------------------------------------------
// DEC T-11 (DCT11) CPU core: the PDP-11 instruction set as the T11 implements
// it (LEIS without MARK, plus MFPT/MFPS/MTPS), written from MAME's t11.cpp /
// t11ops.hxx (ref/mame) and verified instruction by instruction against MAME
// traces (sim/run_t11.sh). Not cycle exact internally; every instruction is
// held to MAME's cycle count (the T-11 User's Guide figures) in `cen` ticks,
// so with fast memory the execution rate is MAME's.
//
// Bus: 16-bit, little-endian, byte addressed. `bus_rd`/`bus_wr` are levels
// held until `bus_ack`; the address, byte enables and write data are stable
// for the whole request. Word accesses clear address bit 0 (as the T11 does:
// "word accesses ignore the low bit", t11ops.hxx). A byte read returns the
// selected lane; a byte write drives the byte on both lanes with one enable.
// Every access, instruction fetches included, appears on the bus (the
// slapstic watches them all), and MOV/CLR/SXT to memory perform the T11's
// read-before-write bus sequence.
//
// Interrupts: the four coded inputs CP0-CP3 are levels (the board holds them
// in flip-flops); their priority/vector table is the T11's nonvectored one.
// An interrupt is taken between instructions when its priority exceeds
// PSW[7:5]; entry pushes PSW then PC and loads PC/PSW from the vector.
//------------------------------------------------------------------------------
`default_nettype none

module t11 #(
    parameter [15:0] INITIAL_PC = 16'h8000     // mode word 0x36ff -> 0x8000 (docs/hardware.md)
) (
    input  logic        clk,
    input  logic        reset,
    input  logic        cen,            // 10 MHz enable: the instruction cycle budget counts these

    // bus
    output logic [15:0] bus_addr,
    output logic        bus_rd,
    output logic        bus_wr,
    output logic  [1:0] bus_be,         // [0] = D7:0 (even byte), [1] = D15:8 (odd byte)
    output logic [15:0] bus_wdata,
    input  logic [15:0] bus_rdata,      // valid with bus_ack
    input  logic        bus_ack,        // one-clock pulse
    output logic        bus_fetch,      // this read is an opcode or an in-stream operand

    // interrupt inputs, active high levels
    input  logic  [3:0] cp,

    // debug / bench
    output logic [15:0] dbg_pc,         // address of the instruction being executed
    output logic        dbg_done,       // one-clock pulse as an instruction retires (before the next fetch)
    output logic  [7:0] dbg_psw,
    output logic        dbg_wait
);
    // ------------------------------------------------------------------------
    // registers
    // ------------------------------------------------------------------------
    logic [15:0] r [0:7] /* verilator public_flat_rw */;
    logic  [7:0] psw     /* verilator public_flat_rw */;
    wire         f_c = psw[0], f_v = psw[1], f_z = psw[2], f_n = psw[3];
    wire  [2:0]  prio = psw[7:5];
    assign dbg_psw = psw;

    // ------------------------------------------------------------------------
    // instruction decode (registered in S_DECODE)
    // ------------------------------------------------------------------------
    typedef enum logic [3:0] {
        C_DOUBLE, C_SINGLE, C_JMP, C_JSR, C_BR, C_SOB, C_RTS, C_CC, C_RTI, C_TRAP, C_HALT, C_WAIT, C_RESET, C_MFPT, C_NOP
    } cls_t;
    typedef enum logic [4:0] {
        A_MOV, A_CMP, A_BIT, A_BIC, A_BIS, A_ADD, A_SUB, A_XOR,
        A_CLR, A_COM, A_INC, A_DEC, A_NEG, A_ADC, A_SBC, A_TST,
        A_ROR, A_ROL, A_ASR, A_ASL, A_SXT, A_SWAB, A_MFPS, A_MTPS
    } alu_t;

    logic [15:0] ir;
    logic [15:0] ipc;                   // PC of the current instruction
    cls_t        cls;
    alu_t        aop;
    logic        is_byte;
    logic  [2:0] s_mode, s_reg, d_mode, d_reg;
    logic        dst_read, dst_write, src_is_reg_only;   // src_is_reg_only: XOR takes its source from a register
    logic  [7:0] budget;
    logic  [7:0] trap_vec;
    logic        br_take;

    // opcode fields
    wire  [2:0]  dmode = ir[5:3], dreg = ir[2:0], smode = ir[11:9], sreg = ir[8:6];

    // cycle costs (t11ops.hxx)
    function automatic logic [7:0] cost_single(input logic [2:0] m);   // CLR..ASL, SXT, SWAB, XOR, MFPS
        case (m) 3'd0: cost_single = 8'd12; 3'd1: cost_single = 8'd21; 3'd2: cost_single = 8'd21; 3'd3: cost_single = 8'd27;
                 3'd4: cost_single = 8'd24; 3'd5: cost_single = 8'd30; 3'd6: cost_single = 8'd30; default: cost_single = 8'd36; endcase
    endfunction
    function automatic logic [7:0] cost_tst(input logic [2:0] m);
        case (m) 3'd0: cost_tst = 8'd12; 3'd1: cost_tst = 8'd18; 3'd2: cost_tst = 8'd18; 3'd3: cost_tst = 8'd24;
                 3'd4: cost_tst = 8'd21; 3'd5: cost_tst = 8'd27; 3'd6: cost_tst = 8'd27; default: cost_tst = 8'd33; endcase
    endfunction
    function automatic logic [7:0] cost_mtps(input logic [2:0] m);
        case (m) 3'd0: cost_mtps = 8'd24; 3'd1: cost_mtps = 8'd30; 3'd2: cost_mtps = 8'd30; 3'd3: cost_mtps = 8'd36;
                 3'd4: cost_mtps = 8'd33; 3'd5: cost_mtps = 8'd39; 3'd6: cost_mtps = 8'd39; default: cost_mtps = 8'd45; endcase
    endfunction
    function automatic logic [7:0] cost_jmp(input logic [2:0] m);
        case (m) 3'd1: cost_jmp = 8'd15; 3'd2: cost_jmp = 8'd18; 3'd3: cost_jmp = 8'd18; 3'd4: cost_jmp = 8'd18;
                 3'd5: cost_jmp = 8'd21; 3'd6: cost_jmp = 8'd21; default: cost_jmp = 8'd27; endcase
    endfunction
    function automatic logic [7:0] cost_src(input logic [2:0] m);
        case (m) 3'd0: cost_src = 8'd9; 3'd1: cost_src = 8'd15; 3'd2: cost_src = 8'd15; 3'd3: cost_src = 8'd21;
                 3'd4: cost_src = 8'd18; 3'd5: cost_src = 8'd24; 3'd6: cost_src = 8'd24; default: cost_src = 8'd30; endcase
    endfunction
    function automatic logic [7:0] cost_dstw(input logic [2:0] m);   // MOV/BIC/BIS/ADD/SUB destination
        case (m) 3'd0: cost_dstw = 8'd3; 3'd1: cost_dstw = 8'd12; 3'd2: cost_dstw = 8'd12; 3'd3: cost_dstw = 8'd18;
                 3'd4: cost_dstw = 8'd15; 3'd5: cost_dstw = 8'd21; 3'd6: cost_dstw = 8'd21; default: cost_dstw = 8'd27; endcase
    endfunction
    function automatic logic [7:0] cost_dstr(input logic [2:0] m);   // CMP/BIT destination
        case (m) 3'd0: cost_dstr = 8'd3; 3'd1: cost_dstr = 8'd9; 3'd2: cost_dstr = 8'd9; 3'd3: cost_dstr = 8'd15;
                 3'd4: cost_dstr = 8'd12; 3'd5: cost_dstr = 8'd18; 3'd6: cost_dstr = 8'd18; default: cost_dstr = 8'd24; endcase
    endfunction

    // ------------------------------------------------------------------------
    // ALU
    // ------------------------------------------------------------------------
    // res: result; nzvc: new flag values; upd: which of N,Z,V,C to update
    logic [15:0] alu_res;
    logic  [3:0] alu_nzvc, alu_upd;     // bit 3 = N, 2 = Z, 1 = V, 0 = C
    logic [15:0] alu_src, alu_dst;      // operands (byte ops: low byte meaningful)
    assign alu_dst = dst_val;
    assign alu_src = (aop == A_ADC || aop == A_SBC) ? {15'd0, f_c} : src_val;
    always_comb begin
        logic [16:0] sum;
        logic [8:0]  sumb;
        logic        n, z, v, c;
        logic [15:0] res;
        res = 16'h0000; n = 1'b0; z = 1'b0; v = 1'b0; c = 1'b0; sum = 17'd0; sumb = 9'd0;
        alu_upd = 4'b1111;
        case (aop)
            A_MOV: begin res = alu_src; alu_upd = 4'b1110; v = 1'b0; end
            A_BIT: begin res = alu_dst & alu_src;  alu_upd = 4'b1110; end
            A_BIC: begin res = alu_dst & ~alu_src; alu_upd = 4'b1110; end
            A_BIS: begin res = alu_dst | alu_src;  alu_upd = 4'b1110; end
            A_XOR: begin res = alu_dst ^ alu_src;  alu_upd = 4'b1110; end
            A_ADD, A_ADC: begin
                sum  = {1'b0, alu_dst} + {1'b0, alu_src};
                sumb = {1'b0, alu_dst[7:0]} + {1'b0, alu_src[7:0]};
                res  = sum[15:0];
            end
            A_SUB, A_SBC: begin
                sum  = {1'b0, alu_dst} - {1'b0, alu_src};
                sumb = {1'b0, alu_dst[7:0]} - {1'b0, alu_src[7:0]};
                res  = sum[15:0];
            end
            A_CMP: begin
                sum  = {1'b0, alu_src} - {1'b0, alu_dst};
                sumb = {1'b0, alu_src[7:0]} - {1'b0, alu_dst[7:0]};
                res  = sum[15:0];
            end
            A_CLR: begin res = 16'h0000; end
            A_COM: begin res = ~alu_dst; c = 1'b1; end
            A_INC: begin res = alu_dst + 16'd1; alu_upd = 4'b1110; v = is_byte ? (alu_dst[7:0] == 8'h7f) : (alu_dst == 16'h7fff); end
            A_DEC: begin res = alu_dst - 16'd1; alu_upd = 4'b1110; v = is_byte ? (alu_dst[7:0] == 8'h80) : (alu_dst == 16'h8000); end
            A_NEG: begin res = -alu_dst; v = is_byte ? (alu_dst[7:0] == 8'h80) : (alu_dst == 16'h8000);
                         c = is_byte ? (res[7:0] != 8'h00) : (res != 16'h0000); end
            A_TST: begin res = alu_dst; end
            A_ROR: begin
                if (is_byte) res = {8'h00, f_c, alu_dst[7:1]}; else res = {f_c, alu_dst[15:1]};
                c = alu_dst[0];
            end
            A_ROL: begin
                if (is_byte) begin res = {8'h00, alu_dst[6:0], f_c}; c = alu_dst[7]; end
                else begin res = {alu_dst[14:0], f_c}; c = alu_dst[15]; end
            end
            A_ASR: begin
                if (is_byte) res = {8'h00, alu_dst[7], alu_dst[7:1]}; else res = {alu_dst[15], alu_dst[15:1]};
                c = alu_dst[0];
            end
            A_ASL: begin
                if (is_byte) begin res = {8'h00, alu_dst[6:0], 1'b0}; c = alu_dst[7]; end
                else begin res = {alu_dst[14:0], 1'b0}; c = alu_dst[15]; end
            end
            A_SXT: begin res = f_n ? 16'hffff : 16'h0000; alu_upd = 4'b0110; z = ~f_n; v = 1'b0; end
            A_SWAB: begin res = {alu_dst[7:0], alu_dst[15:8]}; end
            A_MFPS: begin res = {{8{psw[7]}}, psw}; alu_upd = 4'b1110; end
            default: begin res = alu_dst; alu_upd = 4'b0000; end
        endcase
        // N and Z from the result at the operation width
        if (is_byte) begin n = res[7]; z = (res[7:0] == 8'h00); end
        else begin n = res[15]; z = (res == 16'h0000); end
        case (aop)
            A_ADD, A_ADC, A_SUB, A_SBC, A_CMP: begin
                // V = carry into the sign bit ^ carry out of it (the same
                // expression MAME uses: (s ^ d ^ r ^ (r >> 1)) at the sign bit)
                if (is_byte) begin
                    c = sumb[8];
                    v = alu_src[7] ^ alu_dst[7] ^ sumb[7] ^ sumb[8];
                end else begin
                    c = sum[16];
                    v = alu_src[15] ^ alu_dst[15] ^ sum[15] ^ sum[16];
                end
            end
            A_ROR, A_ROL, A_ASR, A_ASL: v = n ^ c;
            A_SWAB: begin n = res[7]; z = (res[7:0] == 8'h00); v = 1'b0; c = 1'b0; end
            A_MFPS: begin n = psw[7]; z = (psw == 8'h00); v = 1'b0; end
            A_SXT: n = f_n;
            default: ;
        endcase
        alu_res  = res;
        alu_nzvc = {n, z, v, c};
    end

    // ------------------------------------------------------------------------
    // interrupt priority / vector (t11.cpp irq_table, nonvectored)
    // ------------------------------------------------------------------------
    logic [2:0] irq_prio;
    logic [7:0] irq_vec;
    always_comb begin
        case (cp)
            4'd1:  begin irq_prio = 3'd4; irq_vec = 8'h38; end
            4'd2:  begin irq_prio = 3'd4; irq_vec = 8'h34; end
            4'd3:  begin irq_prio = 3'd4; irq_vec = 8'h30; end
            4'd4:  begin irq_prio = 3'd5; irq_vec = 8'h5c; end
            4'd5:  begin irq_prio = 3'd5; irq_vec = 8'h58; end
            4'd6:  begin irq_prio = 3'd5; irq_vec = 8'h54; end
            4'd7:  begin irq_prio = 3'd5; irq_vec = 8'h50; end
            4'd8:  begin irq_prio = 3'd6; irq_vec = 8'h4c; end
            4'd9:  begin irq_prio = 3'd6; irq_vec = 8'h48; end
            4'd10: begin irq_prio = 3'd6; irq_vec = 8'h44; end
            4'd11: begin irq_prio = 3'd6; irq_vec = 8'h40; end
            4'd12: begin irq_prio = 3'd7; irq_vec = 8'h6c; end
            4'd13: begin irq_prio = 3'd7; irq_vec = 8'h68; end
            4'd14: begin irq_prio = 3'd7; irq_vec = 8'h64; end
            4'd15: begin irq_prio = 3'd7; irq_vec = 8'h60; end
            default: begin irq_prio = 3'd0; irq_vec = 8'h00; end
        endcase
    end
    wire irq_take = (cp != 4'd0) && (irq_prio > prio);

    // ------------------------------------------------------------------------
    // sequencer
    // ------------------------------------------------------------------------
    typedef enum logic [4:0] {
        S_RESET, S_FETCH, S_DECODE,
        S_EA, S_IDX, S_IND, S_RD,         // operand engine
        S_EXEC, S_WR,
        S_JSR_PUSH, S_RTS_POP, S_RTI_POP1, S_RTI_POP2,
        S_INT_PUSH1, S_INT_PUSH2, S_INT_VEC1, S_INT_VEC2,
        S_PAD, S_WAIT
    } state_t;
    state_t state;

    logic        opsel;                 // operand engine: 0 = source, 1 = destination
    logic [15:0] ea;                    // effective address of the current operand (the destination's at write-back)
    logic [15:0] src_val, dst_val;
    logic  [7:0] cyc;                   // cen ticks since the fetch started
    logic  [7:0] vec;                   // trap / interrupt vector
    logic        halt_entry;            // HALT: no vector fetch, PC = INITIAL_PC + 4
    logic        wait_state;
    logic        dummy_read;            // MOV/CLR/SXT: read the destination and discard
    logic [15:0] wr_val;                // result latched for the memory write-back: the ALU's
                                        // combinational result changes once the flags are updated
                                        // (ROR/ROL read C, MFPS reads the whole PSW)

    wire  [2:0] cur_mode = opsel ? d_mode : s_mode;
    wire  [2:0] cur_reg  = opsel ? d_reg  : s_reg;
    // autoincrement/decrement amount: 1 for byte accesses through R0-R5, else 2
    wire  [15:0] step = (is_byte && cur_reg < 3'd6) ? 16'd1 : 16'd2;
    wire  cur_is_byte_mem = is_byte;    // memory operand width for reads/writes
    // a read of the current operand is wanted?
    wire  need_read = opsel ? (dst_read || dummy_read) : 1'b1;

    // bus request bookkeeping: raise, hold until ack (macros rather than
    // tasks so every assignment is visibly inside the one always_ff)
`define BUS_READ(a, byte_acc, fetch) \
        begin bus_addr <= (byte_acc) ? (a) : ((a) & 16'hfffe); \
              bus_be   <= (byte_acc) ? ((((a) & 16'h0001) != 16'h0000) ? 2'b10 : 2'b01) : 2'b11; \
              bus_rd   <= 1'b1; bus_fetch <= (fetch); end
`define BUS_WRITE(a, byte_acc, d) \
        begin bus_addr  <= (byte_acc) ? (a) : ((a) & 16'hfffe); \
              bus_be    <= (byte_acc) ? ((((a) & 16'h0001) != 16'h0000) ? 2'b10 : 2'b01) : 2'b11; \
              bus_wdata <= (byte_acc) ? {8'((d)), 8'((d))} : (d); \
              bus_wr    <= 1'b1; bus_fetch <= 1'b0; end
    // read data as the operand value
    wire [15:0] rd_val = cur_is_byte_mem ? (bus_addr[0] ? {8'h00, bus_rdata[15:8]} : {8'h00, bus_rdata[7:0]}) : bus_rdata;

    assign dbg_pc   = ipc;
    assign dbg_wait = wait_state;

    always_ff @(posedge clk) begin
        dbg_done <= 1'b0;
        if (cen) cyc <= cyc + 8'd1;
        if (bus_ack) begin bus_rd <= 1'b0; bus_wr <= 1'b0; end

        if (reset) begin
            state <= S_RESET;
            bus_rd <= 1'b0; bus_wr <= 1'b0; bus_fetch <= 1'b0; bus_addr <= '0; bus_be <= 2'b00; bus_wdata <= '0;
            for (int i = 0; i < 8; i++) r[i] <= 16'h0000;
            r[6] <= 16'h00fe;
            r[7] <= INITIAL_PC;
            psw  <= 8'he0;
            wait_state <= 1'b0; halt_entry <= 1'b0; cyc <= '0; ipc <= INITIAL_PC;
            opsel <= 1'b0; ea <= '0; wr_val <= '0; src_val <= '0; dst_val <= '0; vec <= '0; dummy_read <= 1'b0;
            ir <= '0; cls <= C_NOP; aop <= A_MOV; is_byte <= 1'b0; s_mode <= '0; s_reg <= '0; d_mode <= '0; d_reg <= '0;
            dst_read <= 1'b0; dst_write <= 1'b0; src_is_reg_only <= 1'b0; budget <= '0; trap_vec <= '0; br_take <= 1'b0;
        end else case (state)
            S_RESET: state <= S_FETCH;

            // ---------------------------------------------------------------
            S_FETCH: begin
                if (!bus_rd) begin
                    `BUS_READ(r[7], 1'b0, 1'b1)
                    ipc <= r[7];
                    cyc <= 8'd0;
                end else if (bus_ack) begin
                    ir   <= bus_rdata;
                    r[7] <= r[7] + 16'd2;
                    state <= S_DECODE;
                end
            end

            // ---------------------------------------------------------------
            S_DECODE: begin
                // defaults
                is_byte <= ir[15];
                s_mode <= smode; s_reg <= sreg; d_mode <= dmode; d_reg <= dreg;
                dst_read <= 1'b1; dst_write <= 1'b1; src_is_reg_only <= 1'b0; dummy_read <= 1'b0;
                opsel <= 1'b1; halt_entry <= 1'b0; br_take <= 1'b0;
                cls <= C_SINGLE; aop <= A_MOV; trap_vec <= 8'h08; budget <= 8'd48;
                state <= S_EA;
                casez (ir)
                    // ---- double operand ----------------------------------
                    16'b?001_????_????_????,   // MOV / MOVB
                    16'b?010_????_????_????,   // CMP / CMPB
                    16'b?011_????_????_????,   // BIT / BITB
                    16'b?100_????_????_????,   // BIC / BICB
                    16'b?101_????_????_????,   // BIS / BISB
                    16'b?110_????_????_????: begin   // ADD / SUB
                        cls <= C_DOUBLE; opsel <= 1'b0;
                        case (ir[14:12])
                            3'd1: begin aop <= A_MOV; dummy_read <= 1'b1; dst_read <= 1'b0; end
                            3'd2: begin aop <= A_CMP; dst_write <= 1'b0; end
                            3'd3: begin aop <= A_BIT; dst_write <= 1'b0; end
                            3'd4: aop <= A_BIC;
                            3'd5: aop <= A_BIS;
                            default: aop <= ir[15] ? A_SUB : A_ADD;
                        endcase
                        if (ir[14:12] == 3'd6) is_byte <= 1'b0;   // ADD/SUB are word ops
                        budget <= cost_src(smode) + ((ir[14:12] == 3'd2 || ir[14:12] == 3'd3) ? cost_dstr(dmode) : cost_dstw(dmode));
                    end
                    // ---- single operand, word --------------------------
                    16'b0000_1010_00??_????: begin aop <= A_CLR; dummy_read <= 1'b1; dst_read <= 1'b0; budget <= cost_single(dmode); end
                    16'b0000_1010_01??_????: begin aop <= A_COM; budget <= cost_single(dmode); end
                    16'b0000_1010_10??_????: begin aop <= A_INC; budget <= cost_single(dmode); end
                    16'b0000_1010_11??_????: begin aop <= A_DEC; budget <= cost_single(dmode); end
                    16'b0000_1011_00??_????: begin aop <= A_NEG; budget <= cost_single(dmode); end
                    16'b0000_1011_01??_????: begin aop <= A_ADC; budget <= cost_single(dmode); end
                    16'b0000_1011_10??_????: begin aop <= A_SBC; budget <= cost_single(dmode); end
                    16'b0000_1011_11??_????: begin aop <= A_TST; dst_write <= 1'b0; budget <= cost_tst(dmode); end
                    16'b0000_1100_00??_????: begin aop <= A_ROR; budget <= cost_single(dmode); end
                    16'b0000_1100_01??_????: begin aop <= A_ROL; budget <= cost_single(dmode); end
                    16'b0000_1100_10??_????: begin aop <= A_ASR; budget <= cost_single(dmode); end
                    16'b0000_1100_11??_????: begin aop <= A_ASL; budget <= cost_single(dmode); end
                    16'b0000_1101_11??_????: begin aop <= A_SXT; dummy_read <= 1'b1; dst_read <= 1'b0; budget <= cost_single(dmode); end
                    16'b0000_0000_11??_????: begin aop <= A_SWAB; budget <= cost_single(dmode); end
                    // ---- single operand, byte --------------------------
                    16'b1000_1010_00??_????: begin aop <= A_CLR; dummy_read <= 1'b1; dst_read <= 1'b0; budget <= cost_single(dmode); end
                    16'b1000_1010_01??_????: begin aop <= A_COM; budget <= cost_single(dmode); end
                    16'b1000_1010_10??_????: begin aop <= A_INC; budget <= cost_single(dmode); end
                    16'b1000_1010_11??_????: begin aop <= A_DEC; budget <= cost_single(dmode); end
                    16'b1000_1011_00??_????: begin aop <= A_NEG; budget <= cost_single(dmode); end
                    16'b1000_1011_01??_????: begin aop <= A_ADC; budget <= cost_single(dmode); end
                    16'b1000_1011_10??_????: begin aop <= A_SBC; budget <= cost_single(dmode); end
                    16'b1000_1011_11??_????: begin aop <= A_TST; dst_write <= 1'b0; budget <= cost_tst(dmode); end
                    16'b1000_1100_00??_????: begin aop <= A_ROR; budget <= cost_single(dmode); end
                    16'b1000_1100_01??_????: begin aop <= A_ROL; budget <= cost_single(dmode); end
                    16'b1000_1100_10??_????: begin aop <= A_ASR; budget <= cost_single(dmode); end
                    16'b1000_1100_11??_????: begin aop <= A_ASL; budget <= cost_single(dmode); end
                    16'b1000_1101_00??_????: begin aop <= A_MTPS; dst_write <= 1'b0; budget <= cost_mtps(dmode); end
                    16'b1000_1101_11??_????: begin aop <= A_MFPS; dst_read <= 1'b0; is_byte <= 1'b1; budget <= cost_single(dmode); end
                    // ---- XOR (LEIS): register source in bits 8:6 --------
                    16'b0111_100?_????_????: begin aop <= A_XOR; is_byte <= 1'b0; src_is_reg_only <= 1'b1; opsel <= 1'b0; budget <= cost_single(dmode); end
                    // ---- SOB ---------------------------------------------
                    16'b0111_111?_????_????: begin cls <= C_SOB; budget <= 8'd18; state <= S_EXEC; end
                    // ---- branches ----------------------------------------
                    16'b0000_0001_????_????: begin cls <= C_BR; br_take <= 1'b1;                     budget <= 8'd12; state <= S_EXEC; end
                    16'b0000_0010_????_????: begin cls <= C_BR; br_take <= ~f_z;                     budget <= 8'd12; state <= S_EXEC; end
                    16'b0000_0011_????_????: begin cls <= C_BR; br_take <=  f_z;                     budget <= 8'd12; state <= S_EXEC; end
                    16'b0000_0100_????_????: begin cls <= C_BR; br_take <= ~(f_n ^ f_v);             budget <= 8'd12; state <= S_EXEC; end
                    16'b0000_0101_????_????: begin cls <= C_BR; br_take <=  (f_n ^ f_v);             budget <= 8'd12; state <= S_EXEC; end
                    16'b0000_0110_????_????: begin cls <= C_BR; br_take <= ~f_z & ~(f_n ^ f_v);      budget <= 8'd12; state <= S_EXEC; end
                    16'b0000_0111_????_????: begin cls <= C_BR; br_take <=  f_z |  (f_n ^ f_v);      budget <= 8'd12; state <= S_EXEC; end
                    16'b1000_0000_????_????: begin cls <= C_BR; br_take <= ~f_n;                     budget <= 8'd12; state <= S_EXEC; end
                    16'b1000_0001_????_????: begin cls <= C_BR; br_take <=  f_n;                     budget <= 8'd12; state <= S_EXEC; end
                    16'b1000_0010_????_????: begin cls <= C_BR; br_take <= ~f_c & ~f_z;              budget <= 8'd12; state <= S_EXEC; end
                    16'b1000_0011_????_????: begin cls <= C_BR; br_take <=  f_c |  f_z;              budget <= 8'd12; state <= S_EXEC; end
                    16'b1000_0100_????_????: begin cls <= C_BR; br_take <= ~f_v;                     budget <= 8'd12; state <= S_EXEC; end
                    16'b1000_0101_????_????: begin cls <= C_BR; br_take <=  f_v;                     budget <= 8'd12; state <= S_EXEC; end
                    16'b1000_0110_????_????: begin cls <= C_BR; br_take <= ~f_c;                     budget <= 8'd12; state <= S_EXEC; end
                    16'b1000_0111_????_????: begin cls <= C_BR; br_take <=  f_c;                     budget <= 8'd12; state <= S_EXEC; end
                    // ---- EMT / TRAP ----------------------------------------
                    16'b1000_1000_????_????: begin cls <= C_TRAP; trap_vec <= 8'h18; budget <= 8'd48; state <= S_EXEC; end
                    16'b1000_1001_????_????: begin cls <= C_TRAP; trap_vec <= 8'h1c; budget <= 8'd48; state <= S_EXEC; end
                    // ---- JMP / JSR -----------------------------------------
                    16'b0000_0000_01??_????: begin
                        if (dmode == 3'd0) begin cls <= C_TRAP; trap_vec <= 8'h04; budget <= 8'd48; state <= S_EXEC; end
                        else begin cls <= C_JMP; dst_read <= 1'b0; dst_write <= 1'b0; budget <= cost_jmp(dmode); end
                    end
                    16'b0000_100?_????_????: begin
                        if (dmode == 3'd0) begin cls <= C_TRAP; trap_vec <= 8'h04; budget <= 8'd48; state <= S_EXEC; end
                        else begin cls <= C_JSR; dst_read <= 1'b0; dst_write <= 1'b0; budget <= cost_jmp(dmode) + 8'd12; end
                    end
                    // ---- RTS -----------------------------------------------
                    16'b0000_0000_1000_0???: begin cls <= C_RTS; budget <= 8'd21; state <= S_EXEC; end
                    // ---- condition codes ---------------------------------
                    16'b0000_0000_1010_????,
                    16'b0000_0000_1011_????: begin cls <= C_CC; budget <= 8'd18; state <= S_EXEC; end
                    // ---- misc 0000-0007 ------------------------------------
                    16'b0000_0000_0000_0000: begin cls <= C_HALT;  budget <= 8'd48;  state <= S_EXEC; end
                    16'b0000_0000_0000_0001: begin cls <= C_WAIT;  budget <= 8'd12;  state <= S_EXEC; end
                    16'b0000_0000_0000_0010: begin cls <= C_RTI;   budget <= 8'd24;  state <= S_EXEC; end
                    16'b0000_0000_0000_0011: begin cls <= C_TRAP;  trap_vec <= 8'h0c; budget <= 8'd48; state <= S_EXEC; end
                    16'b0000_0000_0000_0100: begin cls <= C_TRAP;  trap_vec <= 8'h10; budget <= 8'd48; state <= S_EXEC; end
                    16'b0000_0000_0000_0101: begin cls <= C_RESET; budget <= 8'd110; state <= S_EXEC; end
                    16'b0000_0000_0000_0110: begin cls <= C_RTI;   budget <= 8'd33;  state <= S_EXEC; end   // RTT
                    16'b0000_0000_0000_0111: begin cls <= C_MFPT;  budget <= 8'd12;  state <= S_EXEC; end
                    // ---- everything else: reserved instruction trap --------
                    default: begin cls <= C_TRAP; trap_vec <= 8'h08; budget <= 8'd48; state <= S_EXEC; end
                endcase
            end

            // ---------------------------------------------------------------
            // operand engine: compute `ea` for the operand selected by opsel
            // and (if wanted) read its value into src_val / dst_val
            // ---------------------------------------------------------------
            S_EA: begin
                if (src_is_reg_only && !opsel) begin
                    // XOR: the source is the register named in bits 8:6, no bus access
                    src_val <= r[s_reg];
                    opsel <= 1'b1;
                end else case (cur_mode)
                    3'd0: begin
                        if (opsel) begin dst_val <= r[cur_reg]; state <= S_EXEC; end
                        else begin src_val <= r[cur_reg]; opsel <= 1'b1; end
                    end
                    3'd1: begin ea <= r[cur_reg]; state <= need_read ? S_RD : S_EXEC; end
                    3'd2: begin ea <= r[cur_reg]; r[cur_reg] <= r[cur_reg] + step; state <= need_read ? S_RD : S_EXEC; end
                    3'd3: begin ea <= r[cur_reg]; r[cur_reg] <= r[cur_reg] + 16'd2; state <= S_IND; end
                    3'd4: begin ea <= r[cur_reg] - step; r[cur_reg] <= r[cur_reg] - step; state <= need_read ? S_RD : S_EXEC; end
                    3'd5: begin ea <= r[cur_reg] - 16'd2; r[cur_reg] <= r[cur_reg] - 16'd2; state <= S_IND; end
                    default: state <= S_IDX;           // 6, 7: index word follows
                endcase
            end
            // index word: read at PC, PC += 2, ea = word + R[reg] (R7 = the incremented PC)
            S_IDX: begin
                if (!bus_rd) `BUS_READ(r[7], 1'b0, 1'b1)
                else if (bus_ack) begin
                    r[7] <= r[7] + 16'd2;
                    ea   <= bus_rdata + ((cur_reg == 3'd7) ? r[7] + 16'd2 : r[cur_reg]);
                    state <= (cur_mode == 3'd7) ? S_IND : (need_read ? S_RD : S_EXEC);
                end
            end
            // deferred: ea = word at ea
            S_IND: begin
                if (!bus_rd) `BUS_READ(ea, 1'b0, 1'b0)
                else if (bus_ack) begin
                    ea <= bus_rdata;
                    state <= need_read ? S_RD : S_EXEC;
                end
            end
            // read the operand at ea (byte or word)
            S_RD: begin
                if (!bus_rd) `BUS_READ(ea, cur_is_byte_mem, 1'b0)
                else if (bus_ack) begin
                    if (opsel) begin dst_val <= rd_val; state <= S_EXEC; end
                    else begin src_val <= rd_val; opsel <= 1'b1; state <= S_EA; end
                end
            end

            // ---------------------------------------------------------------
            S_EXEC: begin
                state <= S_PAD;
                case (cls)
                    C_DOUBLE, C_SINGLE: begin
                        if (aop == A_MTPS) begin
                            psw <= (psw & 8'h10) | (dst_val[7:0] & 8'hef);
                        end else begin
                            // flags
                            if (alu_upd[3]) psw[3] <= alu_nzvc[3];
                            if (alu_upd[2]) psw[2] <= alu_nzvc[2];
                            if (alu_upd[1]) psw[1] <= alu_nzvc[1];
                            if (alu_upd[0]) psw[0] <= alu_nzvc[0];
                            if (dst_write) begin
                                if (d_mode == 3'd0) begin
                                    // register destination
                                    if (aop == A_MFPS)          r[d_reg] <= alu_res;                 // sign-extended PSW
                                    else if (aop == A_MOV && is_byte) r[d_reg] <= {{8{alu_res[7]}}, alu_res[7:0]};  // MOVB sign-extends
                                    else if (is_byte)           r[d_reg][7:0] <= alu_res[7:0];
                                    else                        r[d_reg] <= alu_res;
                                end else begin
                                    wr_val <= alu_res;
                                    state  <= S_WR;
                                end
                            end
                        end
                    end
                    C_JMP: r[7] <= ea;
                    C_JSR: begin
                        // PUSH R[s]; R[s] = PC; PC = ea
                        r[6] <= r[6] - 16'd2;
                        state <= S_JSR_PUSH;
                    end
                    C_BR: if (br_take) r[7] <= r[7] + {{7{ir[7]}}, ir[7:0], 1'b0};
                    C_SOB: begin
                        r[s_reg] <= r[s_reg] - 16'd1;
                        if (r[s_reg] != 16'd1) r[7] <= r[7] - {9'd0, ir[5:0], 1'b0};
                    end
                    C_RTS: begin r[7] <= r[d_reg]; state <= S_RTS_POP; end
                    C_CC: begin if (ir[4]) psw[3:0] <= psw[3:0] | ir[3:0]; else psw[3:0] <= psw[3:0] & ~ir[3:0]; end
                    C_RTI: state <= S_RTI_POP1;
                    C_TRAP: begin vec <= trap_vec; halt_entry <= 1'b0; r[6] <= r[6] - 16'd2; state <= S_INT_PUSH1; end
                    C_HALT: begin halt_entry <= 1'b1; r[6] <= r[6] - 16'd2; state <= S_INT_PUSH1; end
                    C_WAIT: begin wait_state <= 1'b1; end
                    C_MFPT: r[0][7:0] <= 8'd4;
                    default: ;                         // RESET (no external effect here), NOP
                endcase
            end

            // write-back of a memory destination
            S_WR: begin
                if (!bus_wr) `BUS_WRITE(ea, is_byte, wr_val)
                else if (bus_ack) state <= S_PAD;
            end

            // JSR: write R[s] at the decremented SP, then R[s] = PC, PC = ea
            S_JSR_PUSH: begin
                if (!bus_wr) `BUS_WRITE(r[6], 1'b0, r[s_reg])
                else if (bus_ack) begin
                    r[s_reg] <= r[7];
                    r[7] <= ea;
                    state <= S_PAD;
                end
            end
            // RTS: R[d] = pop
            S_RTS_POP: begin
                if (!bus_rd) `BUS_READ(r[6], 1'b0, 1'b0)
                else if (bus_ack) begin r[d_reg] <= bus_rdata; r[6] <= r[6] + 16'd2; state <= S_PAD; end
            end
            // RTI/RTT: PC = pop; PSW = pop
            S_RTI_POP1: begin
                if (!bus_rd) `BUS_READ(r[6], 1'b0, 1'b0)
                else if (bus_ack) begin r[7] <= bus_rdata; r[6] <= r[6] + 16'd2; state <= S_RTI_POP2; end
            end
            S_RTI_POP2: begin
                if (!bus_rd) `BUS_READ(r[6], 1'b0, 1'b0)
                else if (bus_ack) begin psw <= bus_rdata[7:0]; r[6] <= r[6] + 16'd2; state <= S_PAD; end
            end

            // trap / interrupt entry: SP already decremented by 2 on entry
            S_INT_PUSH1: begin                          // push PSW
                if (!bus_wr) `BUS_WRITE(r[6], 1'b0, {8'h00, psw})
                else if (bus_ack) begin r[6] <= r[6] - 16'd2; state <= S_INT_PUSH2; end
            end
            S_INT_PUSH2: begin                          // push PC
                if (!bus_wr) `BUS_WRITE(r[6], 1'b0, r[7])
                else if (bus_ack) begin
                    if (halt_entry) begin r[7] <= INITIAL_PC + 16'd4; psw <= 8'he0; state <= S_PAD; end
                    else state <= S_INT_VEC1;
                end
            end
            S_INT_VEC1: begin
                if (!bus_rd) `BUS_READ({8'h00, vec}, 1'b0, 1'b0)
                else if (bus_ack) begin r[7] <= bus_rdata; state <= S_INT_VEC2; end
            end
            S_INT_VEC2: begin
                if (!bus_rd) `BUS_READ({8'h00, vec} + 16'd2, 1'b0, 1'b0)
                else if (bus_ack) begin psw <= bus_rdata[7:0]; state <= S_PAD; end
            end

            // ---------------------------------------------------------------
            // instruction end: pay out the cycle budget, then interrupts
            // ---------------------------------------------------------------
            S_PAD: begin
                if (cyc >= budget) begin
                    dbg_done <= 1'b1;
                    if (wait_state) state <= S_WAIT;
                    else if (irq_take) begin
                        vec <= irq_vec; halt_entry <= 1'b0; budget <= 8'd114; cyc <= 8'd0;
                        r[6] <= r[6] - 16'd2;
                        state <= S_INT_PUSH1;
                    end else state <= S_FETCH;
                end
            end
            S_WAIT: begin
                if (irq_take) begin
                    wait_state <= 1'b0;
                    vec <= irq_vec; halt_entry <= 1'b0; budget <= 8'd114; cyc <= 8'd0;
                    r[6] <= r[6] - 16'd2;
                    state <= S_INT_PUSH1;
                end
            end
            default: state <= S_FETCH;
        endcase
    end
endmodule

`undef BUS_READ
`undef BUS_WRITE
`default_nettype wire
