module serpent_top (
    input wire i_clk,
    input wire i_rstn,
    input wire i_key_valid,
    input wire i_ena_en_de,
    input wire [255:0] i_key,
    input wire [127:0] i_data,
    output reg [127:0] o_data,
    output reg o_data_valid,
);

//-------------------wires, registers-------------------
reg write_en, read_en;
reg begin_key_schedule;
reg enable_encrypt, enable_decrypt;
wire [127:0] key_in, key_out;

reg [2:0] serpent_state;
parameter IDLE          = 3'b000;
parameter KEY_SCHEDULE  = 3'b001;
parameter ENCRYPT       = 3'b010;
parameter DECRYPT       = 3'b011;

//-------------------submodules-------------------
key_mem key_storage (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_write_en(write_en),
    .i_read_en(read_en),
    .i_addr(address),
    .i_key(key_in),
    .o_key(key_out)
);

key_schedule key_scheduler (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_begin(begin_key_schedule),
    .i_key(i_key),
    .o_subkey(key_in),
    .o_address(write_address),
    .o_subkey_valid(key_valid)
);

serpent_encrypt encrypt_block (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_en(enable_encrypt),
    .i_subkey_valid(key_valid),
    .i_key(key_out),
    .i_data(i_data),
    .o_data(o_data),
    .o_address(read_address),
    .o_data_valid(o_data_valid)
);

serpent_decrypt decrypt_block (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_en(enable_decrypt),
    .i_subkey_valid(key_valid),
    .i_key(key_out),
    .i_data(i_data),
    .o_data(o_data),
    .o_address(read_address),
    .o_data_valid(o_data_valid)
);
//------------------FSM-------------------

always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        serpent_state <= IDLE;
        write_en <= 0;
        read_en <= 0;
        begin_key_schedule <= 0;
        enable_encrypt <= 0;
        enable_decrypt <= 0;
    end else begin
        case (serpent_state)
            IDLE: begin
                if (i_key_valid == 1'b1) begin
                    write_en <= 1;
                    begin_key_schedule <= 1;
                    serpent_state <= KEY_SCHEDULE;
                end
            end
            KEY_SCHEDULE: begin
                if (key_valid == 1'b1) begin
                    write_en <= 0;
                    read_en <= 1;
                    if (i_ena_en_de == 1'b1) begin
                        enable_encrypt <= 1;
                        serpent_state <= ENCRYPT;
                    end else begin
                        enable_decrypt <= 1;
                        serpent_state <= DECRYPT;
                    end
                end
            end
            ENCRYPT: begin
                if (o_data_valid == 1'b1) begin
                    read_en <= 0;
                    serpent_state <= IDLE;
                end
            end
            DECRYPT: begin
                if (o_data_valid == 1'b1) begin
                    read_en <= 0;
                    serpent_state <= IDLE;
                end
            end
        endcase
    end
end
    
endmodule