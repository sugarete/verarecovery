module key_schedule (
    input wire i_clk,
    input wire i_rstn,
    input wire i_begin,
    input wire [255:0] i_key,
    output wire [127:0] o_subkey,
    output wire [5:0] o_address,
    output wire o_subkey_valid
);

//---------wires, registers----------
reg [31:0] prekey [139:0];
reg [5:0] round;
reg key_valid;
integer i;
reg [127:0] sbox_input;
reg [2:0] sbox_index;
wire [127:0] sbox_output;

reg [1:0] key_schedule_state;
parameter IDLE          = 2'b00;
parameter KEY_SCHEDULE  = 2'b10;

//---------instances------------
sboxes sboxes_inst (
    .i_data(sbox_input),
    .i_Sbox_index(sbox_index),
    .o_data(sbox_output)
);

//---------assignment-----------
assign o_subkey = sbox_output;
assign o_address = round - 1;
assign o_subkey_valid = key_valid;

//---------key schedule----------
always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        for(i = 0; i < 140; i = i + 1) begin
            prekey[i] <= 0;
        end
        round <= 0;
        key_valid <= 0;
        key_schedule_state <= IDLE;
    end else begin
        key_valid <= 0;
        case (key_schedule_state)
            IDLE: begin
                round <= 0;
                if (i_begin) begin
                    prekey[0] <= i_key[255:224];
                    prekey[1] <= i_key[223:192];
                    prekey[2] <= i_key[191:160];
                    prekey[3] <= i_key[159:128];
                    prekey[4] <= i_key[127:96];
                    prekey[5] <= i_key[95:64];
                    prekey[6] <= i_key[63:32];
                    prekey[7] <= i_key[31:0];
                    key_schedule_state <= KEY_SCHEDULE;
                end
            end
            KEY_SCHEDULE: begin
                if(round < 32) begin                
                    if(round != 0) begin
                        sbox_input <= {prekey[8 + (round-1)*4 - 8], prekey[8 + (round-1)*4 - 5], prekey[8 + (round-1)*4 - 3], prekey[8 + (round-1)*4 - 1]};
                        sbox_index <= (35 - round - 1) % 32;
                    end 
                    // prekey[8 + round*4]  <= ROL11(prekey[8 + round*4 - 8] ^ prekey[8 + round*4 - 5] ^ prekey[8 + round*4 - 3] ^ prekey[8 + round*4 - 1] ^ 32'h9e3779b9);
                    // prekey[9 + round*4]  <= ROL11(prekey[9 + round*4 - 8] ^ prekey[9 + round*4 - 5] ^ prekey[9 + round*4 - 3] ^ ROL11(prekey[8 + round*4 - 8] ^ prekey[8 + round*4 - 5] ^ prekey[8 + round*4 - 3] ^ prekey[8 + round*4 - 1] ^ 32'h9e3779b9) ^ 32'h9e3779b9);
                    // prekey[10 + round*4] <= ROL11(prekey[10 + round*4 - 8] ^ prekey[10 + round*4 - 5] ^ prekey[10 + round*4 - 3] ^ ROL11(prekey[9 + round*4 - 8] ^ prekey[9 + round*4 - 5] ^ prekey[9 + round*4 - 3] ^ ROL11(prekey[8 + round*4 - 8] ^ prekey[8 + round*4 - 5] ^ prekey[8 + round*4 - 3] ^ prekey[8 + round*4 - 1] ^ 32'h9e3779b9) ^ 32'h9e3779b9) ^ 32'h9e3779b9);
                    // prekey[11 + round*4] <= ROL11(prekey[11 + round*4 - 8] ^ prekey[11 + round*4 - 5] ^ prekey[11 + round*4 - 3] ^ ROL11(prekey[10 + round*4 - 8] ^ prekey[10 + round*4 - 5] ^ prekey[10 + round*4 - 3] ^ ROL11(prekey[9 + round*4 - 8] ^ prekey[9 + round*4 - 5] ^ prekey[9 + round*4 - 3] ^ ROL11(prekey[8 + round*4 - 8] ^ prekey[8 + round*4 - 5] ^ prekey[8 + round*4 - 3] ^ prekey[8 + round*4 - 1] ^ 32'h9e3779b9) ^ 32'h9e3779b9) ^ 32'h9e3779b9) ^ 32'h9e3779b9);
                    round <= round + 1;
                end else begin
                    key_valid <= 1;
                    key_schedule_state <= IDLE;
                end
            end
        endcase
    end    
end

endmodule
