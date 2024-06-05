module Serpent_Key_Schedule (
    input wire [255:0] i_key,
    output wire subkey_ready,
    output reg [127:0] subkeys [0:32]
);

reg [31:0] w [0:139];  // Intermediate values for key schedule
integer i;

// S-boxes used in key schedule
function [31:0] Sbox;
    input [31:0] data_in;
    input [2:0] sbox_index;
    reg [3:0] slices [0:7];
    reg [3:0] transformed [0:7];
    integer j;
    begin
        // Split 32-bit word into 8 4-bit slices
        for (j = 0; j < 8; j = j + 1) begin
            slices[j] = data_in[j*4 +: 4];
        end

        // Apply S-box
        for (j = 0; j < 8; j = j + 1) begin
            case (sbox_index)
                3'b000: transformed[j] = Sbox0(slices[j]);
                3'b001: transformed[j] = Sbox1(slices[j]);
                3'b010: transformed[j] = Sbox2(slices[j]);
                3'b011: transformed[j] = Sbox3(slices[j]);
                3'b100: transformed[j] = Sbox4(slices[j]);
                3'b101: transformed[j] = Sbox5(slices[j]);
                3'b110: transformed[j] = Sbox6(slices[j]);
                3'b111: transformed[j] = Sbox7(slices[j]);
            endcase
        end

        // Combine transformed slices back into a 32-bit word
        Sbox = {transformed[7], transformed[6], transformed[5], transformed[4], 
                transformed[3], transformed[2], transformed[1], transformed[0]};
    end
endfunction

// Rotate Left
function [31:0] ROL;
    input [31:0] data_in;
    input [4:0] amount;
    begin
        ROL = (data_in << amount) | (data_in >> (32 - amount));
    end
endfunction

// Initial key expansion
always @(i_key) begin
    // Copy the original key into the first eight 32-bit words, w[0] to w[7]
    w[0] = i_key[255:224];
    w[1] = i_key[223:192];
    w[2] = i_key[191:160];
    w[3] = i_key[159:128];
    w[4] = i_key[127:96];
    w[5] = i_key[95:64];
    w[6] = i_key[63:32];
    w[7] = i_key[31:0];

    // Generate the remaining intermediate values w[8] to w[139]
    for (i = 8; i < 140; i = i + 1) begin
        w[i] = ROL((w[i-8] ^ w[i-5] ^ w[i-3] ^ w[i-1] ^ 32'h9e3779b9 ^ (i-8)), 11);
    end

    // Generate the subkeys from the intermediate values
    for (i = 0; i < 33; i = i + 1) begin
        subkeys[i] = {Sbox(w[4*i + 8], 3'b000), Sbox(w[4*i + 9], 3'b001),
                      Sbox(w[4*i + 10], 3'b010), Sbox(w[4*i + 11], 3'b011)};
    end
end

// S-box functions
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
            4'b1001: Sbox1 = 4'b0010;
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
            4'b0101: Sbox2 = 4'b1011;
            4'b0110: Sbox2 = 4'b0011;
            4'b0111: Sbox2 = 4'b1110;
            4'b1000: Sbox2 = 4'b1111;
            4'b1001: Sbox2 = 4'b0100;
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
            4'b0101: Sbox3 = 4'b0111;
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
            4'b0000: Sbox4 = 4'b0100;
            4'b0001: Sbox4 = 4'b1011;
            4'b0010: Sbox4 = 4'b0101;
            4'b0011: Sbox4 = 4'b1100;
            4'b0100: Sbox4 = 4'b0010;
            4'b0101: Sbox4 = 4'b1111;
            4'b0110: Sbox4 = 4'b1001;
            4'b0111: Sbox4 = 4'b1000;
            4'b1000: Sbox4 = 4'b0101;
            4'b1001: Sbox4 = 4'b1101;
            4'b1010: Sbox4 = 4'b1110;
            4'b1011: Sbox4 = 4'b0110;
            4'b1100: Sbox4 = 4'b0001;
            4'b1101: Sbox4 = 4'b0111;
            4'b1110: Sbox4 = 4'b1000;
            4'b1111: Sbox4 = 4'b0111;
            default: Sbox4 = 4'b0000;
        endcase
    end
endfunction

function [3:0] Sbox5;
    input [3:0] data_in;
    begin
        case (data_in)
            4'b0000: Sbox5 = 4'b1110;
            4'b0001: Sbox5 = 4'b1011;
            4'b0010: Sbox5 = 4'b0010;
            4'b0011: Sbox5 = 4'b0100;
            4'b0100: Sbox5 = 4'b1000;
            4'b0105: Sbox5 = 4'b1111;
            4'b0110: Sbox5 = 4'b0001;
            4'b0111: Sbox5 = 4'b0011;
            4'b1000: Sbox5 = 4'b1011;
            4'b1001: Sbox5 = 4'b1000;
            4'b1010: Sbox5 = 4'b1100;
            4'b1011: Sbox5 = 4'b0101;
            4'b1100: Sbox5 = 4'b0110;
            4'b1101: Sbox5 = 4'b1101;
            4'b1110: Sbox5 = 4'b0000;
            4'b1111: Sbox5 = 4'b1000;
            default: Sbox5 = 4'b0000;
        endcase
    end
endfunction

function [3:0] Sbox6;
    input [3:0] data_in;
    begin
        case (data_in)
            4'b0000: Sbox6 = 4'b0111;
            4'b0001: Sbox6 = 4'b1101;
            4'b0010: Sbox6 = 4'b1010;
            4'b0011: Sbox6 = 4'b0010;
            4'b0100: Sbox6 = 4'b1001;
            4'b0101: Sbox6 = 4'b1000;
            4'b0110: Sbox6 = 4'b0101;
            4'b0111: Sbox6 = 4'b1100;
            4'b1000: Sbox6 = 4'b0111;
            4'b1001: Sbox6 = 4'b0001;
            4'b1010: Sbox6 = 4'b0110;
            4'b1011: Sbox6 = 4'b0011;
            4'b1100: Sbox6 = 4'b0000;
            4'b1101: Sbox6 = 4'b1011;
            4'b1110: Sbox6 = 4'b0100;
            4'b1111: Sbox6 = 4'b1111;
            default: Sbox6 = 4'b0000;
        endcase
    end
endfunction

function [3:0] Sbox7;
    input [3:0] data_in;
    begin
        case (data_in)
            4'b0000: Sbox7 = 4'b0001;
            4'b0001: Sbox7 = 4'b1011;
            4'b0010: Sbox7 = 4'b1001;
            4'b0011: Sbox7 = 4'b0100;
            4'b0100: Sbox7 = 4'b1110;
            4'b0101: Sbox7 = 4'b1101;
            4'b0110: Sbox7 = 4'b1000;
            4'b0111: Sbox7 = 4'b1100;
            4'b1000: Sbox7 = 4'b0101;
            4'b1009: Sbox7 = 4'b1010;
            4'b1010: Sbox7 = 4'b0111;
            4'b1011: Sbox7 = 4'b0110;
            4'b1100: Sbox7 = 4'b1111;
            4'b1101: Sbox7 = 4'b0000;
            4'b1110: Sbox7 = 4'b0011;
            4'b1111: Sbox7 = 4'b0001;
            default: Sbox7 = 4'b0000;
        endcase
    end
endfunction

endmodule
