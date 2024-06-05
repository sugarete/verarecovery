module key_mixing (
    input wire [127:0] i_data,
    input wire [127:0] i_subkey,
    output wire [127:0] o_data
);

assign o_data = i_data ^ i_subkey;

endmodule