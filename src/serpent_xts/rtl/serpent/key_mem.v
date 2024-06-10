module key_mem (
    input wire i_clk,
    input wire i_rstn,
    input wire i_write_en,
    input wire i_read_en,
    input wire [5:0] i_addr,
    input wire [127:0] i_key,
    output wire [127:0] o_key
);

integer i;
reg [127:0] mem [32:0];

always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] <= 128'b0;
        end
    end else begin
        if (i_write_en) begin
            mem[i_addr] <= i_key;
        end
    end
end

assign o_key = (i_read_en) ? mem[i_addr] : 128'b0;

endmodule