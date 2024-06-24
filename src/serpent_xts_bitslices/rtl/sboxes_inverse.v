module sboxes_inverse (
    input wire [2:0]    i_sbox_index,
    input wire [31:0]   i_word_0,
    input wire [31:0]   i_word_1,
    input wire [31:0]   i_word_2,
    input wire [31:0]   i_word_3,
    output wire [31:0]  o_word_0,
    output wire [31:0]  o_word_1,
    output wire [31:0]  o_word_2,
    output wire [31:0]  o_word_3,
    output wire [127:0] o_data
);

    // Split the input data into four 32-bit words
    wire [31:0] w0, w1, w2, w3;
    assign w0 = i_word_0;
    assign w1 = i_word_1;
    assign w2 = i_word_2;
    assign w3 = i_word_3;

    // Intermediate wires for 4-bit slices
    wire [3:0] bit_slice[31:0];

    // Generate block to form 4-bit slices from corresponding bits of the 32-bit words
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : bit_slices
            assign bit_slice[i] = {w3[i], w2[i], w1[i], w0[i]};
        end
    endgenerate

    // Intermediate wires for S-box outputs
    wire [3:0] sbox_output[31:0];

    // Generate block to apply the correct inverse S-box to each 4-bit slice
    generate
        for (i = 0; i < 32; i = i + 1) begin : sbox_application
            assign sbox_output[i] = InvSbox(bit_slice[i], i_sbox_index);
        end
    endgenerate

    // Reassemble the 32-bit words from the processed 4-bit slices
    wire [31:0] w0_out, w1_out, w2_out, w3_out;
    generate
        for (i = 0; i < 32; i = i + 1) begin : reassemble_words
            assign w0_out[i] = sbox_output[i][0];
            assign w1_out[i] = sbox_output[i][1];
            assign w2_out[i] = sbox_output[i][2];
            assign w3_out[i] = sbox_output[i][3];
        end
    endgenerate

    assign o_data = {w3_out, w2_out, w1_out, w0_out};
    assign o_word_0 = w0_out;
    assign o_word_1 = w1_out;
    assign o_word_2 = w2_out;
    assign o_word_3 = w3_out;

    // Inverse S-box definitions
    function [3:0] InvSbox;
        input [3:0] data_in;
        input [2:0] sbox_index;
        begin
            case (sbox_index)
                3'b000: InvSbox = InvSbox0(data_in);
                3'b001: InvSbox = InvSbox1(data_in);
                3'b010: InvSbox = InvSbox2(data_in);
                3'b011: InvSbox = InvSbox3(data_in);
                3'b100: InvSbox = InvSbox4(data_in);
                3'b101: InvSbox = InvSbox5(data_in);
                3'b110: InvSbox = InvSbox6(data_in);
                3'b111: InvSbox = InvSbox7(data_in);
                default: InvSbox = 4'b0000;
            endcase
        end
    endfunction

    // 13 3 11 0 10 6 5 12 1 14 4 7 15 9 8 2
    function [3:0] InvSbox0;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: InvSbox0 = 4'b1101;
                4'b0001: InvSbox0 = 4'b0011;
                4'b0010: InvSbox0 = 4'b1011;
                4'b0011: InvSbox0 = 4'b0000;
                4'b0100: InvSbox0 = 4'b1010;
                4'b0101: InvSbox0 = 4'b0110;
                4'b0110: InvSbox0 = 4'b0101;
                4'b0111: InvSbox0 = 4'b1100;
                4'b1000: InvSbox0 = 4'b0001;
                4'b1001: InvSbox0 = 4'b1110;
                4'b1010: InvSbox0 = 4'b0100;
                4'b1011: InvSbox0 = 4'b0111;
                4'b1100: InvSbox0 = 4'b1111;
                4'b1101: InvSbox0 = 4'b1001;
                4'b1110: InvSbox0 = 4'b1000;
                4'b1111: InvSbox0 = 4'b0010;
                default: InvSbox0 = 4'b0000;
            endcase
        end
    endfunction

    // 5 8 2 14 15 6 12 3 11 4 7 9 1 13 10 0
    function [3:0] InvSbox1;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: InvSbox1 = 4'b0101;
                4'b0001: InvSbox1 = 4'b1000;
                4'b0010: InvSbox1 = 4'b0010;
                4'b0011: InvSbox1 = 4'b1110;
                4'b0100: InvSbox1 = 4'b1111;
                4'b0101: InvSbox1 = 4'b0110;
                4'b0110: InvSbox1 = 4'b1100;
                4'b0111: InvSbox1 = 4'b0011;
                4'b1000: InvSbox1 = 4'b1011;
                4'b1001: InvSbox1 = 4'b0100;
                4'b1010: InvSbox1 = 4'b0111;
                4'b1011: InvSbox1 = 4'b1001;
                4'b1100: InvSbox1 = 4'b0001;
                4'b1101: InvSbox1 = 4'b1101;
                4'b1110: InvSbox1 = 4'b1010;
                4'b1111: InvSbox1 = 4'b0000;
                default: InvSbox1 = 4'b0000;
            endcase
        end
    endfunction

    // 12 9 15 4 11 14 1 2 0 3 6 13 5 8 10 7
    function [3:0] InvSbox2;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: InvSbox2 = 4'b1100;
                4'b0001: InvSbox2 = 4'b1001;
                4'b0010: InvSbox2 = 4'b1111;
                4'b0011: InvSbox2 = 4'b0100;
                4'b0100: InvSbox2 = 4'b1011;
                4'b0101: InvSbox2 = 4'b1110;
                4'b0110: InvSbox2 = 4'b0001;
                4'b0111: InvSbox2 = 4'b0010;
                4'b1000: InvSbox2 = 4'b0000;
                4'b1001: InvSbox2 = 4'b0011;
                4'b1010: InvSbox2 = 4'b0110;
                4'b1101: InvSbox2 = 4'b1101;
                4'b1010: InvSbox2 = 4'b0101;
                4'b1101: InvSbox2 = 4'b1000;
                4'b1110: InvSbox2 = 4'b1010;
                4'b1111: InvSbox2 = 4'b0111;
                default: InvSbox2 = 4'b0000;
            endcase
        end
    endfunction

    // 0 9 10 7 11 14 6 13 3 5 12 2 4 8 15 1
    function [3:0] InvSbox3;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: InvSbox3 = 4'b0000;
                4'b0001: InvSbox3 = 4'b1001;
                4'b0010: InvSbox3 = 4'b1010;
                4'b0011: InvSbox3 = 4'b0111;
                4'b0100: InvSbox3 = 4'b1011;
                4'b0101: InvSbox3 = 4'b1110;
                4'b0110: InvSbox3 = 4'b0110;
                4'b0111: InvSbox3 = 4'b1101;
                4'b1000: InvSbox3 = 4'b0011;
                4'b1001: InvSbox3 = 4'b0101;
                4'b1010: InvSbox3 = 4'b1100;
                4'b1011: InvSbox3 = 4'b0010;
                4'b1100: InvSbox3 = 4'b0100;
                4'b1101: InvSbox3 = 4'b1000;
                4'b1110: InvSbox3 = 4'b1111;
                4'b1111: InvSbox3 = 4'b0001;
                default: InvSbox3 = 4'b0000;
            endcase
        end
    endfunction

    // 5 0 8 3 10 9 7 14 2 12 11 6 4 15 13 1
    function [3:0] InvSbox4;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: InvSbox4 = 4'b0101;
                4'b0001: InvSbox4 = 4'b0000;
                4'b0010: InvSbox4 = 4'b1000;
                4'b0011: InvSbox4 = 4'b0011;
                4'b0100: InvSbox4 = 4'b1010;
                4'b0101: InvSbox4 = 4'b1001;
                4'b0110: InvSbox4 = 4'b0111;
                4'b0111: InvSbox4 = 4'b1110;
                4'b1000: InvSbox4 = 4'b0010;
                4'b1001: InvSbox4 = 4'b1100;
                4'b1010: InvSbox4 = 4'b1011;
                4'b1011: InvSbox4 = 4'b0110;
                4'b1100: InvSbox4 = 4'b0100;
                4'b1101: InvSbox4 = 4'b1111;
                4'b1110: InvSbox4 = 4'b1101;
                4'b1111: InvSbox4 = 4'b0001;
                default: InvSbox4 = 4'b0000;
            endcase
        end
    endfunction

    // 8 15 2 9 4 1 13 14 11 6 5 3 7 12 10 0
    function [3:0] InvSbox5;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: InvSbox5 = 4'b1000;
                4'b0001: InvSbox5 = 4'b1111;
                4'b0010: InvSbox5 = 4'b0010;
                4'b0011: InvSbox5 = 4'b1001;
                4'b0100: InvSbox5 = 4'b0100;
                4'b0101: InvSbox5 = 4'b0001;
                4'b0110: InvSbox5 = 4'b1101;
                4'b0111: InvSbox5 = 4'b1110;
                4'b1000: InvSbox5 = 4'b1011;
                4'b1001: InvSbox5 = 4'b0110;
                4'b1010: InvSbox5 = 4'b0101;
                4'b1011: InvSbox5 = 4'b0011;
                4'b1100: InvSbox5 = 4'b0111;
                4'b1101: InvSbox5 = 4'b1100;
                4'b1110: InvSbox5 = 4'b1010;
                4'b1111: InvSbox5 = 4'b0000;
                default: InvSbox5 = 4'b0000;
            endcase
        end
    endfunction

    // 15 10 1 13 5 3 6 0 4 9 14 7 2 12 8 11
    function [3:0] InvSbox6;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: InvSbox6 = 4'b1111;
                4'b0001: InvSbox6 = 4'b1010;
                4'b0010: InvSbox6 = 4'b0001;
                4'b0011: InvSbox6 = 4'b1101;
                4'b0100: InvSbox6 = 4'b0101;
                4'b0101: InvSbox6 = 4'b0011;
                4'b0110: InvSbox6 = 4'b0110;
                4'b0111: InvSbox6 = 4'b0000;
                4'b1000: InvSbox6 = 4'b0100;
                4'b1001: InvSbox6 = 4'b1001;
                4'b1010: InvSbox6 = 4'b1110;
                4'b1011: InvSbox6 = 4'b0111;
                4'b1100: InvSbox6 = 4'b0010;
                4'b1101: InvSbox6 = 4'b1100;
                4'b1110: InvSbox6 = 4'b1000;
                4'b1111: InvSbox6 = 4'b1011;
                default: InvSbox6 = 4'b0000;
            endcase
        end
    endfunction

    // 3 0 6 13 9 14 15 8 5 12 11 7 10 1 4 2
    function [3:0] InvSbox7;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: InvSbox7 = 4'b0011;
                4'b0001: InvSbox7 = 4'b0000;
                4'b0010: InvSbox7 = 4'b0110;
                4'b0011: InvSbox7 = 4'b1101;
                4'b0100: InvSbox7 = 4'b1001;
                4'b0101: InvSbox7 = 4'b1110;
                4'b0110: InvSbox7 = 4'b1111;
                4'b0111: InvSbox7 = 4'b1000;
                4'b1000: InvSbox7 = 4'b0101;
                4'b1001: InvSbox7 = 4'b1100;
                4'b1010: InvSbox7 = 4'b1011;
                4'b1011: InvSbox7 = 4'b0111;
                4'b1100: InvSbox7 = 4'b1010;
                4'b1101: InvSbox7 = 4'b0001;
                4'b1110: InvSbox7 = 4'b0100;
                4'b1111: InvSbox7 = 4'b0010;
                default: InvSbox7 = 4'b0000;
            endcase
        end
    endfunction

endmodule
