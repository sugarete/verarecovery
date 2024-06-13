module serpent_decrypt_stage (
    input wire [31:0] i_data_word_0,
    input wire [31:0] i_data_word_1,
    input wire [31:0] i_data_word_2,
    input wire [31:0] i_data_word_3,
    input wire [5:0] i_round,
    output wire [31:0] o_data_word_0,
    output wire [31:0] o_data_word_1,
    output wire [31:0] o_data_word_2,
    output wire [31:0] o_data_word_3
);

//---------wires, registers----------
wire [31:0] i_data_sbox_inv_word_0, i_data_sbox_inv_word_1, i_data_sbox_inv_word_2, i_data_sbox_inv_word_3;
wire [31:0] o_data_lt_inv_word_0, o_data_lt_inv_word_1, o_data_lt_inv_word_2, o_data_lt_inv_word_3;

//---------instances----------

linear_transform_inverse apply_lt_inv (
    .i_word_0(i_data_word_0),
    .i_word_1(i_data_word_1),
    .i_word_2(i_data_word_2),
    .i_word_3(i_data_word_3),
    .o_word_0(o_data_lt_inv_word_0),
    .o_word_1(o_data_lt_inv_word_1),
    .o_word_2(o_data_lt_inv_word_2),
    .o_word_3(o_data_lt_inv_word_3)
);

sboxes_inverse apply_sbox_inv (
    .i_word_0(i_data_sbox_inv_word_0),
    .i_word_1(i_data_sbox_inv_word_1),
    .i_word_2(i_data_sbox_inv_word_2),
    .i_word_3(i_data_sbox_inv_word_3),
    .i_sbox_index((i_round-1) % 6'd8),
    .o_word_0(o_data_word_0),
    .o_word_1(o_data_word_1),
    .o_word_2(o_data_sbox_word_2),
    .o_word_3(o_data_word_2)
);

assign i_data_sbox_inv_word_0 = (i_round < 32) ? i_data_word_0 : o_data_lt_inv_word_0;
assign i_data_sbox_inv_word_1 = (i_round < 32) ? i_data_word_1 : o_data_lt_inv_word_1;
assign i_data_sbox_inv_word_2 = (i_round < 32) ? i_data_word_2 : o_data_lt_inv_word_2;
assign i_data_sbox_inv_word_3 = (i_round < 32) ? i_data_word_3 : o_data_lt_inv_word_3;

endmodule