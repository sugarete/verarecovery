module serpent_en (
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
wire [127:0] initial_permutation_output;
reg [127:0] final_permutation_input;
reg [5:0] round;

wire [127:0] data_out;
reg [127:0] data_in;
reg valid;

reg [1:0] serpent_en_state;
parameter IDLE          = 2'b00;
parameter IP            = 2'b01;
parameter ROUND         = 2'b10;
parameter FP            = 2'b11;

//---------instances------------
initial_permutation initial_permutation_inst (
    .i_data(i_data),
    .o_data(initial_permutation_output)
);

serpent_en_round serpent_en_round_inst (
    .i_data(data_in),
    .i_subkey(i_key),
    .i_round(round),
    .o_data(data_out)
);

final_permutation final_permutation_inst (
    .i_data(final_permutation_input),
    .o_data(o_data)
);

//---------assignment-----------
assign o_address = round;
assign o_data_valid = valid;

always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        round <= 0;
        data_in <= 0;
        serpent_en_state <= IDLE;
    end else begin
        case (serpent_en_state)
            IDLE: begin
                round <= 0;
                if (i_en && i_subkey_valid) begin
                    data_in <= initial_permutation_output;
                    serpent_en_state <= ROUND;
                end
            end
            ROUND: begin
                round <= round + 1;
                data_in <= data_out;
                if (round == 31) begin
                    serpent_en_state <= FP;
                end
            end
            FP: begin
                final_permutation_input <= data_out ^ i_key;
                valid <= 1;
                serpent_en_state <= IDLE;
            end
        endcase
    end
end

endmodule