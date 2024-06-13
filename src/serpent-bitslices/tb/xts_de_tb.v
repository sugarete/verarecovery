`timescale 1ns / 1ps

module tb_serpent_xts_de;

    // Inputs
    reg i_clk;
    reg i_rstn;
    reg i_master_key_valid;
    reg i_enable_decrypt;
    reg [511:0] i_key;
    reg [127:0] i_data;

    // Outputs
    wire [127:0] o_data;
    wire o_data_valid;

    // Instantiate the DUT (Device Under Test)
    serpent_xts_de uut (
        .i_clk(i_clk),
        .i_rstn(i_rstn),
        .i_master_key_valid(i_master_key_valid),
        .i_enable_decrypt(i_enable_decrypt),
        .i_key(i_key),
        .i_data(i_data),
        .o_data(o_data),
        .o_data_valid(o_data_valid)
    );

    // Clock generation
    initial begin
        i_clk = 0;
        forever #5 i_clk = ~i_clk; // 100MHz clock
    end

    // Stimulus process
    initial begin
        // Initialize Inputs
        i_rstn = 0;
        i_master_key_valid = 0;
        i_enable_decrypt = 0;
        i_key = 0;
        i_data = 0;

        // Reset the DUT
        #10;
        i_rstn = 1;
        #10;

        // Apply test vectors
        i_key = 512'h7059b7fb26d151074b0b9ee9c3b1daf9ecda3d210cba309224252a626203fb8c7c5e5f1d5774a7aae024fdcd28f694d560f19e0c83cb053b6844132a7a3eb8fd;
        i_data = 128'h0123456789abcdef0123456789abcdef;
        i_master_key_valid = 1;

        // Wait for some time to let the DUT process the inputs
        #100;

        // Enable encryption
        i_enable_decrypt = 1;

        // Wait for the DUT to complete processing
        #200;
		wait (o_data_valid);	
        // Display the output
        $display("Output Data: %h", o_data);

        // Finish the simulation
    end

endmodule
