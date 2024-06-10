`timescale 1ns / 1ps

module key_schedule_tb;

// Test inputs and outputs
reg clk, rstn, start;
reg [255:0] key;
wire [127:0] subkey;
wire [5:0] address;
wire subkey_valid;

// Instantiate the key_schedule_slow module
key_schedule uut (
    .i_clk(clk),
    .i_rstn(rstn),
    .i_begin(start),
    .i_key(key),
    .o_subkey(subkey),
    .o_address(address),
    .o_subkey_valid(subkey_valid)
);

// Clock generation
always #5 clk = ~clk; // 10ns clock period

initial begin
    // Initialize signals
    clk = 0;
    rstn = 0;
    start = 0;
    key = 0;

    // Reset
    #10 rstn = 1;

    // Test case 1: 128-bit key
    #10 start = 1;
    key = 256'h00112233445566778899aabbccddeeffffeeddccbbaa99887766554433221100; // Example key
    #10 start = 0;

    // Wait for key schedule to complete
    wait (subkey_valid);

    // Check subkeys and addresses (you'll need to add assertions here)
    // Example:
    // if (address != 6'd0 || subkey != 128'h...) $display("Error in subkey 0");
    // ... (check all 33 subkeys)

    // Test case 2: 192-bit key
    // ... (similar to test case 1, but with a 192-bit key)

    // Test case 3: 256-bit key
    // ... (similar to test case 1, but with a 256-bit key)

    // Finish simulation
    #100 $finish;
end

endmodule
