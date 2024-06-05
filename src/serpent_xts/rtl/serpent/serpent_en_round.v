module serpent_en_round (
    input wire [127:0] i_data,
    // input wire [127:0] i_subkey,
    input wire [5:0] i_round,
    output wire [127:0] o_data
);

//---------wires, registers----------
wire [127:0] out_mix_key;
wire [127:0] out_sbox;

//---------instances----------
// key_mixing mix_key (
//     .i_data(i_data),
//     .i_subkey(i_subkey),
//     .o_data(out_mix_key)
// );

sboxes sbox (
    .i_data(i_data),
    .i_Sbox_index(i_round % 8),
    .o_data(out_sbox)
);

linear_transform lt (
    .i_round(i_round),
    .i_data(out_sbox),
    .o_data(o_data)
);

endmodule