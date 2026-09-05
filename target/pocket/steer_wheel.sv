//------------------------------------------------------------------------------
// A steering wheel from a D-pad or an analog stick: the game reads the
// wheel's quadrature counter as an 8-bit position (LETA), so this is a
// counter that turns while a direction is held. The rate is menu-selectable
// (counts per second); a dock pad's stick turns it in proportion to its
// deflection. Direction: on the Pocket, D-pad right must count UP (the
// core first counted down, as MAME's track-select pointer had suggested,
// and the car steered the wrong way -- docs/hardware.md). The stick keeps
// the 0.1.0 mapping (stick right counts down) until a dock pad has been
// tried; `stick_rev` (a core-settings toggle) flips it without a rebuild.
//------------------------------------------------------------------------------
`default_nettype none

module steer_wheel (
    input  wire       clk,            // 96 MHz
    input  wire       reset,
    input  wire [1:0] rate,           // 0 = 120, 1 = 180, 2 = 270, 3 = 400 counts/s at full deflection
    input  wire       left, right,    // D-pad
    input  wire       stick_active,   // an analog stick is off centre (framework's own detection)
    input  wire [7:0] stick_x,        // 0x80 centre
    input  wire       stick_rev,      // reverse the stick's direction (menu: Analog Stick Steering)
    input  wire [1:0] stick_sens,     // 0 = as the D-pad at full deflection, 1 = half as reactive, 2 = twice (menu: Analog Sensitivity)
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
    reg        count_up, moving;
    reg [27:0] step, limit;
    always @(posedge clk) begin
        count_up  <= stick_active ? (~stick_x[7] ^ stick_rev) : right;   // D-pad right = up; stick right = down unless reversed
        moving    <= stick_active ? (defl > 8'd8) : (left ^ right);
        // one count every `period` clocks at full deflection; the stick adds
        // defl/127 of a count per clock-of-period instead
        step      <= !stick_active         ? 28'd127 :
                     (stick_sens == 2'd1)  ? {21'd0, defl[7:1]} :        // less reactive: half the rate per deflection
                     (stick_sens == 2'd2)  ? {19'd0, defl, 1'b0} :       // more reactive: double (up to 2x the D-pad rate)
                                             {20'd0, defl};
        limit     <= {8'd0, period} * 28'd127;
    end
    reg [27:0] acc;
    always @(posedge clk) begin
        if (reset) begin pos <= 8'h00; acc <= '0; end
        else if (moving) begin
            if (acc + step >= limit) begin
                acc <= acc + step - limit;
                pos <= count_up ? pos + 8'd1 : pos - 8'd1;
            end else acc <= acc + step;
        end else acc <= '0;
    end
endmodule

`default_nettype wire
