module Serpent_LT_inv (
    input wire [127:0] i_data,
    output wire [127:0] o_data
);

//---------function----------
function [127:0] linear_transform_inv;
    input [127:0] data;
    reg [31:0] temp_data, X0, X1, X2, X3;
    begin
        X0 = data[127:96];
        X1 = data[95:64];
        X2 = data[63:32];
        X3 = data[31:0];
        
        X0 = {X0[4:0], X0[31:5]}; //ROR 5
        X2 = {X2[21:0], X2[31:22]}; //ROR 22
        X0 = X0 ^ X1 ^ X3;
        X2 = X2 ^ X3 ^ (X1 << 7);
        X1 = {X1[0], X1[31:1]}; //ROR 1
        X3 = {X3[7:0], X3[31:8]}; //ROR 7
        X1 = X1 ^ X0 ^ X2;
        X3 = X3 ^ X2 ^ (X0 << 3);
        X2 = {X2[2:0], X2[31:3]}; //ROR 3
        X0 = {X0[12:0], X0[31:13]}; //ROR 13
        
        linear_transform_inv = {X0, X1, X2, X3};
    end
endfunction

endmodule