module Serpent_LT_tb;
  
  // Inputs
  reg [127:0] i_data;
  
  // Outputs
  wire [127:0] o_data;
  
  // Instantiate the module under test
  Serpent_LT uut (
    .i_data(i_data),
    .o_data(o_data)
  );
  
  // Clock signal
  reg clk;
  always #5 clk = ~clk;
  
  // Test stimulus
  initial begin
    // Initialize inputs
    i_data = 128'b00010010001101000101011001111000100100001010101111001101111011110001001000110100010101100111100010010000101010111100110111101111;
    
    // Apply inputs
    #10;
    
    // Print the initial values
    $display("Input:  i_data = %h", i_data);
    $display("Output: o_data = %h", o_data);
    
    // Wait for some time
    #20;
    
    // Print the final output values
    $display("Output: o_data = %h", o_data);
    
    // End the simulation
    $finish;
  end 
  
endmodule