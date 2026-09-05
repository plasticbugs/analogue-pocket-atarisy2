//------------------------------------------------------------------------------
// A steering wheel from a D-pad or an analog stick: the game reads the
// wheel's quadrature counter as an 8-bit position (LETA), so this is a
// counter that turns while a direction is held. The rate is menu-selectable
// (counts per second); a dock pad's stick turns it in proportion to its
// deflection. Measured in MAME on the track-select wheel: an INCREASING
// count turns counter-clockwise, so right counts down.
//------------------------------------------------------------------------------
`default_nettype none

module steer_wheel (
    input  wire       clk,            // 96 MHz
    input  wire       reset,
    input  wire [1:0] rate,           // 0 = 120, 1 = 180, 2 = 270, 3 = 400 counts/s at full deflection
    input  wire       left, right,    // D-pad
    input  wire       stick_active,   // an analog stick is off centre (framework's own detection)
    input  wire [7:0] stick_x,        // 0x80 centre
    output reg  [7:0] pos
);
    // The inputs arrive from the framework's synchronisers (which Quartus
    // builds as RAM shift registers, slow to leave) and the direction, the
    // deflection and the period are computed from them, so all of that is
    // registered once here and the counter only sees flops.
    // step period in clocks per count: 96e6 / rate
    wire [19:0] period = (rate == 2'd0) ? 20'd800000 : (rate == 2'd1) ? 20'd533333 : (rate == 2'd2) ? 20'd355555 : 20'd240000;
    // the stick scales the period by its deflection (7 bits): period * 127 / |x - 0x80|
    wire [7:0] defl = stick_x[7] ? (stick_x - 8'h80) : (8'h80 - stick_x);
    reg        dir_right, moving;
    reg [27:0] step, limit;
    always @(posedge clk) begin
        dir_right <= stick_active ? stick_x[7] : right;
        moving    <= stick_active ? (defl > 8'd8) : (left ^ right);
        // one count every `period` clocks at full deflection; the stick adds
        // defl/127 of a count per clock-of-period instead
        step      <= stick_active ? {20'd0, defl} : 28'd127;
        limit     <= {8'd0, period} * 28'd127;
    end
    reg [27:0] acc;
    always @(posedge clk) begin
        if (reset) begin pos <= 8'h00; acc <= '0; end
        else if (moving) begin
            if (acc + step >= limit) begin
                acc <= acc + step - limit;
                pos <= dir_right ? pos - 8'd1 : pos + 8'd1;
            end else acc <= acc + step;
        end else acc <= '0;
    end
endmodule

`default_nettype wire
