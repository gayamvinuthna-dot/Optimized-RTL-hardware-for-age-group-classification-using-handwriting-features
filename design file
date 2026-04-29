`timescale 1ns/1ps
module top (clk, rst, force_in, tilt_in, air_time_in, entropy_in, age_group);

// Ports
input clk;
input rst;
input [7:0] force_in;
input [7:0] tilt_in;
input [7:0] air_time_in;
input [7:0] entropy_in;

output [1:0] age_group;
reg [1:0] age_group;

// Internal registers
reg [7:0] force_val;
reg [7:0] tilt;
reg [7:0] air_time;
reg [7:0] entropy;

// Sequential block
always @(posedge clk or posedge rst) begin
    if (rst) begin
        force_val = 8'd0;
        tilt = 8'd0;
        air_time = 8'd0;
        entropy = 8'd0;
    end else begin
        force_val = force_in;
        tilt = tilt_in;
        air_time = air_time_in;
        entropy = entropy_in;
    end
end

// Combinational block (NO @*)
always @(force_val or tilt or air_time or entropy) begin
    age_group = 2'b00;

    if (entropy < 8'd80) begin
        if (air_time > 8'd100)
            age_group = 2'b10;
        else
            age_group = 2'b01;
    end else begin
        if (force_val < 8'd50)
            age_group = 2'b01;
        else
            age_group = 2'b00;
    end
end

endmodule
