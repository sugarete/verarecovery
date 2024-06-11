`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2022 09:09:42 AM
// Design Name: 
// Module Name: dictionary_mode
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module dictionary_mode
(
    input wire              i_dictionary_mode_clk,
    input wire              i_dictionary_mode_rst,
    input wire              i_dictionary_mode_en,
    input wire              i_dictionary_mode_load,
    input wire              i_dictionary_mode_fifo_nealy_full,    
    input wire   [95:0]     i_dictionary_mode_pass_in,
    input wire              i_dictionary_mode_pass_valid,
    input wire   [7:0]      i_dictionary_mode_length_gen,
    input wire              i_dictionary_mode_status_check,

    input wire   [95:0]     i_dictionary_mode_rule,
    input wire   [191:0]    i_dictionary_mode_rule_value,

    output wire              o_dictionary_mode_respond_valid,
    output wire   [191:0]    o_dictionary_mode_pass,
    output wire   [7:0]      o_dictionary_mode_length,
    output wire              o_dictionary_mode_pass_valid,
    output wire              o_dictionary_export_done
    );

    wire                    password_valid;
    reg                     responde_valid;  
    reg                     fifo_nealy_full_reg;
    reg         [7:0]       rule_reg        [0:11];
    reg         [15:0]      rule_value_reg  [0:11];
    reg         [95:0]      pass_reg;
    reg         [95:0]      pass_out;
    reg         [7:0]       pass_len_reg;
    reg         [7:0]       pass_out_len;
    reg                     pass_gen_enable;
    reg         [95:0]      pass_gen_password_in;
    reg         [7:0]       pass_gen_rule_in;
    reg         [15:0]      pass_gen_rule_value_in;
    reg         [7:0]       pass_gen_password_len_in;
    wire                    pass_gen_done;
    wire                    pass_gen_valid;
    wire        [95:0]      pass_gen_password_out;
    wire        [7:0]       pass_gen_password_out_len;
    reg         [7:0]       index;
    reg         [3:0]       dictionary_mode_state;

    reg                     export_done;

    localparam  IDLE        = 4'd0;
    localparam  RECV        = 4'd1;
    localparam  CHECK_RULE  = 4'd2;
    localparam  GEN_PASS    = 4'd3;
    localparam  EXPORT      = 4'd4;

    localparam  STATE_WAIT_0      = 4'd5;
    localparam  STATE_WAIT_1      = 4'd6;
    localparam  STATE_WAIT_2      = 4'd7;

    assign password_valid   = ((dictionary_mode_state == EXPORT) & (i_dictionary_mode_fifo_nealy_full == 1'b0) ) ? 1'b1 : 1'b0;
    
    always @(posedge i_dictionary_mode_clk or negedge i_dictionary_mode_rst)
    begin
        if(!i_dictionary_mode_rst)
        begin
            index                               <= 8'h0;
            pass_gen_enable                     <= 1'b0;
            pass_gen_password_in                <= 96'h0;
            pass_gen_password_len_in            <= 8'h0;
            pass_gen_rule_in                    <= 8'h0;
            pass_gen_rule_value_in              <= 16'h0;
            pass_reg                            <= 96'h0;
            pass_out                            <= 96'h0;
            pass_len_reg                        <= 8'h0;
            pass_out_len                        <= 8'h0;
            responde_valid                      <= 1'b0; 
            fifo_nealy_full_reg                 <= 1'b1;
            rule_reg[00]                        <= 8'h0 ;
            rule_reg[01]                        <= 8'h0 ;
            rule_reg[02]                        <= 8'h0 ;
            rule_reg[03]                        <= 8'h0 ;
            rule_reg[04]                        <= 8'h0 ;
            rule_reg[05]                        <= 8'h0 ;
            rule_reg[06]                        <= 8'h0 ;
            rule_reg[07]                        <= 8'h0 ;
            rule_reg[08]                        <= 8'h0 ;
            rule_reg[09]                        <= 8'h0 ;
            rule_reg[10]                        <= 8'h0 ;
            rule_reg[11]                        <= 8'h0 ;
            rule_value_reg[00]                  <= 8'h0 ;
            rule_value_reg[01]                  <= 8'h0 ;
            rule_value_reg[02]                  <= 8'h0 ;
            rule_value_reg[03]                  <= 8'h0 ;
            rule_value_reg[04]                  <= 8'h0 ;
            rule_value_reg[05]                  <= 8'h0 ;
            rule_value_reg[06]                  <= 8'h0 ;
            rule_value_reg[07]                  <= 8'h0 ;
            rule_value_reg[08]                  <= 8'h0 ;
            rule_value_reg[09]                  <= 8'h0 ;
            rule_value_reg[10]                  <= 8'h0 ;
            rule_value_reg[11]                  <= 8'h0 ;
            export_done                     <= 1'b0;  
            dictionary_mode_state               <= IDLE;
        end
        else
        begin
            if(i_dictionary_mode_en == 1'b0 || i_dictionary_mode_status_check == 1'b1)
            begin
                index                           <= 8'h0;
                pass_gen_enable                 <= 1'b0;
                pass_gen_password_in            <= 96'h0;
                pass_gen_password_len_in        <= 8'h0;
                pass_gen_rule_in                <= 8'h0;
                pass_gen_rule_value_in          <= 16'h0;
                pass_reg                        <= 96'h0;
                pass_len_reg                    <= 8'h0;
                responde_valid                  <= 1'b1; 
                fifo_nealy_full_reg             <= 1'b1;
                rule_reg[00]                        <= 8'h0 ;
                rule_reg[01]                        <= 8'h0 ;
                rule_reg[02]                        <= 8'h0 ;
                rule_reg[03]                        <= 8'h0 ;
                rule_reg[04]                        <= 8'h0 ;
                rule_reg[05]                        <= 8'h0 ;
                rule_reg[06]                        <= 8'h0 ;
                rule_reg[07]                        <= 8'h0 ;
                rule_reg[08]                        <= 8'h0 ;
                rule_reg[09]                        <= 8'h0 ;
                rule_reg[10]                        <= 8'h0 ;
                rule_reg[11]                        <= 8'h0 ;
                rule_value_reg[00]                  <= 8'h0 ;
                rule_value_reg[01]                  <= 8'h0 ;
                rule_value_reg[02]                  <= 8'h0 ;
                rule_value_reg[03]                  <= 8'h0 ;
                rule_value_reg[04]                  <= 8'h0 ;
                rule_value_reg[05]                  <= 8'h0 ;
                rule_value_reg[06]                  <= 8'h0 ;
                rule_value_reg[07]                  <= 8'h0 ;
                rule_value_reg[08]                  <= 8'h0 ;
                rule_value_reg[09]                  <= 8'h0 ;
                rule_value_reg[10]                  <= 8'h0 ;
                rule_value_reg[11]                  <= 8'h0 ;
                export_done                     <= 1'b0;                
                dictionary_mode_state           <= IDLE;      
            end
            else
            begin
//                responde_valid          <= 1'b0; 
                case(dictionary_mode_state)
                    IDLE: begin
                        if(i_dictionary_mode_load == 1'b1)
                        begin
                            rule_reg[00]                    <= i_dictionary_mode_rule[95: 88] ;
                            rule_reg[01]                    <= i_dictionary_mode_rule[87: 80] ;
                            rule_reg[02]                    <= i_dictionary_mode_rule[79: 72] ;
                            rule_reg[03]                    <= i_dictionary_mode_rule[71: 64] ;
                            rule_reg[04]                    <= i_dictionary_mode_rule[63: 56] ;
                            rule_reg[05]                    <= i_dictionary_mode_rule[55: 48] ;
                            rule_reg[06]                    <= i_dictionary_mode_rule[47: 40] ;
                            rule_reg[07]                    <= i_dictionary_mode_rule[39: 32] ;
                            rule_reg[08]                    <= i_dictionary_mode_rule[31: 24] ;
                            rule_reg[09]                    <= i_dictionary_mode_rule[23: 16] ;
                            rule_reg[10]                    <= i_dictionary_mode_rule[15: 08] ;
                            rule_reg[11]                    <= i_dictionary_mode_rule[07: 00] ;
                            rule_value_reg[00]              <= i_dictionary_mode_rule_value[191: 176] ;
                            rule_value_reg[01]              <= i_dictionary_mode_rule_value[175: 160] ;
                            rule_value_reg[02]              <= i_dictionary_mode_rule_value[159: 144] ;
                            rule_value_reg[03]              <= i_dictionary_mode_rule_value[143: 128] ;
                            rule_value_reg[04]              <= i_dictionary_mode_rule_value[127: 112] ;
                            rule_value_reg[05]              <= i_dictionary_mode_rule_value[111: 96] ;
                            rule_value_reg[06]              <= i_dictionary_mode_rule_value[95: 80] ;
                            rule_value_reg[07]              <= i_dictionary_mode_rule_value[79: 64] ;
                            rule_value_reg[08]              <= i_dictionary_mode_rule_value[63: 48] ;
                            rule_value_reg[09]              <= i_dictionary_mode_rule_value[47: 32] ;
                            rule_value_reg[10]              <= i_dictionary_mode_rule_value[31: 16] ;
                            rule_value_reg[11]              <= i_dictionary_mode_rule_value[15: 00] ;
                            export_done                     <= 1'b0; 
                            dictionary_mode_state   <= RECV;
                        end
                        else 
                            dictionary_mode_state   <= IDLE;
                    end
                    RECV : begin
                        responde_valid          <= 1'b0; 
                        if(i_dictionary_mode_pass_valid == 1'b1)
                        begin
                            pass_reg                            <= i_dictionary_mode_pass_in;
                            pass_len_reg                        <= i_dictionary_mode_length_gen*8;
                            dictionary_mode_state               <= STATE_WAIT_0;
                            responde_valid                      <= 1'b0;
                            index                               <= 8'h0;
                        end
                        else
                            dictionary_mode_state   <= RECV;
                    end
                    STATE_WAIT_0: begin
                        dictionary_mode_state               <= CHECK_RULE;
                        responde_valid                      <= 1'b0;
                    end
                    CHECK_RULE: begin
                        if (rule_reg[index] != 8'd0 && index < 4'd12) begin 
                            pass_gen_password_in                <= pass_reg;
                            pass_gen_password_len_in            <= pass_len_reg;
                            pass_gen_rule_in                    <= rule_reg[index];
                            pass_gen_rule_value_in              <= rule_value_reg[index];
                            pass_gen_enable                     <= 1'b1;
                            dictionary_mode_state               <= GEN_PASS;
                        end
                        else begin
                            pass_out                            <= pass_reg;
                            pass_out_len                        <= pass_len_reg;
                            responde_valid                      <= 1'b1;
                            // dictionary_mode_state               <= EXPORT;
                            dictionary_mode_state               <= STATE_WAIT_1;
                        end
                    end
                    STATE_WAIT_1:
                    begin
                        responde_valid                      <= 1'b1;
                        dictionary_mode_state               <= STATE_WAIT_2;
                    end
                    STATE_WAIT_2:
                    begin
                        responde_valid                      <= 1'b1;
                        dictionary_mode_state               <= EXPORT;
                    end
                    GEN_PASS: begin
                        pass_gen_enable                         <= 1'b0;
                        if (pass_gen_done == 1'b1) begin
                            if (pass_gen_valid == 1'b1) begin
                                pass_reg                        <= pass_gen_password_out;
                                pass_len_reg                    <= pass_gen_password_out_len;
                                dictionary_mode_state           <= CHECK_RULE;
                                index                           <= index + 1'b1;
                            end
                            else begin
                                responde_valid                  <= 1'b1;
                                dictionary_mode_state           <= RECV;
                            end
                        end
                    end

                    EXPORT: begin
                        if(i_dictionary_mode_fifo_nealy_full == 1'b0) begin
                            responde_valid                  <= 1'b0;
                            export_done                     <= 1'b1;
                            dictionary_mode_state           <= RECV;
                            end
                        else 
                            dictionary_mode_state           <= EXPORT;
                    end
                    default: dictionary_mode_state	            <= IDLE;
                endcase        
            end
        end
    end
    assign o_dictionary_mode_pass           = { pass_out[95:88], 8'd0, 
                                                pass_out[87:80], 8'd0, 
                                                pass_out[79:72], 8'd0, 
                                                pass_out[71:64], 8'd0, 
                                                pass_out[63:56], 8'd0, 
                                                pass_out[55:48], 8'd0, 
                                                pass_out[47:40], 8'd0, 
                                                pass_out[39:32], 8'd0, 
                                                pass_out[31:24], 8'd0, 
                                                pass_out[23:16], 8'd0, 
                                                pass_out[15:08], 8'd0, 
                                                pass_out[07:00], 8'd0};
    assign o_dictionary_mode_length        = pass_out_len*2;
    assign o_dictionary_mode_respond_valid = responde_valid;//responde_valid;
    assign o_dictionary_mode_pass_valid    = password_valid;
    assign o_dictionary_export_done    = export_done;
    reg [8*15-1:0] state_display;
    always @(*)
    begin
        case(dictionary_mode_state)
            IDLE:       state_display           = "IDLE";
            RECV:       state_display           = "RECV";
            CHECK_RULE: state_display           = "CHECK_RULE";
            GEN_PASS:   state_display           = "GEN_PASS";
            EXPORT:     state_display           = "EXPORT";
        endcase
    end                 

	dictionary_pass_gen uut (
		.i_dictionary_pass_gen_clk              (i_dictionary_mode_clk), 
		.i_dictionary_pass_gen_rst              (i_dictionary_mode_rst), 
		.i_dictionary_pass_gen_enable           (pass_gen_enable), 
		.i_dictionary_pass_gen_pass_in          (pass_gen_password_in), 
		.i_dictionary_pass_gen_pass_len         (pass_gen_password_len_in), 
		.i_dictionary_pass_gen_rule             (pass_gen_rule_in), 
		.i_dictionary_pass_gen_rule_value       (pass_gen_rule_value_in), 
        .o_dictionary_pass_gen_done             (pass_gen_done),
		.o_dictionary_pass_gen_valid            (pass_gen_valid), 
		.o_dictionary_pass_gen_password         (pass_gen_password_out), 
		.o_dictionary_pass_gen_password_len     (pass_gen_password_out_len)
	);
endmodule
