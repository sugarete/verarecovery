module linear_transform (
    input wire [127:0] i_data,
    output wire [127:0] o_data
);

//---------function----------

assign o_data = linear_transform(i_data);

function [127:0] linear_transform;
    input [127:0] i_data;
    reg [31:0] X0, X1, X2, X3;
    begin
        // X0 = i_data[127:96];
        // X1 = i_data[95:64];
        // X2 = i_data[63:32];
        // X3 = i_data[31:0];
        X0 = i_data[31:0];
        X1 = i_data[63:32];
        X2 = i_data[95:64];
        X3 = i_data[127:96];

        X0 = {X0[18:0], X0[31:19]}; //ROL 13
        X2 = {X2[28:0], X2[31:29]}; //ROL 3
        X1 = X1 ^ X0 ^ X2;
        X3 = X3 ^ X2 ^ (X0 << 3);
        X1 = {X1[30:0], X1[31]}; //ROL 1
        X3 = {X3[24:0], X3[31:25]}; //ROL 7
        X0 = X0 ^ X1 ^ X3;
        X2 = X2 ^ X3 ^ (X1 << 7);
        X0 = {X0[26:0], X0[31:27]}; //ROL 5
        X2 = {X2[9:0], X2[31:10]}; //ROL 22
        linear_transform = {X3, X2, X1, X0};       
    end
endfunction
    
endmodule