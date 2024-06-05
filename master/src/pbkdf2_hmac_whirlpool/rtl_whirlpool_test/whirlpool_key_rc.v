module whirlpool_key_rc (
    input [3:0] round,
    output [511:0] key_rc
);

reg [511:0] round_const;

//  0 18 23 C6 E8 87 B8 01 4F 36 A6 D2 F5 79 6F 91 52
//  1 60 BC B 8E A3 0C 7B 35 1D E0 D7 C2 2E 4B FE 57
//  2 15 77 37 E5 9F F0 4A CA 58 C9 29 0A B1 A0 6B 85
//  3 BD 5D 10 F4 CB 3E 05 67 E4 27 41 8B A7 7D 95 C8
//  4 FB EE 7C 66 DD 17 47 9E CA 2D BF 07 AD 5A 83 33

always @(*) begin
    case (round)
        4'd1: round_const = 512'h1823c6e887b8014f;
        4'd2: round_const = 512'h36a6d2f5796f9152;
        4'd3: round_const = 512'h60bc9b8ea30c7b35;
        4'd4: round_const = 512'h1de0d7c22e4bfe57;
        4'd5: round_const = 512'h157737e59ff04ada;
        4'd6: round_const = 512'h58c9290ab1a06b85;
        4'd7: round_const = 512'hbd5d10f4cb3e0567;
        4'd8: round_const = 512'he427418ba77d95c8;
        4'd9: round_const = 512'hfbee7c66dd17479e;
        4'd10: round_const = 512'hca2dbf07ad5a8333;
        default: round_const = 512'h0;
    endcase
end

assign key_rc = round_const;

endmodule