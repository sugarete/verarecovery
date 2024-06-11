`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2022 04:47:39 PM
// Design Name: 
// Module Name: top_whirlpool_hash
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

module top_whirlpool_hash (
    input  wire         i_clk,
    input  wire         i_rstn,
    input  wire         i_pass_valid,
    input  wire         i_ena_hash,
    input  wire [511:0] i_salt,
    input  wire [191:0] i_pass,
    input  wire [8:0]   i_pim,
    output reg  [191:0] o_pass,
    output reg          o_key_valid,
    output reg  [511:0] o_key,
	 output wire  [19:0]  o_loop
);
  localparam IDLE = 0;
  localparam KEY_PADDING = 1;
  localparam HASH_IKEY_BLOCK_1_IN = 2;
  localparam HASH_IKEY_BLOCK_2_IN = 3;
  localparam HASH_IKEY_BLOCK_3_IN = 4;
  localparam HASH_IKEY_BLOCK_3_OUT = 6;
  localparam HASH_OKEY_BLOCK_1_IN = 7;
  localparam HASH_OKEY_BLOCK_2_IN = 8;
  localparam HASH_OKEY_BLOCK_3_IN = 9;
  localparam HASH_OKEY_BLOCK_3_OUT = 10;
  localparam KEY_OUT = 11;

  reg  [511:0] key;
  reg  [511:0] key_old;
  reg  [511:0] data;
  reg  [511:0] data_reg;
  reg          init;
  reg          round;
  wire         hash_valid;
  wire [511:0] hash_out;
  reg  [511:0] ikey_pad;
  reg  [511:0] okey_pad;
  wire [511:0] ipad;
  wire [511:0] opad;
  reg  [3:0] state;
  reg  [19:0] c;
  reg  [19:0] total_loop;
  reg  [511:0] pass_in;
  reg  [511:0] digest;
  wire [511:0] key_out;
  reg          digest_valid;
  wire         key_valid;

  genvar i;
  generate 
      for (i = 0; i < 512 / 8; i = i + 1) begin : i_o_pad_assign
        assign ipad[((i*8)+8-1):(i*8)] = 8'h36;
        assign opad[((i*8)+8-1):(i*8)] = 8'h5c;
      end
  endgenerate
  
  assign o_loop = c;

  Whirlpool_hash Whirlpool_hash (
      .i_clk         (i_clk),
      .i_rstn        (i_rstn),
      .init          (init),
      .i_subkey_valid(key_valid),
      .i_data        (data),
      .i_key         (key),
      .i_subkey      (key_out),
      .o_hash_out    (hash_out),
      .o_hash_valid  (hash_valid)
  );

  key_expansion key_expansion (
      .i_clk         (i_clk),
      .i_rstn        (i_rstn),
      .i_key         (key),
      .init          (init),
      .o_subkey_valid(key_valid),
      .o_subkey      (key_out)
  );

  always @(posedge i_clk or negedge i_rstn) begin
    if (!i_rstn) begin
      init         <= 0;
      data_reg     <= 0;
      digest_valid <= 0;
      pass_in      <= 0;
      ikey_pad     <= 0;
      okey_pad     <= 0;
      data         <= 0;
      key          <= 0;
      digest       <= 0;
      c            <= 0;
      round        <= 0;
      key_old      <= 0;
      o_key        <= 0;
      o_key_valid  <= 0;
      state        <= IDLE;
    end else begin
      init <= 1'b0;
      case (state)
        IDLE: begin
          c <= 0;
          total_loop <= 15000 + i_pim * 1000;
          round <= 0;
          digest_valid <= 0;
          key <= 512'b0;
          //o_key       <= 512'b0;
          key_old <= 0;
          data_reg <= i_salt;
          if (i_pass_valid && i_ena_hash) begin
            pass_in[511 : 504] <= i_pass[191:184];
            pass_in[503 : 496] <= i_pass[175:168];
            pass_in[495 : 488] <= i_pass[159:152];
            pass_in[487 : 480] <= i_pass[143:136];
            pass_in[479 : 472] <= i_pass[127:120];
            pass_in[471 : 464] <= i_pass[111:104];
            pass_in[463 : 456] <= i_pass[95:88];
            pass_in[455 : 448] <= i_pass[79:72];
            pass_in[447 : 440] <= i_pass[63:56];
            pass_in[439 : 432] <= i_pass[47:40];
            pass_in[431 : 424] <= i_pass[31:24];
            pass_in[423 : 416] <= i_pass[15:8];
            o_pass             <= i_pass;
            o_key_valid <= 1'b0;
            o_key       <= 512'b0;
            state              <= KEY_PADDING;
          end
        end
        KEY_PADDING: begin
          ikey_pad <= pass_in ^ ipad;
          okey_pad <= pass_in ^ opad;
          state    <= HASH_IKEY_BLOCK_1_IN;
        end
        HASH_IKEY_BLOCK_1_IN: begin
          data  <= ikey_pad;
          key   <= 512'b0;
          init  <= 1'b1;
          state <= HASH_IKEY_BLOCK_2_IN;
        end
        HASH_IKEY_BLOCK_2_IN: begin
          if (hash_valid) begin
            data  <= data_reg;
            key   <= hash_out;
            init  <= 1'b1;
            state <= HASH_IKEY_BLOCK_3_IN;
          end
        end
        HASH_IKEY_BLOCK_3_IN: begin
          if (hash_valid) begin
            if (!round && !c) data <= {32'd1,1'b1, 223'd0, 256'd1056};
            else data <= {1'b1,255'd0, 256'd1024};
            key   <= hash_out;
            init  <= 1'b1;
            state <= HASH_IKEY_BLOCK_3_OUT;
          end
        end
        HASH_IKEY_BLOCK_3_OUT: begin
          if (hash_valid) begin
            data_reg <= hash_out;
            state <= HASH_OKEY_BLOCK_1_IN;
          end
        end
        HASH_OKEY_BLOCK_1_IN: begin
          data  <= okey_pad;
          key   <= 512'b0;
          init  <= 1'b1;
          state <= HASH_OKEY_BLOCK_2_IN;
        end
        HASH_OKEY_BLOCK_2_IN: begin
          if (hash_valid) begin
            data  <= data_reg;
            key   <= hash_out;
            init  <= 1'b1;
            state <= HASH_OKEY_BLOCK_3_IN;
          end
        end
        HASH_OKEY_BLOCK_3_IN: begin
          if (hash_valid) begin
            data <= {1'b1,255'd0, 256'd1024};
            key   <= hash_out;
            init  <= 1'b1;
            state <= HASH_OKEY_BLOCK_3_OUT;
          end
        end
        HASH_OKEY_BLOCK_3_OUT: begin
          if (hash_valid) begin
            c <= c + 1;
            data_reg <= hash_out;
            state <= KEY_OUT;
          end
        end
        KEY_OUT: begin
          o_key <= o_key ^ data_reg;
          if (c == total_loop) begin
            o_key_valid <= 1;
            state <= IDLE;
          end else state <= HASH_IKEY_BLOCK_1_IN;
        end
        default: state <= IDLE;
      endcase
    end
  end
endmodule
