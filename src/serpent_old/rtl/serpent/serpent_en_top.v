module serpent_en_top (
    input wire i_clk,
    input wire i_rstn,
    input wire i_master_key_valid,
    input wire i_enable_encrypt,
    input wire [255:0] i_key,
    input wire [127:0] i_data,
    output wire [127:0] o_data,
    output wire o_data_valid
);

//---------wires, registers----------
reg write_en, read_en;
reg begin_key_schedule;
reg enable_encrypt;

wire key_valid;
wire [5:0] key_schedule_address, encrypt_address, address;

wire [127:0] key_in, key_out;

reg [1:0] serpent_encrypt_full_state;
parameter IDLE          = 2'b00;
parameter KEY_SCHEDULE  = 2'b10;
parameter ENCRYPT       = 2'b11;

reg [8*12-1:0] displaystate;

//---------instances------------
key_mem key_mem_inst (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_write_en(write_en),
    .i_read_en(read_en),
    .i_addr(address),
    .i_key(key_in),
    .o_key(key_out)
);

key_schedule_slow key_schedule_slow_inst (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_begin(begin_key_schedule),
    .i_key(i_key),
    .o_subkey(key_in),
    .o_address(key_schedule_address),
    .o_subkey_valid(key_valid)
);

serpent_en serpent_en_inst (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_en(enable_encrypt),
    .i_subkey_valid(key_valid),
    .i_key(key_out),
    .i_data(i_data),
    .o_data(o_data),
    .o_address(encrypt_address),
    .o_data_valid(o_data_valid)
);

//---------assignment-----------
assign address = serpent_encrypt_full_state == KEY_SCHEDULE ? key_schedule_address : (serpent_encrypt_full_state == ENCRYPT ? encrypt_address : 0);

always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        write_en <= 0;
        read_en <= 0;
        serpent_encrypt_full_state <= IDLE;
    end else begin
        case (serpent_encrypt_full_state)
            IDLE: begin
                write_en <= 0;
                read_en <= 0;
                if (i_master_key_valid == 1'b1 && i_enable_encrypt == 1'b1) begin
                    serpent_encrypt_full_state <= KEY_SCHEDULE;
                    begin_key_schedule <= 1;
                    write_en <= 1;
                end
            end
            KEY_SCHEDULE: begin
                if (key_valid) begin
                    serpent_encrypt_full_state <= ENCRYPT;
                    begin_key_schedule <= 0;
                    enable_encrypt <= 1;
                    write_en <= 0;
                    read_en <= 1;
                end
            end
            ENCRYPT: begin
                if (o_data_valid) begin
                    serpent_encrypt_full_state <= IDLE;
                    enable_encrypt <= 0;
                end
            end
        endcase
    end
end

always @(*) begin
    case(serpent_encrypt_full_state)
        IDLE:           displaystate = "IDLE";
        KEY_SCHEDULE:   displaystate = "KEY_SCHEDULE";
        ENCRYPT:        displaystate = "ENCRYPT";
        default:        displaystate = "IDLE";
    endcase
end

endmodule

