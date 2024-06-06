module linear_transform_inv (
    input wire [127:0] i_data,
    input wire [5:0] i_round,
    output wire [127:0] o_data
);

assign o_data = i_round == 6'd0 ? linear_transform_inv(i_data) : i_data;


//---------function----------
function [127:0] linear_transform_inv;
    input [127:0] i_data;
    reg [31:0] X0, X1, X2, X3;
    begin
        X0 = i_data[127:96];
        X1 = i_data[95:64];
        X2 = i_data[63:32];
        X3 = i_data[31:0];

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