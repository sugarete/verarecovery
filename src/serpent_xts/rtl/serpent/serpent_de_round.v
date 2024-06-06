module serpent_de_round (
    input wire [127:0] i_data,
    input wire [5:0] i_round,
    output wire [127:0] o_data
);

wire [127:0] out_linear_transform_inv;

linear_transform_inv linear_transform_inv_inst (
    .i_data(i_data),
    .i_round(i_round),
    .o_data(out_linear_transform_inv)
);

sboxes_inv sboxes_inv_inst (
    .i_data(out_linear_transform_inv),
    .o_data(o_data)
);


endmodule