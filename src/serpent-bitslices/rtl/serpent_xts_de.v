module serpent_xts_de (
    input wire i_clk,
    input wire i_rstn,
    input wire i_master_key_valid,
    input wire i_enable_decrypt,
    input wire [511:0] i_key,
    input wire [127:0] i_data,
    output wire [127:0] o_data,
    output wire o_data_valid
);

//---------wires, registers----------
reg [255:0] key1, key2;
reg enable_tweak, enable_encrypt, valid;
wire tweak_valid, encrypt_valid;
reg  [127:0] i_data_tweak;
wire [127:0] o_data_tweak;
reg [127:0]  data_cipher_input; 
wire [127:0] data_cipher_output;
reg [127:0] xts_output;

reg [1:0] serpent_xts_de_state;
parameter IDLE          = 2'b00;
parameter TWEAK_CALC    = 2'b01;
parameter DATA_CIPHER   = 2'b10;
parameter DONE          = 2'b11;
reg [8*12-1:0] displaystate;

serpent_encrypt_top tweak_cipher (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_master_key_valid(i_master_key_valid),
    .i_enable_encrypt(enable_tweak),
    .i_key(key2),
    .i_data(i_data_tweak),
    .o_data(o_data_tweak),
    .o_data_valid(tweak_valid)
);

serpent_encrypt_top data_cipher (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_master_key_valid(i_master_key_valid),
    .i_enable_encrypt(enable_encrypt),
    .i_key(key1),
    .i_data(data_cipher_input),
    .o_data(data_cipher_output),
    .o_data_valid(encrypt_valid)
);

assign o_data = xts_output;
assign o_data_valid = valid;

always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        key1 <= 0;
        key2 <= 0;
        i_data_tweak <= 0;
        data_cipher_input <= 0;
        serpent_xts_de_state <= IDLE;
    end else begin
        case (serpent_xts_de_state)
            IDLE: begin
                if (i_master_key_valid && i_enable_decrypt) begin
                    key1 <= i_key[511:256];
                    key2 <= i_key[255:0];
                    i_data_tweak <= 128'h0;
                    enable_tweak <= 1;
                    serpent_xts_de_state <= TWEAK_CALC;
                end
            end
            TWEAK_CALC: begin
                if (tweak_valid) begin
                    data_cipher_input <= i_data[127:0] ^ o_data_tweak;
                    enable_tweak <= 0;
                    enable_encrypt <= 1;
                    serpent_xts_de_state <= DATA_CIPHER;
                end
            end
            DATA_CIPHER: begin
                if (encrypt_valid) begin
                    xts_output <= data_cipher_output ^ i_data[127:0];
                    // xts_output <= 128'hc863efb35441381833727e06fb0a8adf;
                    enable_encrypt <= 0;
                    valid <= 1;
                    serpent_xts_de_state <= DONE;
                end
            end
            DONE: begin
                if (i_enable_decrypt) begin
                    key1 <= i_key[511:256];
                    key2 <= i_key[255:0];
                    i_data_tweak <= 128'h0;
                    enable_tweak <= 1;
                    serpent_xts_de_state <= TWEAK_CALC;
                end else begin
                    serpent_xts_de_state <= IDLE;
                end
            end
        endcase
    end
end

always @(*) begin
    case (serpent_xts_de_state)
        IDLE: displaystate = "IDLE";
        TWEAK_CALC: displaystate = "TWEAK_CALC";
        DATA_CIPHER: displaystate = "DATA_CIPHER";
        DONE: displaystate = "DONE";
    endcase
end
    
endmodule