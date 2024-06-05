`timescale 1ns / 1ps

module Whirlpool_hash (
    input wire i_clk,
    input wire i_rstn,

    input init,
    input i_subkey_valid,

    input [511 : 0] i_data,
    input [511 : 0] i_key,
    input [511 : 0] i_subkey,

    output wire [511 : 0] o_hash_out,
    output wire           o_hash_valid
);
  localparam IDLE = 0;
  localparam ROUND = 1;

  reg  [511:0] data;
  reg  [  4:0] round;

  reg  [511:0] hash_out_reg_0;
  reg  [511:0] hash_out_reg_1;
  reg          hash_valid;

  reg          whirlpool_state;

  wire [511:0] data_out;

  assign o_hash_out = hash_out_reg_0 ^ hash_out_reg_1;

  WHIRLPOOL_WCIPHER_ROUND WHIRLPOOL_WCIPHER_ROUND (
      .odata(data_out),
      .idata(data)
  );

  assign o_hash_valid = hash_valid;
  always @(posedge i_clk or negedge i_rstn) begin
    if (!i_rstn) begin
      data <= 512'b0;
      round <= 5'd0;
      hash_valid <= 1'b0;
      hash_out_reg_0 <= 512'b0;
      whirlpool_state <= IDLE;
    end else begin
      hash_valid <= 1'b0;
      case (whirlpool_state)
        IDLE: begin
          if (init) begin
            data <= i_data ^ i_key;
            whirlpool_state <= ROUND;
          end
        end
        ROUND: begin
          if (round < 9) begin
            if (i_subkey_valid) begin
              data <= data_out ^ i_subkey;
              round <= round + 1;
              whirlpool_state <= ROUND;
            end
          end else begin
            if (i_subkey_valid) begin
              hash_out_reg_0 <= data_out ^ i_subkey;
              hash_out_reg_1 <= i_data ^ i_key;
              hash_valid <= 1'b1;
              round <= 5'd0;
              whirlpool_state <= IDLE;
            end
          end
        end
        default: whirlpool_state <= IDLE;
      endcase
    end
  end
endmodule
