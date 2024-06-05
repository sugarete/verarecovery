module key_mem (
    input wire i_write_en,
    input wire i_read_en,
    input wire i_addr,
    input wire [127:0] i_key,
    output wire [127:0] o_key
);

integer i;
reg [127:0] mem [32:0];
reg [127:0] key_out;

assign o_key = key_out;

always@(i_write_en, i_read_en, i_addr) begin
    if(i_write_en) begin
        //co the dung blocking cho nay duoc khong?
        //mem[i_addr] <= i_key;
        mem[i_addr] = i_key;
    end
    if(i_read_en) begin
        key_out = mem[i_addr];
    end
end
    
endmodule