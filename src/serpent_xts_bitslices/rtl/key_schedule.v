module key_schedule (
    input wire i_clk,
    input wire i_rstn,
    input wire i_begin,
    input wire [255:0] i_key,
    output wire [127:0] o_subkey,
    output wire [5:0] o_address,
    output wire o_subkey_valid
);


//--------------------------------------------wires, registers----------------------------------------------------
reg [7:0] word_round;
reg [31:0] word [139:0];

reg [5:0] key_round;
reg key_valid;

reg [2:0] key_sbox_index;
reg [31:0] key_word_0, key_word_1, key_word_2, key_word_3;

integer i;
//--------------------------------------------------states----------------------------------------------------------
reg [1:0] key_schedule_state;
parameter IDLE          = 2'b00;
parameter WORD_EXPAND   = 2'b01;
parameter KEY_GEN       = 2'b10;
parameter WAIT          = 2'b11;

reg [8*11-1:0] displaystate_key_schedule;
always @(*) begin
    case(key_schedule_state)
        IDLE:           displaystate_key_schedule = "IDLE";
        WORD_EXPAND:    displaystate_key_schedule = "WORD_EXPAND";
        KEY_GEN:        displaystate_key_schedule = "KEY_GEN";
        WAIT:           displaystate_key_schedule = "WAIT";
        default:        displaystate_key_schedule = "IDLE";
    endcase
end
//------------------------------------------------submodules------------------------------------------------------
sboxes sboxes_inst (
    .i_word_0(key_word_0),
    .i_word_1(key_word_1),
    .i_word_2(key_word_2),
    .i_word_3(key_word_3),
    .i_sbox_index(key_sbox_index),
    .o_data(o_subkey)
);

//------------------------------------------function&parameter-----------------------------------------------------
function [31:0] ROL11;
    input [31:0] data;
    begin
        ROL11 = {data[20:0], data[31:21]};
    end
endfunction

parameter phi = 32'h9e3779b9;

//--------------------------------------------assign--------------------------------------------------------------
assign o_address = key_round - 1;
assign o_subkey_valid = key_valid;

//--------------------------------------------key schedule---------------------------------------------------------
always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        for(i = 0; i < 140; i = i + 1) begin
            word[i] <= 0;
        end
        key_round <= 0;
        word_round <= 0;
        key_valid <= 0;
        key_schedule_state <= IDLE;
    end else begin
        case (key_schedule_state)
            IDLE: begin
                word_round <= 0;
                key_round <= 0;
                if (i_begin) begin
                    key_valid <= 0;
                    word[0] <= i_key[31:0];
                    word[1] <= i_key[63:32];
                    word[2] <= i_key[95:64];
                    word[3] <= i_key[127:96];
                    word[4] <= i_key[159:128];
                    word[5] <= i_key[191:160];
                    word[6] <= i_key[223:192];
                    word[7] <= i_key[255:224];
                    key_schedule_state <= WORD_EXPAND;
                end
            end
            WORD_EXPAND: begin
                if(word_round < 132) begin                    
                    word[word_round + 8] <= ROL11(word[word_round + 0] ^ word[word_round + 3] ^ word[word_round + 5] ^ word[word_round + 7] ^ phi ^ word_round);
                    word_round <= word_round + 1;
                end else begin
                    key_schedule_state <= KEY_GEN;
                end
            end
            KEY_GEN: begin
                if(key_round < 33) begin                
                    key_word_0 <= word[8 + (key_round)*4 + 0];
                    key_word_1 <= word[8 + (key_round)*4 + 1];
                    key_word_2 <= word[8 + (key_round)*4 + 2];
                    key_word_3 <= word[8 + (key_round)*4 + 3];
                    key_sbox_index <= (3 - key_round) % 8;
                    key_round <= key_round + 1;
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

endmodule
