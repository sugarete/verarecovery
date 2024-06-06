module serpent_de (
    input wire i_clk,
    input wire i_rstn,
    input wire i_de,
    input wire i_subkey_valid,
    input wire [127:0] i_key,
    input wire [127:0] i_data,
    output wire [127:0] o_data,
    output wire [5:0] o_address,
    output wire o_data_valid
);

//---------wires, registers----------
wire [127:0] final_permutation_output;
reg [127:0] initial_permutation_input;

reg [5:0] round;

wire [127:0] data_out;
reg [127:0] data_in;

reg valid;

reg [2:0] serpent_de_state;
parameter IDLE          = 3'b000;
parameter IP            = 3'b001;
parameter ROUND         = 3'b010;
parameter FP            = 3'b011;
parameter MIX32         = 3'b100;


reg[8*5-1:0] displaystate_serpent_en;

//---------instances------------
final_permutation final_permutation_inst (
    .i_data(i_data),
    .o_data(final_permutation_output)
);

serpent_de_round serpent_de_round_inst (
    .i_data(data_in),
    .i_round(round),
    .o_data(data_out)
);

initial_permutation initial_permutation_inst (
    .i_data(initial_permutation_input),
    .o_data(o_data)
);

//---------assignment-----------
assign o_address = round;
assign o_data_valid = valid;

always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        round <= 0;
        data_in <= 0;
        serpent_de_state <= IDLE;
    end else begin
        case (serpent_de_state)
            IDLE: begin
                round <= 32;
                if (i_de == 1'b1 && i_subkey_valid == 1'b1) begin
                    serpent_de_state <= IP;
                end
            end
            FP: begin
                valid <= 0;
                serpent_de_state <= IDLE;
            end
            ROUND: begin
                if(round == 32) begin
                    data_in <= data_in ^ i_key;
                    round <= round + 1;
                end else if(round > 0) begin
                    data_in <= data_out ^ i_key;
                    round <= round + 1;
                end else begin
                    data_in <= data_out ^ i_key;
                    round <= round + 1;
                    serpent_de_state <= MIX32;
                end
            end
            MIX32: begin
                serpent_de_state <= IP;
            end
            IP: begin                
                initial_permutation_input <= data_out;
                valid <= 1;
                serpent_de_state <= IDLE;
            end
        endcase
    end
end

always @(*) begin
    case (serpent_de_state)
        IDLE:       displaystate_serpent_en = "IDLE";
        IP:         displaystate_serpent_en = "IP";
        ROUND:      displaystate_serpent_en = "ROUND";
        FP:         displaystate_serpent_en = "FP";
        MIX32:      displaystate_serpent_en = "MIX32";
        default:    displaystate_serpent_en = "IDLE";
    endcase
end

endmodule