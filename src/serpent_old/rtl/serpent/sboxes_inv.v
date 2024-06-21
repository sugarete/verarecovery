module sboxes_inv (
    input wire [127:0] i_data,
    input wire [2:0] i_Sbox_index,
    output wire [127:0] o_data
);

    // Split the input data into four 32-bit words
    wire [31:0] w0, w1, w2, w3;
    assign w0 = i_data[127:96];
    assign w1 = i_data[95:64];
    assign w2 = i_data[63:32];
    assign w3 = i_data[31:0];

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

    // Generate block to apply the correct S-box to each 4-bit slice
    generate
        for (i = 0; i < 32; i = i + 1) begin : sbox_application
            assign sbox_output[i] = Sbox_inv(bit_slice[i], i_Sbox_index);
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

    assign o_data = {w0_out, w1_out, w2_out, w3_out};

    // S-box definitions
    function [3:0] Sbox_inv;
        input [3:0] data_in;
        input [2:0] sbox_index;
        begin
            case (sbox_index)
                3'b000: Sbox_inv = Sbox0_inv(data_in);
                3'b001: Sbox_inv = Sbox1_inv(data_in);
                3'b010: Sbox_inv = Sbox2_inv(data_in);
                3'b011: Sbox_inv = Sbox3_inv(data_in);
                3'b100: Sbox_inv = Sbox4_inv(data_in);
                3'b101: Sbox_inv = Sbox5_inv(data_in);
                3'b110: Sbox_inv = Sbox6_inv(data_in);
                3'b111: Sbox_inv = Sbox7_inv(data_in);
                default: Sbox_inv = 4'b0000;
            endcase
        end
    endfunction

    // 13 3 11 0 10 6 5 12 1 14 4 7 15 9 8 2
    function [3:0] Sbox0_inv;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox0_inv = 4'b1101;
                4'b0001: Sbox0_inv = 4'b0011;
                4'b0010: Sbox0_inv = 4'b1011;
                4'b0011: Sbox0_inv = 4'b0000;
                4'b0100: Sbox0_inv = 4'b1010;
                4'b0101: Sbox0_inv = 4'b0110;
                4'b0110: Sbox0_inv = 4'b0101;
                4'b0111: Sbox0_inv = 4'b1100;
                4'b1000: Sbox0_inv = 4'b0001;
                4'b1001: Sbox0_inv = 4'b1110;
                4'b1010: Sbox0_inv = 4'b0100;
                4'b1011: Sbox0_inv = 4'b0111;
                4'b1100: Sbox0_inv = 4'b1111;
                4'b1101: Sbox0_inv = 4'b1000;
                4'b1110: Sbox0_inv = 4'b1001;
                4'b1111: Sbox0_inv = 4'b0010;
            endcase
        end
    endfunction

    //  5 8 2 14 15 6 12 3 11 4 7 9 1 13 10 0
    function [3:0] Sbox1_inv;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox1_inv = 4'b0100;
                4'b0001: Sbox1_inv = 4'b1000;
                4'b0010: Sbox1_inv = 4'b0010;
                4'b0011: Sbox1_inv = 4'b1110;
                4'b0100: Sbox1_inv = 4'b1111;
                4'b0101: Sbox1_inv = 4'b0110;
                4'b0110: Sbox1_inv = 4'b1100;
                4'b0111: Sbox1_inv = 4'b0011;
                4'b1000: Sbox1_inv = 4'b1011;
                4'b1001: Sbox1_inv = 4'b0100;
                4'b1010: Sbox1_inv = 4'b0111;
                4'b1011: Sbox1_inv = 4'b1001;
                4'b1100: Sbox1_inv = 4'b0001;
                4'b1101: Sbox1_inv = 4'b1101;
                4'b1110: Sbox1_inv = 4'b1010;
                4'b1111: Sbox1_inv = 4'b0000;
            endcase
        end
    endfunction

    //  12 9 15 4 11 14 1 2 0 3 6 13 5 8 10 7
    function [3:0] Sbox2_inv;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox2_inv = 4'b0000;
                4'b0001: Sbox2_inv = 4'b0011;
                4'b0010: Sbox2_inv = 4'b1111;
                4'b0011: Sbox2_inv = 4'b0100;
                4'b0100: Sbox2_inv = 4'b1011;
                4'b0101: Sbox2_inv = 4'b1100;
                4'b0110: Sbox2_inv = 4'b0001;
                4'b0111: Sbox2_inv = 4'b0010;
                4'b1000: Sbox2_inv = 4'b0000;
                4'b1001: Sbox2_inv = 4'b0011;
                4'b1010: Sbox2_inv = 4'b0110;
                4'b1011: Sbox2_inv = 4'b1101;
                4'b1100: Sbox2_inv = 4'b0101;
                4'b1101: Sbox2_inv = 4'b1000;
                4'b1110: Sbox2_inv = 4'b1010;
                4'b1111: Sbox2_inv = 4'b0111;
            endcase
        end
    endfunction

    //  0 9 10 7 11 14 6 13 3 5 12 2 4 8 15 1
    function [3:0] Sbox3_inv;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox3_inv = 4'b0000;
                4'b0001: Sbox3_inv = 4'b1001;
                4'b0010: Sbox3_inv = 4'b1010;
                4'b0011: Sbox3_inv = 4'b0111;
                4'b0100: Sbox3_inv = 4'b1011;
                4'b0101: Sbox3_inv = 4'b1100;
                4'b0110: Sbox3_inv = 4'b0110;
                4'b0111: Sbox3_inv = 4'b1101;
                4'b1000: Sbox3_inv = 4'b0011;
                4'b1001: Sbox3_inv = 4'b0101;
                4'b1010: Sbox3_inv = 4'b1100;
                4'b1011: Sbox3_inv = 4'b0010;
                4'b1100: Sbox3_inv = 4'b0100;
                4'b1101: Sbox3_inv = 4'b1000;
                4'b1110: Sbox3_inv = 4'b1111;
                4'b1111: Sbox3_inv = 4'b0001;
            endcase
        end
    endfunction

    //  5 0 8 3 10 9 7 14 2 12 11 6 4 15 13 1
    function [3:0] Sbox4_inv;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox4_inv = 4'b0101;
                4'b0001: Sbox4_inv = 4'b0000;
                4'b0010: Sbox4_inv = 4'b1000;
                4'b0011: Sbox4_inv = 4'b0011;
                4'b0100: Sbox4_inv = 4'b1010;
                4'b0101: Sbox4_inv = 4'b1001;
                4'b0110: Sbox4_inv = 4'b0111;
                4'b0111: Sbox4_inv = 4'b1110;
                4'b1000: Sbox4_inv = 4'b0010;
                4'b1001: Sbox4_inv = 4'b1100;
                4'b1010: Sbox4_inv = 4'b1011;
                4'b1011: Sbox4_inv = 4'b0110;
                4'b1100: Sbox4_inv = 4'b0100;
                4'b1101: Sbox4_inv = 4'b1111;
                4'b1110: Sbox4_inv = 4'b1101;
                4'b1111: Sbox4_inv = 4'b0001;
            endcase
        end
    endfunction

    //  8 15 2 9 4 1 13 14 11 6 5 3 7 12 10 0
    function [3:0] Sbox5_inv;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox5_inv = 4'b1000;
                4'b0001: Sbox5_inv = 4'b1111;
                4'b0010: Sbox5_inv = 4'b0010;
                4'b0011: Sbox5_inv = 4'b1001;
                4'b0100: Sbox5_inv = 4'b0100;
                4'b0101: Sbox5_inv = 4'b0001;
                4'b0110: Sbox5_inv = 4'b1101;
                4'b0111: Sbox5_inv = 4'b1110;
                4'b1000: Sbox5_inv = 4'b1011;
                4'b1001: Sbox5_inv = 4'b0110;
                4'b1010: Sbox5_inv = 4'b0101;
                4'b1011: Sbox5_inv = 4'b0011;
                4'b1100: Sbox5_inv = 4'b0111;
                4'b1101: Sbox5_inv = 4'b1100;
                4'b1110: Sbox5_inv = 4'b1010;
                4'b1111: Sbox5_inv = 4'b0000;
            endcase
        end
    endfunction

    //  15 10 1 13 5 3 6 0 4 9 14 7 2 12 8 11
    function [3:0] Sbox6_inv;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox6_inv = 4'b1110;
                4'b0001: Sbox6_inv = 4'b1011;
                4'b0010: Sbox6_inv = 4'b0001;
                4'b0011: Sbox6_inv = 4'b1101;
                4'b0100: Sbox6_inv = 4'b0101;
                4'b0101: Sbox6_inv = 4'b0011;
                4'b0110: Sbox6_inv = 4'b0110;
                4'b0111: Sbox6_inv = 4'b0000;
                4'b1000: Sbox6_inv = 4'b0100;
                4'b1001: Sbox6_inv = 4'b1001;
                4'b1010: Sbox6_inv = 4'b1110;
                4'b1011: Sbox6_inv = 4'b0111;
                4'b1100: Sbox6_inv = 4'b0010;
                4'b1101: Sbox6_inv = 4'b1100;
                4'b1110: Sbox6_inv = 4'b1000;
                4'b1111: Sbox6_inv = 4'b1010;
            endcase
        end
    endfunction

    // 3 0 6 13 9 14 15 8 5 12 11 7 10 1 4 2
    function [3:0] Sbox7_inv;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox7_inv = 4'b0011;
                4'b0001: Sbox7_inv = 4'b0000;
                4'b0010: Sbox7_inv = 4'b0110;
                4'b0011: Sbox7_inv = 4'b1101;
                4'b0100: Sbox7_inv = 4'b1001;
                4'b0101: Sbox7_inv = 4'b1110;
                4'b0110: Sbox7_inv = 4'b1111;
                4'b0111: Sbox7_inv = 4'b1000;
                4'b1000: Sbox7_inv = 4'b0101;
                4'b1001: Sbox7_inv = 4'b1100;
                4'b1010: Sbox7_inv = 4'b1011;
                4'b1011: Sbox7_inv = 4'b0111;
                4'b1100: Sbox7_inv = 4'b1010;
                4'b1101: Sbox7_inv = 4'b0001;
                4'b1110: Sbox7_inv = 4'b0100;
                4'b1111: Sbox7_inv = 4'b0010;
            endcase
        end
    endfunction


endmodule