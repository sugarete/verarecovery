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
reg [127:0] mixed_round_32;
reg valid;

reg [2:0] serpent_en_state;
parameter IDLE          = 3'b000;
// parameter MIXKEY        = 3'b001;
parameter IP            = 3'b001;
parameter ROUND         = 3'b010;
// parameter FP            = 3'b011;
parameter MIX32         = 3'b100;


reg[8*6-1:0] displaystate_serpent_en;

//---------instances------------
// initial_permutation initial_permutation_inst (
//     .i_data(i_data),
//     .o_data(initial_permutation_output)
// );

serpent_en_round serpent_en_round_inst (
    .i_data(data_in),
    .i_round(round),
    .o_data(data_out)
);

// final_permutation final_permutation_inst (
//     .i_data(final_permutation_input),
//     .o_data(o_data)
// );

//---------assignment-----------
assign o_address = round;
assign o_data_valid = valid;
assign o_data = mixed_round_32;

always @(posedge i_clk or negedge i_rstn) begin
    if (~i_rstn) begin
        round <= 0;
        data_in <= 0;
        serpent_en_state <= IDLE;
    end else begin
        case (serpent_en_state)
            IDLE: begin
                round <= 0;
                if (i_en == 1'b1 && i_subkey_valid == 1'b1) begin
                    serpent_en_state <= ROUND;
                end
            end
            // IP: begin
            //     data_in <= initial_permutation_output;
            //     serpent_en_state <= ROUND;
            // end
            ROUND: begin
                if(round == 0) begin
                    data_in <= i_data ^ i_key;
                    round <= round + 1;
                    serpent_en_state <= ROUND;
                end else if(round < 31) begin
                    data_in <= data_out ^ i_key;
                    round <= round + 1;
                    serpent_en_state <= ROUND;
                end else begin
                    data_in <= data_out ^ i_key;
                    round <= round + 1;
                    serpent_en_state <= MIX32;
                end
            end
            MIX32: begin
                mixed_round_32 <= data_out ^ i_key;
                valid <= 1;
                serpent_en_state <= IDLE;
            end
            // FP: begin                
            //     final_permutation_input <= data_out ^ i_key;
            //     valid <= 1;
            //     serpent_en_state <= IDLE;
            // end
        endcase
    end
end

always @(*) begin
    case (serpent_en_state)
        IDLE:       displaystate_serpent_en = "IDLE";
        IP:         displaystate_serpent_en = "IP";
        // MIXKEY:     displaystate_serpent_en = "MIXKEY";
        ROUND:      displaystate_serpent_en = "ROUND";
        // FP:         displaystate_serpent_en = "FP";
        MIX32:      displaystate_serpent_en = "MIX32";
        default:    displaystate_serpent_en = "IDLE";
    endcase
end

endmodule