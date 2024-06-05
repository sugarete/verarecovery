`timescale 1ns / 1ps

module serpent_encrypt_full_tb;

  // Clock and reset signals
  reg i_clk;
  reg i_rstn;

  // Input signals
  reg i_master_key_valid;
  reg i_enable_encrypt;
  reg [255:0] i_key;
  reg [127:0] i_data;

  // Output signals
  wire [127:0] o_data;
  wire o_data_valid;

  // Instantiate the module under test
  serpent_encrypt_full uut (
      .i_clk(i_clk),
      .i_rstn(i_rstn),
      .i_master_key_valid(i_master_key_valid),
      .i_enable_encrypt(i_enable_encrypt),
      .i_key(i_key),
      .i_data(i_data),
      .o_data(o_data),
      .o_data_valid(o_data_valid)
  );

  // Clock generation
  always #5 i_clk = ~i_clk;

  initial begin
    // Initialize signals
    i_clk = 0;
    i_rstn = 0;
    i_master_key_valid = 0;
    i_enable_encrypt = 0;
    i_key = 0;
    i_data = 0;

    // Reset the module
    #10 i_rstn = 1;

    // Provide input values
    i_key = 256'h0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef;
    i_data = 128'h0123456789abcdef0123456789abcdef;

    // Start encryption process
    #10 i_master_key_valid = 1;
        i_enable_encrypt = 1;

    // Wait for the data_valid signal to be asserted
    wait (o_data_valid);

    // Monitor the output data
    $display("Output Data: %h", o_data);

    // Finish simulation
    #100 $finish;
  end

  // Monitor signals
  initial begin
    $monitor("Time: %0t, o_data: %h, o_data_valid: %b", $time, o_data, o_data_valid);
  end

endmodule
