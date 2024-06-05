`timescale 1ns/1ps

//`define DEBUG

module whirlpool (
    input wire i_clk,
    input wire i_rstn,

    input wire i_init,
    input wire [511 : 0] i_data,
    input wire [511 : 0] i_key

    output wire [511 : 0] o_hash_out,
    output wire o_hash_valid
);

// define registers and wires
reg [511:0] subkey;

reg [511:0] data;
reg [4:0] round;
reg [511:0] data_out;
reg o_hash_valid;

parameter IDLE = 0;
parameter ROUND = 1;
reg state;
// define instances

whirlpool_cipher_round whirlpool_cipher_round (
    .subkey(subkey),
    .idata(data),
    .odata(data_out),
);

whirlpool_key_round whirlpool_key_round (
    .idata(data),
    .round(round),
    .odata(subkey),
);


always @(posedge i_clk or negedge i_rstn) begin
    if (!i_rstn) begin
        data <= '0;
        round <= IDLE;
        o_hash_out <= '0;
        o_hash_valid <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (i_init) begin
                    data <= i_data;
                    subkey <= i_key;
                    round <= 0;
                    state <= ROUND;
                end
            end
            ROUND: begin
                if (round < 10) begin
                    data <= data_out;
                    round <= round + 1;
                end else begin
                    o_hash_out <= data_out;
                    o_hash_valid <= 1;
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule 