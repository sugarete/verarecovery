module linear_transform_inverse (
    input wire [31:0] i_word_0,
    input wire [31:0] i_word_1,
    input wire [31:0] i_word_2,
    input wire [31:0] i_word_3,
    output wire [31:0] o_word_0,
    output wire [31:0] o_word_1,
    output wire [31:0] o_word_2,
    output wire [31:0] o_word_3
);

//---------function----------

wire [127:0] o_data;

assign o_data = linear_transform_inverse(i_word_0, i_word_1, i_word_2, i_word_3);

assign o_word_0 = o_data[31:0];
assign o_word_1 = o_data[63:32];
assign o_word_2 = o_data[95:64];
assign o_word_3 = o_data[127:96];

function [127:0] linear_transform_inverse;
    input [31:0] i_word_0;
    input [31:0] i_word_1;
    input [31:0] i_word_2;
    input [31:0] i_word_3;
    reg [31:0] X0, X1, X2, X3;
    begin
        X0 = i_word_0;
        X1 = i_word_1;
        X2 = i_word_2;
        X3 = i_word_3;

        X0 = {X0[4:0], X0[31:5]}; //ROR 5
        X2 = {X2[21:0], X2[31:22]}; //ROR 22
        X0 = X0 ^ X1 ^ X3;
        X2 = X2 ^ X3 ^ (X1 << 7);
        X1 = {X1[0], X1[31:1]}; //ROR 1
        X3 = {X3[6:0], X3[31:7]}; //ROR 7
        X3 = X3 ^ X2 ^ (X0 << 3);
        X1 = X1 ^ X0 ^ X2;
        X2 = {X2[2:0], X2[31:3]}; //ROR 3
        X0 = {X0[12:0], X0[31:13]}; //ROR 13

        linear_transform_inverse = {X0, X1, X2, X3};     
    end
endfunction

    
endmodule