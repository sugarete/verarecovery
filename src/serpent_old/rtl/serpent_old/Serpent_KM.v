//Serpent Key Mixing Stage
module Serpent_KM (
    input wire [127:0] i_data;
    input wire [127:0] i_key;
    output wire [127:0] o_data;
);

assign o_data = i_data ^ i_key;
    
endmodule