module Encrypt_Round (
    input wire [127:0] i_data,
    input wire [255:0] i_key,
    input wire [5:0] i_round,
    output wire [127:0] o_data
);

//---------wires, registers----------
wire [127:0] out_mix_key;
wire [127:0] out_sbox;


//---------instances----------
Serpent_KM serpent_km
(
    .i_data(i_data),
    .i_key(i_key),
    .o_data(out_mix_key)
);

Serpent_Sboxes serpent_sboxes
(
    .i_data(out_mix_key),
    .i_Sbox_index(i_round % 8),
    .o_data(out_sbox)
);

Serpent_LT serpent_lt
(
    .i_data(out_sbox),
    .o_data(o_data)
);

endmodule