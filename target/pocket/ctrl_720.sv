//! 720 Degrees' controller. The arcade stick sits on a rotating base with
//! two optical discs read by the sound board's LETA counters: "Rotate", 72
//! teeth read at 2x for 144 counts per turn (LETA 1), and "Center", two teeth
//! at the top of the turn (LETA 0). The reference is MAME's "Spinner"
//! controller model (atarisy2.cpp, leta_r): the rotate count runs freely as
//! an 8-bit counter, clockwise up, and the centre count steps once for each
//! of the positions 2, 3, 141 and 142 the joystick passes through, so one
//! pass over the top adds (or subtracts) four.
//! On the Pocket the D-pad (eight directions) or the left stick (sixteen)
//! gives the direction to face -- position 0 is up, 36 right, 72 down, 108
//! left -- and the joystick turns toward it the short way at the "Steering
//! Speed" rate; L1 and R1 spin it continuously, the way a player whirls the
//! real stick for the game's spins.
module ctrl_720 (
    input  wire       clk,            // 96 MHz
    input  wire       reset,
    input  wire [1:0] rate,           // 0..3: 480, 720, 960, 1440 counts/s (8, 12, 16, 24 per frame)
    input  wire       up, down, left, right,   // D-pad
    input  wire       spin_ccw, spin_cw,       // L1 / R1
    input  wire       stick_active,
    input  wire [7:0] stick_x, stick_y,        // 0x80 centre; y grows downward
    output reg  [7:0] rotate,         // LETA 1
    output reg  [7:0] center          // LETA 0
);
    // stage 1: the inputs (from the framework's synchronisers) as a signed
    // direction, right and up positive
    reg signed [8:0] dx, dy;
    reg              want, ccw, cw;
    always @(posedge clk) begin
        dx   <= stick_active ? ($signed({1'b0, stick_x}) - 9'sd128) : right ? 9'sd127 : left ? -9'sd127 : 9'sd0;
        dy   <= stick_active ? (9'sd128 - $signed({1'b0, stick_y})) : up ? 9'sd127 : down ? -9'sd127 : 9'sd0;
        want <= stick_active | up | down | left | right;
        ccw  <= spin_ccw;
        cw   <= spin_cw;
    end
    // stage 2: magnitudes and signs
    reg [7:0] ax, ay;
    reg       xneg, yneg, want2;
    always @(posedge clk) begin
        ax    <= dx[8] ? (~dx[7:0] + 8'd1) : dx[7:0];
        ay    <= dy[8] ? (~dy[7:0] + 8'd1) : dy[7:0];
        xneg  <= dx[8];
        yneg  <= dy[8];
        want2 <= want;
    end
    // stage 3: the octant. a = the smaller magnitude, b = the larger; the
    // dead zone is MAME's (within 32 of the centre on both axes = untouched)
    reg [7:0] a, b;
    reg       vert, xn3, yn3, live3;
    always @(posedge clk) begin
        a     <= (ax < ay) ? ax : ay;
        b     <= (ax < ay) ? ay : ax;
        vert  <= (ay >= ax);
        xn3   <= xneg;
        yn3   <= yneg;
        live3 <= want2 & ((ax > 8'd32) | (ay > 8'd32));
    end
    // stage 4: the sixteenth of a turn. a/b < tan 11.25 deg (0.199 ~ 51/256)
    // is on the nearer axis, < tan 33.75 deg (0.668 ~ 171/256) is 22.5 deg
    // off it, the rest is the diagonal
    reg [1:0] sub;
    reg       vert4, xn4, yn4, live4;
    always @(posedge clk) begin
        sub   <= ({a, 8'd0} < b * 16'd51) ? 2'd0 : ({a, 8'd0} < b * 16'd171) ? 2'd1 : 2'd2;
        vert4 <= vert;
        xn4   <= xn3;
        yn4   <= yn3;
        live4 <= live3;
    end
    // stage 5: the target position, 0..143 clockwise from up
    wire [7:0] sub9 = {3'b000, sub, 3'b000} + {6'd0, sub};      // 0, 9, 18
    wire [7:0] d    = vert4 ? sub9 : (8'd36 - sub9);           // counts from the vertical axis toward the horizontal
    reg  [7:0] target;
    reg        live;
    always @(posedge clk) begin
        target <= (!xn4 && !yn4) ? d :
                  (!xn4 &&  yn4) ? (8'd72 - d) :
                  ( xn4 &&  yn4) ? (8'd72 + d) :
                  (d == 8'd0)    ? 8'd0 : (8'd144 - d);
        live   <= live4;
    end
    // the step clock
    reg [19:0] period, tcnt;
    always @(posedge clk) begin
        period <= (rate == 2'd0) ? 20'd200000 : (rate == 2'd1) ? 20'd133333 : (rate == 2'd2) ? 20'd100000 : 20'd66667;
        tcnt   <= (reset || tcnt == 20'd0) ? (period - 20'd1) : (tcnt - 20'd1);
    end
    wire tick = (tcnt == 20'd0);
    // the joystick: its position (0..143), the free-running rotate count and
    // the centre count. The distance to the target is registered a clock
    // behind the position, harmless with steps 66,667 clocks apart.
    reg [7:0] pos, diff;
    always @(posedge clk) diff <= (target >= pos) ? (target - pos) : (target + 8'd144 - pos);
    wire step_cw  = cw | (~ccw & live & (diff != 8'd0) & (diff <= 8'd72));
    wire step_ccw = ~cw & (ccw | (live & (diff > 8'd72)));
    wire [7:0] pos_cw  = (pos == 8'd143) ? 8'd0   : (pos + 8'd1);
    wire [7:0] pos_ccw = (pos == 8'd0)   ? 8'd143 : (pos - 8'd1);
    wire [7:0] pos_new = step_cw ? pos_cw : pos_ccw;
    wire       gap     = (pos_new == 8'd2) || (pos_new == 8'd3) || (pos_new == 8'd141) || (pos_new == 8'd142);
    always @(posedge clk) begin
        if (reset) begin
            pos <= 8'd0; rotate <= 8'd0; center <= 8'd0;
        end else if (tick && (step_cw || step_ccw)) begin
            pos    <= pos_new;
            rotate <= step_cw ? (rotate + 8'd1) : (rotate - 8'd1);
            if (gap) center <= step_cw ? (center + 8'd1) : (center - 8'd1);
        end
    end
endmodule
