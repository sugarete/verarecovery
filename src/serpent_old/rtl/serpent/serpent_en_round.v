module serpent_en_round (
    input wire [127:0] i_data,
    // input wire [127:0] i_subkey,
    input wire [5:0] i_round,
    output wire [127:0] o_data
);

//---------wires, registers----------
// wire [127:0] out_mix_key;
wire [127:0] out_sbox;
wire [127:0] out_lt;

//---------instances----------
// key_mixing mix_key (
//     .i_data(i_data),
//     .i_subkey(i_subkey),
//     .o_data(out_mix_key)
// );

sboxes sbox (
    .i_word0(i_data[31:0]),
    .i_word1(i_data[63:32]),
    .i_word2(i_data[95:64]),
    .i_word3(i_data[127:96]),
    .i_Sbox_index((i_round-1) % 6'd8),
    .o_data(out_sbox)
);

linear_transform lt (
    .i_data(out_sbox),
    .o_data(out_lt)
);

assign o_data = (i_round < 32) ? out_lt : out_sbox;

endmodule