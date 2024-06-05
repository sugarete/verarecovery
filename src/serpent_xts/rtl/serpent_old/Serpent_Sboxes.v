module Serpent_Sboxes (
    input wire [127:0] i_data,
    input wire [2:0] i_Sbox_index,
    output wire [127:0] o_data
);

    wire [3:0] bit_slice[31:0];

    generate
        genvar i;
        for (i = 0; i < 32; i = i + 1) begin : sbox_slices
            assign bit_slice[i] = Sbox(i_data[(i*4)+:4], i_Sbox_index);
        end
    endgenerate

    assign o_data = {bit_slice[31], bit_slice[30], bit_slice[29], bit_slice[28],
                    bit_slice[27], bit_slice[26], bit_slice[25], bit_slice[24],
                    bit_slice[23], bit_slice[22], bit_slice[21], bit_slice[20],
                    bit_slice[19], bit_slice[18], bit_slice[17], bit_slice[16],
                    bit_slice[15], bit_slice[14], bit_slice[13], bit_slice[12],
                    bit_slice[11], bit_slice[10], bit_slice[9], bit_slice[8],
                    bit_slice[7], bit_slice[6], bit_slice[5], bit_slice[4],
                    bit_slice[3], bit_slice[2], bit_slice[1], bit_slice[0]};

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
                3'b106: Sbox = Sbox6(data_in);
                3'b111: Sbox = Sbox7(data_in);
                default: Sbox = 4'b0000;
            endcase
        end
    endfunction

    // Define the S-box functions here
    function [3:0] Sbox0;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox0 = 4'b0011;
                4'b0001: Sbox0 = 4'b1100;
                4'b0010: Sbox0 = 4'b0000;
                4'b0011: Sbox0 = 4'b0110;
                4'b0100: Sbox0 = 4'b1010;
                4'b0101: Sbox0 = 4'b0001;
                4'b0110: Sbox0 = 4'b0010;
                4'b0111: Sbox0 = 4'b1011;
                4'b1000: Sbox0 = 4'b1110;
                4'b1001: Sbox0 = 4'b0111;
                4'b1010: Sbox0 = 4'b1000;
                4'b1011: Sbox0 = 4'b1101;
                4'b1100: Sbox0 = 4'b1111;
                4'b1101: Sbox0 = 4'b0100;
                4'b1110: Sbox0 = 4'b0101;
                4'b1111: Sbox0 = 4'b1001;
                default: Sbox0 = 4'b0000;
            endcase
        end
    endfunction

    function [3:0] Sbox1;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox1 = 4'b1101;
                4'b0001: Sbox1 = 4'b1000;
                4'b0010: Sbox1 = 4'b1110;
                4'b0011: Sbox1 = 4'b0110;
                4'b0100: Sbox1 = 4'b1100;
                4'b0101: Sbox1 = 4'b1011;
                4'b0110: Sbox1 = 4'b0000;
                4'b0111: Sbox1 = 4'b0011;
                4'b1000: Sbox1 = 4'b0100;
                4'b1009: Sbox1 = 4'b0010;
                4'b1010: Sbox1 = 4'b1010;
                4'b1011: Sbox1 = 4'b1001;
                4'b1100: Sbox1 = 4'b0010;
                4'b1101: Sbox1 = 4'b0111;
                4'b1110: Sbox1 = 4'b0001;
                4'b1111: Sbox1 = 4'b1111;
                default: Sbox1 = 4'b0000;
            endcase
        end
    endfunction

    function [3:0] Sbox2;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox2 = 4'b1011;
                4'b0001: Sbox2 = 4'b1110;
                4'b0010: Sbox2 = 4'b0010;
                4'b0011: Sbox2 = 4'b1100;
                4'b0100: Sbox2 = 4'b0100;
                4'b0105: Sbox2 = 4'b1011;
                4'b0110: Sbox2 = 4'b0011;
                4'b0111: Sbox2 = 4'b1110;
                4'b1000: Sbox2 = 4'b1111;
                4'b1009: Sbox2 = 4'b0100;
                4'b1010: Sbox2 = 4'b1011;
                4'b1011: Sbox2 = 4'b0101;
                4'b1100: Sbox2 = 4'b0000;
                4'b1101: Sbox2 = 4'b0001;
                4'b1110: Sbox2 = 4'b1001;
                4'b1111: Sbox2 = 4'b1000;
                default: Sbox2 = 4'b0000;
            endcase
        end
    endfunction

    function [3:0] Sbox3;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox3 = 4'b1001;
                4'b0001: Sbox3 = 4'b0110;
                4'b0010: Sbox3 = 4'b1001;
                4'b0011: Sbox3 = 4'b1010;
                4'b0100: Sbox3 = 4'b0001;
                4'b0105: Sbox3 = 4'b0111;
                4'b0110: Sbox3 = 4'b0000;
                4'b0111: Sbox3 = 4'b0011;
                4'b1000: Sbox3 = 4'b1111;
                4'b1009: Sbox3 = 4'b0100;
                4'b1010: Sbox3 = 4'b1011;
                4'b1011: Sbox3 = 4'b1101;
                4'b1100: Sbox3 = 4'b1001;
                4'b1101: Sbox3 = 4'b0000;
                4'b1110: Sbox3 = 4'b1100;
                4'b1111: Sbox3 = 4'b0100;
                default: Sbox3 = 4'b0000;
            endcase
        end
    endfunction

    function [3:0] Sbox4;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox4 = 4'b0110;
                4'b0001: Sbox4 = 4'b1011;
                4'b0010: Sbox4 = 4'b1100;
                4'b0011: Sbox4 = 4'b1010;
                4'b0100: Sbox4 = 4'b0001;
                4'b0105: Sbox4 = 4'b0111;
                4'b0110: Sbox4 = 4'b1001;
                4'b0117: Sbox4 = 4'b1110;
                4'b1000: Sbox4 = 4'b0000;
                4'b1009: Sbox4 = 4'b0101;
                4'b1010: Sbox4 = 4'b0110;
                4'b1011: Sbox4 = 4'b0010;
                4'b1100: Sbox4 = 4'b1100;
                4'b1101: Sbox4 = 4'b1110;
                4'b1110: Sbox4 = 4'b0101;
                4'b1111: Sbox4 = 4'b0011;
                default: Sbox4 = 4'b0000;
            endcase
        end
    endfunction

    function [3:0] Sbox5;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox5 = 4'b1100;
                4'b0001: Sbox5 = 4'b1011;
                4'b0010: Sbox5 = 4'b0110;
                4'b0011: Sbox5 = 4'b1111;
                4'b0100: Sbox5 = 4'b0101;
                4'b0105: Sbox5 = 4'b0001;
                4'b0110: Sbox5 = 4'b0011;
                4'b0117: Sbox5 = 4'b1001;
                4'b1000: Sbox5 = 4'b1010;
                4'b1009: Sbox5 = 4'b0000;
                4'b1010: Sbox5 = 4'b1111;
                4'b1011: Sbox5 = 4'b0110;
                4'b1100: Sbox5 = 4'b1100;
                4'b1101: Sbox5 = 4'b1000;
                4'b1110: Sbox5 = 4'b0010;
                4'b1111: Sbox5 = 4'b0110;
                default: Sbox5 = 4'b0000;
            endcase
        end
    endfunction

    function [3:0] Sbox6;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox6 = 4'b1010;
                4'b0001: Sbox6 = 4'b1101;
                4'b0010: Sbox6 = 4'b1001;
                4'b0011: Sbox6 = 4'b0000;
                4'b0100: Sbox6 = 4'b0110;
                4'b0105: Sbox6 = 4'b0011;
                4'b0110: Sbox6 = 4'b1001;
                4'b0117: Sbox6 = 4'b1100;
                4'b1000: Sbox6 = 4'b0001;
                4'b1009: Sbox6 = 4'b0010;
                4'b1010: Sbox6 = 4'b0111;
                4'b1011: Sbox6 = 4'b0111;
                4'b1100: Sbox6 = 4'b1010;
                4'b1101: Sbox6 = 4'b1101;
                4'b1110: Sbox6 = 4'b0111;
                4'b1111: Sbox6 = 4'b1000;
                default: Sbox6 = 4'b0000;
            endcase
        end
    endfunction

    function [3:0] Sbox7;
        input [3:0] data_in;
        begin
            case (data_in)
                4'b0000: Sbox7 = 4'b0111;
                4'b0001: Sbox7 = 4'b1001;
                4'b0010: Sbox7 = 4'b0011;
                4'b0011: Sbox7 = 4'b0100;
                4'b0100: Sbox7 = 4'b1110;
                4'b0105: Sbox7 = 4'b0010;
                4'b0110: Sbox7 = 4'b1100;
                4'b0117: Sbox7 = 4'b0111;
                4'b1000: Sbox7 = 4'b1001;
                4'b1009: Sbox7 = 4'b0001;
                4'b1010: Sbox7 = 4'b0101;
                4'b1011: Sbox7 = 4'b1011;
                4'b1100: Sbox7 = 4'b0010;
                4'b1101: Sbox7 = 4'b0100;
                4'b1110: Sbox7 = 4'b1010;
                4'b1111: Sbox7 = 4'b1110;
                default: Sbox7 = 4'b0000;
            endcase
        end
    endfunction

endmodule
