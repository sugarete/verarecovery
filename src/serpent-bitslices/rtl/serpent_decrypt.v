module serpent_decrypt (
    input wire i_clk,
    input wire i_rstn,
    input wire i_en,
    input wire i_subkey_valid,
    input wire [127:0] i_key,
    input wire [127:0] i_data,
    output wire [127:0] o_data,
    output wire [5:0] o_address,
    output wire o_data_valid
);

//---------wires, registers----------
reg [5:0] decrypt_round;

wire [31:0] word_0_out, word_1_out, word_2_out, word_3_out;
reg [31:0] word_0_in, word_1_in, word_2_in, word_3_in;
reg [127:0] mixed_round_32;
reg valid;

reg [2:0] serpent_de_state;
parameter IDLE          = 3'b000;
// parameter MIXKEY        = 3'b001;
// parameter IP            = 3'b001;
parameter ROUND         = 3'b010;
// parameter FP            = 3'b011;
parameter MIX32         = 3'b100;


reg[8*6-1:0] displaystate_serpent_de;

serpent_decrypt_stage serpent_decrypt_stage_inst (
    .i_data_word_0(word_0_in),
    .i_data_word_1(word_1_in),
    .i_data_word_2(word_2_in),
    .i_data_word_3(word_3_in),
    .i_round(decrypt_round),
    .o_data_word_0(word_0_out),
    .o_data_word_1(word_1_out),
    .o_data_word_2(word_2_out),
    .o_data_word_3(word_3_out)
);
//---------assignment-----------
assign o_address = decrypt_round;
assign o_data_valid = valid;
assign o_data = mixed_round_32;

always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        decrypt_round <= 0;
        word_0_in <= 0;
        word_1_in <= 0;
        word_2_in <= 0;
        word_3_in <= 0;
        mixed_round_32 <= 0;
        valid <= 0;
        serpent_de_state <= IDLE;
    end else begin
        case (serpent_de_state)
            IDLE: begin
                decrypt_round <= 6'd32;
                if (i_en == 1'b1 && i_subkey_valid == 1'b1) begin
                    serpent_de_state <= MIX32;
                end
            end
            MIX32: begin
                mixed_round_32 <= {word_3_out ^ i_key[31:0], word_2_out ^ i_key[31:0], word_1_out ^ i_key[31:0], word_0_out ^ i_key[31:0]};
                serpent_de_state <= ROUND;
            end
            ROUND: begin
                if(decrypt_round == 6'd32) begin
                    word_0_in <= mixed_round_32[31:0];
                    word_1_in <= mixed_round_32[63:32];
                    word_2_in <= mixed_round_32[95:64];
                    word_3_in <= mixed_round_32[127:96];
                    decrypt_round <= decrypt_round - 1;
                    serpent_de_state <= ROUND;
                end else if(decrypt_round > 0) begin
                    word_0_in <= word_0_out ^ i_key[31:0];
                    word_1_in <= word_1_out ^ i_key[63:32];
                    word_2_in <= word_2_out ^ i_key[95:64];
                    word_3_in <= word_3_out ^ i_key[127:96];
                    decrypt_round <= decrypt_round - 1;
                    serpent_de_state <= ROUND;
                end else begin
                    valid <= 1;
                    serpent_de_state <= IDLE;
                end
            end
        endcase
    end
end

always @(*) begin
    case (serpent_de_state)
        IDLE:       displaystate_serpent_de = "IDLE";
        ROUND:      displaystate_serpent_de = "ROUND";
        MIX32:      displaystate_serpent_de = "MIX32";
        default:    displaystate_serpent_de = "IDLE";
    endcase
end

endmodule