`timescale 1ns / 1ps

module top_whirlpool_hash_tb;

  // Clock and reset signals
  reg i_clk;
  reg i_rstn;

  // Input signals
  reg i_pass_valid;
  reg i_ena_hash;
  reg [511:0] i_salt;
  reg [191:0] i_pass;

  // Output signals
  wire [191:0] o_pass;
  wire o_key_valid;
  wire [511:0] o_key;

  // Instantiate the module under test
  top_whirlpool_hash uut (
      .i_clk(i_clk),
      .i_rstn(i_rstn),
      .i_pass_valid(i_pass_valid),
      .i_ena_hash(i_ena_hash),
      .i_salt(i_salt),
      .i_pass(i_pass),
      .o_pass(o_pass),
      .o_key_valid(o_key_valid),
      .o_key(o_key)
  );

  // Clock generation
  always #1 i_clk = ~i_clk;

  initial begin
    // Initialize signals
    i_clk = 0;
    i_rstn = 0;
    i_pass_valid = 0;
    i_ena_hash = 0;
    i_salt = 0;
    i_pass = 0;

    // Reset the module
    #10 i_rstn = 1;

    // Provide input values
    i_salt = 512'h0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef;
    i_pass = 192'h0123456789abcdef0123456789abcdef0123456789abcdef;

    // Start hashing process
    #10 i_pass_valid = 1;
        i_ena_hash = 1;

    // Wait for the key_valid signal to be asserted
    wait (o_key_valid);

    // Monitor the output key
    $display("Output Key: %h", o_key);

    // Finish simulation
    #100 $finish;
  end

  // Monitor signals
  initial begin
    $monitor("Time: %0t, o_pass: %h, o_key_valid: %b, o_key: %h", $time, o_pass, o_key_valid, o_key);
  end

endmodule
