module key_schedule_slow (
    input wire i_clk,
    input wire i_rstn,
    input wire i_begin,
    input wire [255:0] i_key,
    output wire [127:0] o_subkey,
    output wire [5:0] o_address,
    output wire o_subkey_valid
);

//-------wires, registers--------
// prekey is a 140x32-bit register, use to store word expanded for key schedule
reg [31:0] prekey [139:0];
// word_round is a 8-bit register, use to store the current word round
reg [7:0] word_round;
// round is a 6-bit register, use to store the current round
reg [5:0] round;
// key_valid is a 1-bit register, use to store the key valid signal, 1 means key is valid and ready to use
reg key_valid;
// Sbox input and index
reg [31:0] word0, word1, word2, word3;
reg [2:0] sbox_index;
wire [127:0] sbox_output;

integer i;

// key_schedule_state is a 2-bit register, use to store the current state of key schedule
reg [1:0] key_schedule_state;
parameter IDLE          = 2'b00;
parameter WORD_EXPAND   = 2'b01;
parameter KEY_GEN       = 2'b10;
parameter WAIT          = 2'b11;

reg [8*11-1:0] displaystate_key_schedule;
//---------instances------------
sboxes sboxes_inst (
    .i_word0(word0),
    .i_word1(word1),
    .i_word2(word2),
    .i_word3(word3),
    .i_Sbox_index(sbox_index),
    .o_data(o_subkey)
);

//----------function------------
function [31:0] ROL11;
    input [31:0] data;
    begin
        ROL11 = {data[20:0], data[31:21]};
    end
endfunction

//---------assignment-----------
assign o_address = round - 1;
assign o_subkey_valid = key_valid;

//---------key schedule----------
always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        for(i = 0; i < 140; i = i + 1) begin
            prekey[i] <= 0;
        end
        round <= 0;
        word_round <= 0;
        key_valid <= 0;
        key_schedule_state <= IDLE;
    end else begin
        case (key_schedule_state)
            IDLE: begin
                word_round <= 0;
                round <= 0;
                if (i_begin) begin
                    key_valid <= 0;
                    prekey[0] <= i_key[31:0];
                    prekey[1] <= i_key[63:32];
                    prekey[2] <= i_key[95:64];
                    prekey[3] <= i_key[127:96];
                    prekey[4] <= i_key[159:128];
                    prekey[5] <= i_key[191:160];
                    prekey[6] <= i_key[223:192];
                    prekey[7] <= i_key[255:224];
                    // prekey[0] <= i_key[255:224];
                    // prekey[1] <= i_key[223:192];
                    // prekey[2] <= i_key[191:160];
                    // prekey[3] <= i_key[159:128];
                    // prekey[4] <= i_key[127:96];
                    // prekey[5] <= i_key[95:64];
                    // prekey[6] <= i_key[63:32];
                    // prekey[7] <= i_key[31:0];                
                    key_schedule_state <= WORD_EXPAND;
                end
            end
            WORD_EXPAND: begin
                if(word_round < 132) begin                    
                    prekey[word_round + 8] <= ROL11(prekey[word_round + 0] ^ prekey[word_round + 3] ^ prekey[word_round + 5] ^ prekey[word_round + 7] ^ 32'h9e3779b9 ^ word_round);
                    word_round <= word_round + 1;
                end else begin
                    key_schedule_state <= KEY_GEN;
                end
            end
            KEY_GEN: begin
                if(round < 33) begin                
                    word0 <= prekey[8 + (round)*4 + 0];
                    word1 <= prekey[8 + (round)*4 + 1];
                    word2 <= prekey[8 + (round)*4 + 2];
                    word3 <= prekey[8 + (round)*4 + 3];
                    sbox_index <= (3 - round) % 8;
                    round <= round + 1;
                end else begin
                    key_valid <= 1;
                    key_schedule_state <= WAIT;
                end                    
            end
            WAIT: begin
                key_schedule_state <= IDLE;
            end
            default: begin
                key_schedule_state <= IDLE;
            end
        endcase
    end    
end

always @(*) begin
    case(key_schedule_state)
        IDLE:           displaystate_key_schedule = "IDLE";
        WORD_EXPAND:    displaystate_key_schedule = "WORD_EXPAND";
        KEY_GEN:        displaystate_key_schedule = "KEY_GEN";
        WAIT:           displaystate_key_schedule = "WAIT";
        default:        displaystate_key_schedule = "IDLE";
    endcase
end

endmodule
