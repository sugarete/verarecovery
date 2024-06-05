`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2022 03:34:28 PM
// Design Name: 
// Module Name: key_expansion
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module key_expansion (
    input wire i_clk,
    input wire i_rstn,
    input wire [511:0] i_key,
    input wire init,

    output wire o_subkey_valid,
    output wire [511:0] o_subkey
);

  reg  [511:0] data_in;
  reg  [511:0] data_out;
  wire [511:0] key_out;
  reg  [ 63:0] sboxw;
  reg  [ 63:0] new_sboxw;
  reg          key_valid;
  reg  [511:0] data_reg;
  reg  [  3:0] round;
  reg  [  7:0] state;

  localparam IDLE = 0;
  localparam ROUND = 1;
  localparam WAIT = 2;

  assign o_subkey = data_out;
  assign o_subkey_valid = key_valid;

  WHIRLPOOL_WCIPHER_ROUND WHIRLPOOL_WCIPHER_ROUND (
      .odata(key_out),
      .idata(data_in)
  );

  always @(posedge i_clk or negedge i_rstn) begin
    if (!i_rstn) begin
      data_in <= 512'b0;
      data_reg <= 0;
      data_out <= 0;
      key_valid <= 1'b0;
      round <= 0;
      state <= IDLE;
    end else begin
      key_valid <= 1'b0;
      case (state)
        IDLE: begin
          data_in <= 512'b0;
          if (init) state <= ROUND;
        end
        ROUND: begin
          if (!round) data_in <= i_key;
          else data_in <= data_out;
          state <= WAIT;
        end
        WAIT: begin
          data_out  <= key_out ^ {new_sboxw, 448'b0};
          key_valid <= 1'b1;
          if (round == 9) begin
            round <= 0;
            state <= IDLE;
          end else begin
            round <= round + 1;
            state <= ROUND;
          end
        end
      endcase
    end
  end

  always @(*) begin
    case (round)
      0: new_sboxw = 64'h1823c6e887b8014f;
      1: new_sboxw = 64'h36a6d2f5796f9152;
      2: new_sboxw = 64'h60bc9b8ea30c7b35;
      3: new_sboxw = 64'h1de0d7c22e4bfe57;
      4: new_sboxw = 64'h157737e59ff04ada;
      5: new_sboxw = 64'h58c9290ab1a06b85;
      6: new_sboxw = 64'hbd5d10f4cb3e0567;
      7: new_sboxw = 64'he427418ba77d95d8;
      8: new_sboxw = 64'hfbee7c66dd17479e;
      9: new_sboxw = 64'hca2dbf07ad5a8333;
    endcase
  end

endmodule
