`timescale 1ns/1ps

module tb;

reg clk;
reg rst;
reg [7:0] force_in, tilt_in, air_time_in, entropy_in;
wire [1:0] age_group;

// --- Waveform Dumping Block ---
initial begin
    $shm_open("waves.shm"); 
    $shm_probe("AS");       
end

top uut (
    .clk(clk),
    .rst(rst),
    .force_in(force_in),
    .tilt_in(tilt_in),
    .air_time_in(air_time_in),
    .entropy_in(entropy_in),
    .age_group(age_group)
);

// Clock generation (10ns period)
always #5 clk = ~clk;

// Console Monitoring
initial begin
    $monitor("Time: %0t | Force: %d | Age: %b", $time, force_in, age_group);
end

initial begin
    // 1. Initial State
    clk = 0;
    rst = 1;
    force_in = 0; tilt_in = 0; air_time_in = 0; entropy_in = 0;

    // 2. Release Reset
    #15 rst = 0; 
    #10;

    // Test Case 1 → Young
    force_in = 8'd80; tilt_in = 8'd70; air_time_in = 8'd40; entropy_in = 8'd120;
    #20;

    // Test Case 2 → Mid
    force_in = 8'd40; tilt_in = 8'd60; air_time_in = 8'd80; entropy_in = 8'd110;
    #20;

    // Test Case 3 → Old
    force_in = 8'd30; tilt_in = 8'd50; air_time_in = 8'd120; entropy_in = 8'd60;
    #20;

    // 3. Finalization
    #50; // Give it some time to show the last result on the waveform
    $display("Simulation Completed.");
    $finish;
end

endmodule
