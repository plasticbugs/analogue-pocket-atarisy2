//------------------------------------------------------------------------------
// Clock enables for the Super Sprint core: one 96 MHz system clock, every
// machine part stepping on a one-cycle enable pulse from here. The pixel
// clock is an exact division; the CPU and sound clocks are phase
// accumulators (32-bit adder, carry = enable), exact in the long run with at
// most one system-clock period of jitter.
//------------------------------------------------------------------------------
`default_nettype none

module clk_enables (
    input  logic clk,          // 96.000 MHz
    input  logic reset,
    output logic cen_pix,      // 16.000 MHz pixel clock            96 / 6
    output logic cen_10m,      // 10.000 MHz T11                    phase accumulator
    output logic cen_ym,       // 3.579545 MHz YM2151 (6502 = /2)   phase accumulator
    output logic irq_tick      // 244.140625 Hz sound IRQ           96e6 / 393216
);
    localparam logic [31:0] INC_10M = 32'd447392427;   // 2^32 * 10.000000 / 96
    localparam logic [31:0] INC_YM  = 32'd160154226;   // 2^32 * 3.579545 / 96

    logic [2:0]  div6;
    logic [32:0] acc_10m, acc_ym;
    logic [18:0] irq_div;

    always_ff @(posedge clk) begin
        if (reset) begin
            div6 <= '0; acc_10m <= '0; acc_ym <= '0; irq_div <= '0;
            cen_pix <= 1'b0; cen_10m <= 1'b0; cen_ym <= 1'b0; irq_tick <= 1'b0;
        end else begin
            div6    <= (div6 == 3'd5) ? 3'd0 : div6 + 3'd1;
            cen_pix <= (div6 == 3'd5);
            acc_10m <= {1'b0, acc_10m[31:0]} + {1'b0, INC_10M};
            cen_10m <= acc_10m[32];
            acc_ym  <= {1'b0, acc_ym[31:0]} + {1'b0, INC_YM};
            cen_ym  <= acc_ym[32];
            irq_div  <= (irq_div == 19'd393215) ? 19'd0 : irq_div + 19'd1;
            irq_tick <= (irq_div == 19'd393215);
        end
    end
endmodule

`default_nettype wire
