module serpent_xts_2 (
    input wire i_clk;
    input wire i_rstn;
    input wire i_master_key_valid;
    input wire i_enable_decrypt;
    input wire [511:0] i_key;
    input wire [127:0] i_data;
    output wire [127:0] o_data;
    output wire o_data_valid;
    output wire o_compare_valid;
);

//-------------------Internal wires, registers-------------------
reg [255:0] key, key1, key2;
reg [127:0] idata, odata, tweak, final_data;
reg en_de_control, key_valid, serpent_start;

reg [2:0] xts_state;
parameter IDLE = 3'b000;
parameter KEY_PREP = 3'b001;
parameter TWEAK_GEN = 3'b010;
parameter DATA_PROC = 3'b011;
parameter DATA_COMP = 3'b100;
parameter DONE = 3'b101;

//-----------------------------instantiation---------------------
serpent_top serpent (
    .i_clk(i_clk),
    .i_rstn(i_rstn),
    .i_key_valid(key_valid),
    .i_enable_decrypt(en_de_control),
    .i_serpent_start(serpent_start),
    .i_key(key),
    .i_data(idata),
    .o_data(odata),
    .o_data_valid(data_valid),
);

//-----------------------------fsm-------------------------------
always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        xts_state <= IDLE;
        key <= 0;
        key1 <= 0;
        key2 <= 0;
        idata <= 0;
        tweak <= 0;
        en_de_control <= 0;
        key_valid <= 0;
    end else begin
        case (xts_state)
            IDLE: begin
                if (i_master_key_valid) begin
                    key_valid <= 1;
                    xts_state <= KEY_PREP;
                end
            end
            KEY_PREP: begin
                key1 <= i_key[511:256];
                key2 <= i_key[255:0];
                xts_state <= TWEAK_GEN;
            end
            TWEAK_GEN: begin
                idata <= 128'h0;
                key = key1;
                en_de_control <= 1;
                if(data_valid) begin
                    tweak <= odata;
                    xts_state <= DATA_PROC;
                end
            end
            DATA_PROC: begin
                idata <= i_data ^ tweak;
                key = key2;
                en_de_control <= 0;
                if(data_valid) begin
                    xts_state <= DATA_COMP;
                    final_data <= odata ^ tweak;
                end
            end
            DATA_COMP: begin
                // first 4 bytes of final_data is the "VERA"
                if (final_data[127:120] == 8'h56 && final_data[119:112] == 8'h45 && final_data[111:104] == 8'h52 && final_data[103:96] == 8'h41) begin
                    o_compare_valid <= 1;
                end else begin
                    o_compare_valid <= 0;
                end
                xts_state <= DONE;
            end
            DONE: begin
                odata <= final_data;
                o_data_valid <= 1;
                xts_state <= IDLE;
            end
        endcase
    end
end

endmodule