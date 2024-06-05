module sboxes (
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
            assign sbox_output[i] = Sbox(bit_slice[i], i_Sbox_index);
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
    function [3:0] Sbox;
        input [3:0] data_in;
        input [2:0] sbox_index;
        begin
            case (sbox_index)
                3'b000: Sbox = Sbox0(data_in);
                3'b001: Sbox = Sbox1(data_in);
                3'b010: Sbox = Sbox2(data_in);
                3'b011: Sbox = Sbox3(data_in);
                3'b100: Sbox = Sbox4(data_in);
                3'b101: Sbox = Sbox5(data_in);
                3'b110: Sbox = Sbox6(data_in);
                3'b111: Sbox = Sbox7(data_in);
                default: Sbox = 4'b0000;
            endcase
        end
    endfunction

    // 3 8 15 1 10 6 5 11 14 13 4 2 7 0 9 12
    function [3:0] Sbox0;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox0 = 4'b0011;
                4'b0001: Sbox0 = 4'b1000;
                4'b0010: Sbox0 = 4'b1111;
                4'b0011: Sbox0 = 4'b0001;
                4'b0100: Sbox0 = 4'b1010;
                4'b0101: Sbox0 = 4'b0110;
                4'b0110: Sbox0 = 4'b0101;
                4'b0111: Sbox0 = 4'b1011;
                4'b1000: Sbox0 = 4'b1110;
                4'b1001: Sbox0 = 4'b1101;
                4'b1010: Sbox0 = 4'b0100;
                4'b1011: Sbox0 = 4'b0010;
                4'b1100: Sbox0 = 4'b0111;
                4'b1101: Sbox0 = 4'b0000;
                4'b1110: Sbox0 = 4'b1001;
                4'b1111: Sbox0 = 4'b1100;
                default: Sbox0 = 4'b0000;
            endcase
        end
    endfunction

    // 15 12 2 7 9 0 5 10 1 11 14 8 6 13 3 4
    function [3:0] Sbox1;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox1 = 4'b1101;
                4'b0001: Sbox1 = 4'b1000;
                4'b0010: Sbox1 = 4'b0010;
                4'b0011: Sbox1 = 4'b0111;
                4'b0100: Sbox1 = 4'b1001;
                4'b0101: Sbox1 = 4'b0000;
                4'b0110: Sbox1 = 4'b0101;
                4'b0111: Sbox1 = 4'b1010;
                4'b1000: Sbox1 = 4'b0001;
                4'b1001: Sbox1 = 4'b1011;
                4'b1010: Sbox1 = 4'b1100;
                4'b1011: Sbox1 = 4'b1000;
                4'b1100: Sbox1 = 4'b0110;
                4'b1101: Sbox1 = 4'b1101;
                4'b1110: Sbox1 = 4'b0011;
                4'b1111: Sbox1 = 4'b0100;
                default: Sbox1 = 4'b0000;
            endcase
        end
    endfunction

    // 8 6 7 9 3 12 10 15 13 1 14 4 0 11 5 2
    function [3:0] Sbox2;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox2 = 4'b1000;
                4'b0001: Sbox2 = 4'b0110;
                4'b0010: Sbox2 = 4'b0111;
                4'b0011: Sbox2 = 4'b1001;
                4'b0100: Sbox2 = 4'b0011;
                4'b0101: Sbox2 = 4'b1100;
                4'b0110: Sbox2 = 4'b1010;
                4'b0111: Sbox2 = 4'b1111;
                4'b1000: Sbox2 = 4'b1101;
                4'b1001: Sbox2 = 4'b0001;
                4'b1010: Sbox2 = 4'b1110;
                4'b1011: Sbox2 = 4'b0100;
                4'b1100: Sbox2 = 4'b0000;
                4'b1101: Sbox2 = 4'b1011;
                4'b1110: Sbox2 = 4'b0101;
                4'b1111: Sbox2 = 4'b0010;
                default: Sbox2 = 4'b0000;                
            endcase
        end
    endfunction

    // 0 15 11 8 12 9 6 3 13 1 2 4 10 7 5 14
    function [3:0] Sbox3;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox3 = 4'b0000;
                4'b0001: Sbox3 = 4'b1111;
                4'b0010: Sbox3 = 4'b1011;
                4'b0011: Sbox3 = 4'b1000;
                4'b0100: Sbox3 = 4'b1100;
                4'b0101: Sbox3 = 4'b1001;
                4'b0110: Sbox3 = 4'b0110;
                4'b0111: Sbox3 = 4'b0011;
                4'b1000: Sbox3 = 4'b1101;
                4'b1001: Sbox3 = 4'b0001;
                4'b1010: Sbox3 = 4'b0010;
                4'b1011: Sbox3 = 4'b0100;
                4'b1100: Sbox3 = 4'b1010;
                4'b1101: Sbox3 = 4'b0111;
                4'b1110: Sbox3 = 4'b0101;
                4'b1111: Sbox3 = 4'b1110;
                default: Sbox3 = 4'b0000;
            endcase
        end
    endfunction

    // 1 15 8 3 12 0 11 6 2 5 4 10 9 14 7 13
    function [3:0] Sbox4;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox4 = 4'b0001;
                4'b0001: Sbox4 = 4'b1111;
                4'b0010: Sbox4 = 4'b1000;
                4'b0011: Sbox4 = 4'b0011;
                4'b0100: Sbox4 = 4'b1100;
                4'b0101: Sbox4 = 4'b0000;
                4'b0110: Sbox4 = 4'b1011;
                4'b0111: Sbox4 = 4'b0110;
                4'b1000: Sbox4 = 4'b0010;
                4'b1001: Sbox4 = 4'b0101;
                4'b1010: Sbox4 = 4'b0100;
                4'b1011: Sbox4 = 4'b1010;
                4'b1100: Sbox4 = 4'b1001;
                4'b1101: Sbox4 = 4'b1110;
                4'b1110: Sbox4 = 4'b0111;
                4'b1111: Sbox4 = 4'b1101;
                default: Sbox4 = 4'b0000;
            endcase
        end
    endfunction

    // 15 5 2 11 4 10 9 12 0 3 14 8 13 6 7 1
    function [3:0] Sbox5;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox5 = 4'b1111;
                4'b0001: Sbox5 = 4'b0101;
                4'b0010: Sbox5 = 4'b0010;
                4'b0011: Sbox5 = 4'b1011;
                4'b0100: Sbox5 = 4'b0100;
                4'b0101: Sbox5 = 4'b1010;
                4'b0110: Sbox5 = 4'b1001;
                4'b0111: Sbox5 = 4'b1100;
                4'b1000: Sbox5 = 4'b0000;
                4'b1001: Sbox5 = 4'b0011;
                4'b1010: Sbox5 = 4'b1110;
                4'b1011: Sbox5 = 4'b1000;
                4'b1100: Sbox5 = 4'b1101;
                4'b1101: Sbox5 = 4'b0110;
                4'b1110: Sbox5 = 4'b0111;
                4'b1111: Sbox5 = 4'b0001;
                default: Sbox5 = 4'b0000;
            endcase
        end
    endfunction

    // 7 2 12 5 8 4 6 11 14 9 1 15 13 3 10 0
    function [3:0] Sbox6;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox6 = 4'b0111;
                4'b0001: Sbox6 = 4'b0010;
                4'b0010: Sbox6 = 4'b1100;
                4'b0011: Sbox6 = 4'b0101;
                4'b0100: Sbox6 = 4'b1000;
                4'b0101: Sbox6 = 4'b0100;
                4'b0110: Sbox6 = 4'b0110;
                4'b0111: Sbox6 = 4'b1011;
                4'b1000: Sbox6 = 4'b1110;
                4'b1001: Sbox6 = 4'b1001;
                4'b1010: Sbox6 = 4'b0001;
                4'b1011: Sbox6 = 4'b1111;
                4'b1100: Sbox6 = 4'b1101;
                4'b1101: Sbox6 = 4'b0011;
                4'b1110: Sbox6 = 4'b1010;
                4'b1111: Sbox6 = 4'b0000;
                default: Sbox6 = 4'b0000;
            endcase
        end
    endfunction

    //  1 13 15 0 14 8 2 11 7 4 12 10 9 3 5 6
    function [3:0] Sbox7;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox7 = 4'b0001;
                4'b0001: Sbox7 = 4'b1101;
                4'b0010: Sbox7 = 4'b1111;
                4'b0011: Sbox7 = 4'b0000;
                4'b0100: Sbox7 = 4'b1110;
                4'b0101: Sbox7 = 4'b1000;
                4'b0110: Sbox7 = 4'b0010;
                4'b0111: Sbox7 = 4'b1011;
                4'b1000: Sbox7 = 4'b0111;
                4'b1001: Sbox7 = 4'b0100;
                4'b1010: Sbox7 = 4'b1100;
                4'b1011: Sbox7 = 4'b1010;
                4'b1100: Sbox7 = 4'b1001;
                4'b1101: Sbox7 = 4'b0011;
                4'b1110: Sbox7 = 4'b0101;
                4'b1111: Sbox7 = 4'b0110;
                default: Sbox7 = 4'b0000;
            endcase
        end
    endfunction

endmodule