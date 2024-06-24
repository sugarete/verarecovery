module serpent_top_tb;
  reg i_clk;
  reg i_rstn;
  reg i_key_valid;
  reg i_ena_en_de;
  reg [255:0] i_key;
  reg [127:0] i_data;
  wire [127:0] o_data;
  wire o_data_valid;

  // Instantiate the DUT (Device Under Test)
  serpent_top dut (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_key_valid(i_key_valid),
    .i_ena_en_de(i_ena_en_de),
    .i_key(i_key),
    .i_data(i_data),
    .o_data(o_data),
    .o_data_valid(o_data_valid)
  );

  // Clock generation
  always #5 i_clk = ~i_clk;

  initial begin
    // Initial values
    i_clk = 0;
    i_rstn = 0;
    i_key_valid = 0;
    i_ena_en_de = 0;
    i_key = 256'h0;
    i_data = 128'h0;

    // Reset the design
    #10 i_rstn = 1;

    // Encryption Test
    #10;
    i_key = 256'h00112233445566778899aabbccddeeffffeeddccbbaa99887766554433221100;
    i_data = 128'h0123456789abcdeffedcba9876543210;
    i_key_valid = 1;
    i_ena_en_de = 1;

    // Wait for key schedule and encryption to complete
    wait (o_data_valid == 1);
    #10;
    $display("Encrypted Data: %h", o_data);

    // Decryption Test
    // #10;
    // i_data = o_data; // Encrypted data
    // i_ena_en_de = 0;
    // i_key_valid = 1;

    // // Wait for key schedule and decryption to complete
    // wait (o_data_valid == 1);
    // #10;
    // $display("Decrypted Data: %h", o_data);

    // // Check if decrypted data matches original plaintext
    // if (o_data == 128'hFEDCBA9876543210FEDCBA9876543210) begin
    //   $display("Decryption successful");
    // end else begin
    //   $display("Decryption failed");
    // end

    $stop;
  end
endmodule
