`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:56 10/26/2022 
// Design Name: 
// Module Name:    dictionary_password_generate 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dictionary_pass_gen(
                            i_dictionary_pass_gen_clk,
                            i_dictionary_pass_gen_rst,
                            i_dictionary_pass_gen_enable,
                            i_dictionary_pass_gen_pass_in,
                            i_dictionary_pass_gen_pass_len,
                            i_dictionary_pass_gen_rule,
                            i_dictionary_pass_gen_rule_value,

                            o_dictionary_pass_gen_valid,
                            o_dictionary_pass_gen_done,
                            o_dictionary_pass_gen_password,
                            o_dictionary_pass_gen_password_len
                        );
    input wire              i_dictionary_pass_gen_clk;
    input wire              i_dictionary_pass_gen_rst;
    input wire              i_dictionary_pass_gen_enable;
    input wire  [95:0]      i_dictionary_pass_gen_pass_in;
    input wire  [7:0]       i_dictionary_pass_gen_pass_len;
    input wire  [7:0]       i_dictionary_pass_gen_rule;
    input wire  [15:0]      i_dictionary_pass_gen_rule_value;

    output reg              o_dictionary_pass_gen_valid;
    output reg              o_dictionary_pass_gen_done;
    output reg  [95:0]      o_dictionary_pass_gen_password;
    output reg  [7:0]       o_dictionary_pass_gen_password_len;
    
    reg         [95:0]      mask;
    reg         [7:0]       rule;
    reg         [7:0]       value_1;
    reg         [7:0]       value_2;
    reg         [7:0]       value_1_int;
    reg         [7:0]       value_2_int;
    reg         [7:0]       character [11:0];
    reg         [95:0]      pass_reg;
    reg         [7:0]       pass_len;
    reg         [1:0]       passwodr_generate_state;
    reg         [1:0]       scan_password_state;
    reg         [3:0]       counter;
    reg         [3:0]       char_loc;
    
    localparam  IDLE        = 2'd0;
    localparam  GEN_PASS    = 2'd1;
    localparam  PREPARE     = 2'd2;
    localparam  PROCESS     = 2'd3;
    /*PASSWORD GENERATE FSM*/
    always @(posedge i_dictionary_pass_gen_clk or negedge i_dictionary_pass_gen_rst)
    begin
        if(!i_dictionary_pass_gen_rst ) begin
            character[0]				        <= 8'h00;
            character[1]				        <= 8'h00;
            character[2]				        <= 8'h00;
            character[3]				        <= 8'h00;
            character[4]				        <= 8'h00;
            character[5]				        <= 8'h00;
            character[6]				        <= 8'h00;
            character[7]				        <= 8'h00;
            character[8]				        <= 8'h00;
            character[9]				        <= 8'h00;
            character[10]				        <= 8'h00;
            character[11]				        <= 8'h00;
            pass_reg                            <= 96'h0;
            pass_len                            <= 8'h00;
            o_dictionary_pass_gen_done          <= 1'b0;
            o_dictionary_pass_gen_valid         <= 1'b0;
            o_dictionary_pass_gen_password      <= 96'h0;
            o_dictionary_pass_gen_password_len  <= 8'h0;
            counter                             <= 4'h0;
            char_loc                            <= 4'h0;
            rule                                <= 8'h0;
            value_1                             <= 8'h0;
            value_1_int                         <= 8'h0;
            value_2                             <= 8'h0;
            value_2_int                         <= 8'h0;
            mask                                <= 96'hffffffffffffffffffffffff;
            scan_password_state                 <= PREPARE;
            passwodr_generate_state             <= IDLE;
        end
        else begin
            case (passwodr_generate_state)
                IDLE: begin
                    o_dictionary_pass_gen_done  <= 1'b0;
                    counter                     <= 4'h0;
                    char_loc                    <= 4'h0;
                    scan_password_state         <= PREPARE;
                    if(i_dictionary_pass_gen_enable) begin
                        character[0]                    <= i_dictionary_pass_gen_pass_in[95:88];
                        character[1]                    <= i_dictionary_pass_gen_pass_in[87:80];
                        character[2]		            <= i_dictionary_pass_gen_pass_in[79:72];
                        character[3]		            <= i_dictionary_pass_gen_pass_in[71:64];
                        character[4]		            <= i_dictionary_pass_gen_pass_in[63:56];
                        character[5]		            <= i_dictionary_pass_gen_pass_in[55:48];
                        character[6]		            <= i_dictionary_pass_gen_pass_in[47:40];
                        character[7]		            <= i_dictionary_pass_gen_pass_in[39:32];
                        character[8]		            <= i_dictionary_pass_gen_pass_in[31:24];
                        character[9]		            <= i_dictionary_pass_gen_pass_in[23:16];
                        character[10]		            <= i_dictionary_pass_gen_pass_in[15:8];
                        character[11]		            <= i_dictionary_pass_gen_pass_in[7:0]; 
                        pass_reg                        <= i_dictionary_pass_gen_pass_in;
                        pass_len                        <= i_dictionary_pass_gen_pass_len;
                        rule                            <= i_dictionary_pass_gen_rule;
                        value_1                         <= i_dictionary_pass_gen_rule_value[7:0];
                        value_2                         <= i_dictionary_pass_gen_rule_value[15:8];
//                        value_1_int                     <= i_dictionary_pass_gen_rule_value[7:0] - 8'h30;
//                        value_2_int                     <= i_dictionary_pass_gen_rule_value[15:8] - 8'h30;
                        if (i_dictionary_pass_gen_rule_value[7:0] >= 8'h30 && i_dictionary_pass_gen_rule_value[7:0] <= 8'h39)
                            value_1_int                 <= i_dictionary_pass_gen_rule_value[7:0] - 8'h30;
                        else if (i_dictionary_pass_gen_rule_value[7:0] >= 8'h41 && i_dictionary_pass_gen_rule_value[7:0] <= 8'h42)
                            value_1_int                 <= i_dictionary_pass_gen_rule_value[7:0] - 8'h37;
                        else if (i_dictionary_pass_gen_rule_value[7:0] >= 8'h61 && i_dictionary_pass_gen_rule_value[7:0] <= 8'h62)
                            value_1_int                 <= i_dictionary_pass_gen_rule_value[7:0] - 8'h57;
                        else 
                            value_1_int                 <= 0;
                        if (i_dictionary_pass_gen_rule_value[15:8] >= 8'h30 && i_dictionary_pass_gen_rule_value[15:8] <= 8'h39)
                            value_2_int                 <= i_dictionary_pass_gen_rule_value[15:8] - 8'h30;
                        else if (i_dictionary_pass_gen_rule_value[15:8] >= 8'h41 && i_dictionary_pass_gen_rule_value[15:8] <= 8'h42)
                            value_2_int                 <= i_dictionary_pass_gen_rule_value[15:8] - 8'h37;
                        else if (i_dictionary_pass_gen_rule_value[15:8] >= 8'h61 && i_dictionary_pass_gen_rule_value[15:8] <= 8'h62)
                            value_2_int                 <= i_dictionary_pass_gen_rule_value[15:8] - 8'h57;
                        else 
                            value_2_int                 <= 0;
                        o_dictionary_pass_gen_valid     <= 1'b1;
                        passwodr_generate_state         <= GEN_PASS;
                    end
                end 
                GEN_PASS: begin
                    case (rule)
                        // Do nothing, use the original input word
                        8'h3A: begin 
                            o_dictionary_pass_gen_password          <= pass_reg;
                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 1*/
                        //Rotate word left: password -> asswordp
                        8'h7B: begin
                            if (pass_len > 8'd8) 
                                o_dictionary_pass_gen_password      <= {(pass_reg << 8 ) | {character[0], 88'h0} >> (pass_len - 8)};
                            else 
                                o_dictionary_pass_gen_password      <= pass_reg;
                            
                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end/*RULE 2*/
                        // Rotate word right: password -> dpasswor
                        8'h7D: begin
                            if (pass_len > 8'd8) 
                                o_dictionary_pass_gen_password      <=  (pass_reg << pass_len - 8) | ((pass_reg >> 8) & (mask << 96-pass_len));
                            else 
                                o_dictionary_pass_gen_password      <= pass_reg;
                        
                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end/*RULE 3*/
                        //Delete the first character: password -> assword
                        8'h5B: begin
                            if(pass_len > 8'd8) begin
                                o_dictionary_pass_gen_password      <= pass_reg << 8;
                                o_dictionary_pass_gen_password_len  <= pass_len - 4'h8;
                            end
                            else begin
                                o_dictionary_pass_gen_password      <= pass_reg;
                                o_dictionary_pass_gen_password_len  <= pass_len;
                            end
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                                
                        end/*RULE 4*/
                        // Delete the last character: password -> passwor
                        8'h5D: begin
                            if (pass_len > 8) begin
                                o_dictionary_pass_gen_password      <= pass_reg & (mask << 96 - pass_len + 8);
                                o_dictionary_pass_gen_password_len  <= pass_len - 4'h8;
                            end
                            else begin
                                o_dictionary_pass_gen_password      <= pass_reg;
                                o_dictionary_pass_gen_password_len  <= pass_len;
                            end
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 5*/

                        //Capitalize: password -> Password
                        8'h63: begin
                            o_dictionary_pass_gen_password_len      <= pass_len;
                            if (character[0] < 8'h7b && character[0] > 8'h60) 
                                o_dictionary_pass_gen_password      <= {UPPERCASE(character[0]), pass_reg[87:0]};
                            else  if (character[0] < 8'h5b && character[0] > 8'h40)
                                o_dictionary_pass_gen_password      <= {LOWERCASE(character[0]), pass_reg[87:0]};
                            else 
                                o_dictionary_pass_gen_password      <= pass_reg;
                            
                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 6*/

                        // Lowercase the first character, uppercase the rest: password -> pASSWORD
                        8'h43 : begin
                            if (character[0] < 8'h5b && character[0] > 8'h40) 
                                o_dictionary_pass_gen_password[95:88] <= LOWERCASE(character[0]); 
                            else 
                                o_dictionary_pass_gen_password[95:88] <= character[0]; 
                            if (character[1] < 8'h7b && character[1] > 8'h60) 
                                o_dictionary_pass_gen_password[87:80] <= UPPERCASE(character[1]); 
                            else 
                                o_dictionary_pass_gen_password[87:80] <= character[1]; 
                            if (character[2]  < 8'h7b && character[2]  > 8'h60) 
                                o_dictionary_pass_gen_password[79:72] <= UPPERCASE(character[2]);  
                            else 
                                o_dictionary_pass_gen_password[79:72] <= character[2]; 
                            if (character[3]  < 8'h7b && character[3]  > 8'h60) 
                                o_dictionary_pass_gen_password[71:64] <= UPPERCASE(character[3]);  
                            else 
                                o_dictionary_pass_gen_password[71:64] <= character[3]; 
                            if (character[4]  < 8'h7b && character[4]  > 8'h60) 
                                o_dictionary_pass_gen_password[63:56] <= UPPERCASE(character[4]);  
                            else 
                                o_dictionary_pass_gen_password[63:56] <= character[4]; 
                            if (character[5]  < 8'h7b && character[5]  > 8'h60) 
                                o_dictionary_pass_gen_password[55:48] <= UPPERCASE(character[5]);  
                            else 
                                o_dictionary_pass_gen_password[55:48] <= character[5]; 
                            if (character[6]  < 8'h7b && character[6]  > 8'h60) 
                                o_dictionary_pass_gen_password[47:40] <= UPPERCASE(character[6]);  
                            else 
                                o_dictionary_pass_gen_password[47:40] <= character[6]; 
                            if (character[7]  < 8'h7b && character[7]  > 8'h60) 
                                o_dictionary_pass_gen_password[39:32] <= UPPERCASE(character[7]);  
                            else 
                                o_dictionary_pass_gen_password[39:32] <= character[7]; 
                            if (character[8]  < 8'h7b && character[8]  > 8'h60) 
                                o_dictionary_pass_gen_password[31:24] <= UPPERCASE(character[8]);  
                            else 
                                o_dictionary_pass_gen_password[31:24] <= character[8]; 
                            if (character[9]  < 8'h7b && character[9]  > 8'h60) 
                                o_dictionary_pass_gen_password[23:16] <= UPPERCASE(character[9]);  
                            else 
                                o_dictionary_pass_gen_password[23:16] <= character[9]; 
                            if (character[10]  < 8'h7b && character[10]  > 8'h60) 
                                o_dictionary_pass_gen_password[15:8]  <= UPPERCASE(character[10]);  
                            else 
                                o_dictionary_pass_gen_password[15:8] <= character[10]; 
                            if (character[11]  < 8'h7b && character[11]  > 8'h60) 
                                o_dictionary_pass_gen_password[7:0]   <= UPPERCASE(character[11]);  
                            else 
                                o_dictionary_pass_gen_password[7:0] <= character[11]; 
                            
                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 7*/
                        // Duplicate the word: password -> passwordpassword
                        8'h64 : begin
                            if(pass_len <= 8'd48) begin
                                o_dictionary_pass_gen_password      <= pass_reg | (pass_reg >> pass_len);
                                o_dictionary_pass_gen_password_len  <= pass_len << 1;
                            end
                            else begin
                                o_dictionary_pass_gen_password      <= pass_reg;
                                o_dictionary_pass_gen_password_len  <= pass_len;
                            end
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 8*/
                        //Reflect: password -> passworddrowssap
                        8'h66 : begin
                            if ( pass_len <= 48) begin
                                o_dictionary_pass_gen_password      <= pass_reg | (REVERSE_BYTE(pass_reg) << ((48 - pass_len) << 1));
                                o_dictionary_pass_gen_password_len  <= pass_len << 1;
                            end 
                            else begin
                                o_dictionary_pass_gen_password      <= pass_reg;
                                o_dictionary_pass_gen_password_len  <= pass_len;
                            end
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 9*/
                        //Convert to lowercase
                        8'h6C : begin
                            if (character[0] < 8'h5b && character[0] > 8'h40) 
                                o_dictionary_pass_gen_password[95:88] <= LOWERCASE(character[0]); 
                            else 
                                o_dictionary_pass_gen_password[95:88] <= character[0]; 
                            if (character[1] < 8'h5b && character[1] > 8'h40) 
                                o_dictionary_pass_gen_password[87:80] <= LOWERCASE(character[1]); 
                            else 
                                o_dictionary_pass_gen_password[87:80] <= character[1]; 
                            if (character[2]  < 8'h5b && character[2]  > 8'h40) 
                                o_dictionary_pass_gen_password[79:72] <= LOWERCASE(character[2]);  
                            else 
                                o_dictionary_pass_gen_password[79:72] <= character[2]; 
                            if (character[3]  < 8'h5b && character[3]  > 8'h40) 
                                o_dictionary_pass_gen_password[71:64] <= LOWERCASE(character[3]);  
                            else 
                                o_dictionary_pass_gen_password[71:64] <= character[3]; 
                            if (character[4]  < 8'h5b && character[4]  > 8'h40) 
                                o_dictionary_pass_gen_password[63:56] <= LOWERCASE(character[4]);  
                            else 
                                o_dictionary_pass_gen_password[63:56] <= character[4]; 
                            if (character[5]  < 8'h5b && character[5]  > 8'h40) 
                                o_dictionary_pass_gen_password[55:48] <= LOWERCASE(character[5]);  
                            else 
                                o_dictionary_pass_gen_password[55:48] <= character[5]; 
                            if (character[6]  < 8'h5b && character[6]  > 8'h40) 
                                o_dictionary_pass_gen_password[47:40] <= LOWERCASE(character[6]);  
                            else 
                                o_dictionary_pass_gen_password[47:40] <= character[6]; 
                            if (character[7]  < 8'h5b && character[7]  > 8'h40) 
                                o_dictionary_pass_gen_password[39:32] <= LOWERCASE(character[7]);  
                            else 
                                o_dictionary_pass_gen_password[39:32] <= character[7]; 
                            if (character[8]  < 8'h5b && character[8]  > 8'h40) 
                                o_dictionary_pass_gen_password[31:24] <= LOWERCASE(character[8]);  
                            else 
                                o_dictionary_pass_gen_password[31:24] <= character[8]; 
                            if (character[9]  < 8'h5b && character[9]  > 8'h40) 
                                o_dictionary_pass_gen_password[23:16] <= LOWERCASE(character[9]);  
                            else 
                                o_dictionary_pass_gen_password[23:16] <= character[9]; 
                            if (character[10]  < 8'h5b && character[10]  > 8'h40) 
                                o_dictionary_pass_gen_password[15:8]  <= LOWERCASE(character[10]);  
                            else 
                                o_dictionary_pass_gen_password[15:8] <= character[10]; 
                            if (character[11]  < 8'h5b && character[11]  > 8'h40) 
                                o_dictionary_pass_gen_password[7:0]   <= LOWERCASE(character[11]);  
                            else 
                                o_dictionary_pass_gen_password[7:0] <= character[11]; 

                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 10*/
                        //Swap the last two characters: password -> passwodr
                        8'h4B : begin
                            if (pass_len >= 16) 
                                o_dictionary_pass_gen_password      <=  (pass_reg & (mask << (96 - pass_len + 16))) | 
                                                                        ({character[pass_len/8-1], character[pass_len/8-2]} << (96-pass_len));
                            else
                                o_dictionary_pass_gen_password      <= pass_reg;
                             
                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 11*/
                        //Duplicate all symbols: password -> ppaasssswwoorrdd
                        8'h71 : begin
                            if ( pass_len <= 48) begin
                                o_dictionary_pass_gen_password      <= {    character[0],character[0],
                                                                            character[1],character[1],
                                                                            character[2], character[2],
                                                                            character[3], character[3],
                                                                            character[4], character[4],
                                                                            character[5], character[5]};
                                o_dictionary_pass_gen_password_len  <= pass_len << 1;
                            end 
                            else begin
                                o_dictionary_pass_gen_password      <= pass_reg;
                                o_dictionary_pass_gen_password_len  <= pass_len;
                            end
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 12*/
                        //reverse
                        8'h72 : begin
                            o_dictionary_pass_gen_password          <= (REVERSE_BYTE(pass_reg) << (96 - pass_len));
                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 13*/
                        // Toggle case of all characters: PassWord -> pASSwORD
                        8'h74 : begin
                            if (character[0] < 8'h7b && character[0] > 8'h60) 
                                o_dictionary_pass_gen_password[95:88] <= UPPERCASE(character[0]); 
                            else if (character[0] < 8'h5b && character[0] > 8'h40)
                                o_dictionary_pass_gen_password[95:88] <= LOWERCASE(character[0]); 
                            else 
                                o_dictionary_pass_gen_password[95:88] <= character[11]; 
                            if (character[1] < 8'h7b && character[1] > 8'h60) 
                                o_dictionary_pass_gen_password[87:80] <= UPPERCASE(character[1]); 
                            else if (character[1] < 8'h5b && character[1] > 8'h40) 
                                o_dictionary_pass_gen_password[87:80] <= LOWERCASE(character[1]); 
                            else 
                                o_dictionary_pass_gen_password[87:80] <= character[1]; 
                            if (character[2]  < 8'h7b && character[2]  > 8'h60) 
                                o_dictionary_pass_gen_password[79:72] <= UPPERCASE(character[2]);  
                            else if (character[2]  < 8'h5b && character[2]  > 8'h40) 
                                o_dictionary_pass_gen_password[79:72] <= LOWERCASE(character[2]); 
                            else 
                                o_dictionary_pass_gen_password[79:72] <= character[2]; 
                            if (character[3]  < 8'h7b && character[3]  > 8'h60) 
                                o_dictionary_pass_gen_password[71:64] <= UPPERCASE(character[3]);  
                            else if (character[3]  < 8'h5b && character[3]  > 8'h40) 
                                o_dictionary_pass_gen_password[71:64] <= LOWERCASE(character[3]); 
                            else 
                                o_dictionary_pass_gen_password[71:64] <= character[3]; 
                            if (character[4]  < 8'h7b && character[4]  > 8'h60) 
                                o_dictionary_pass_gen_password[63:56] <= UPPERCASE(character[4]);  
                            else if (character[4]  < 8'h5b && character[4]  > 8'h40) 
                                o_dictionary_pass_gen_password[63:56] <= LOWERCASE(character[4]); 
                            else 
                                o_dictionary_pass_gen_password[63:56] <= character[4]; 
                            if (character[5]  < 8'h7b && character[5]  > 8'h60) 
                                o_dictionary_pass_gen_password[55:48] <= UPPERCASE(character[5]);  
                            else if (character[5]  < 8'h5b && character[5]  > 8'h40) 
                                o_dictionary_pass_gen_password[55:48] <= LOWERCASE(character[5]); 
                            else 
                                o_dictionary_pass_gen_password[55:48] <= character[5]; 
                            if (character[6]  < 8'h7b && character[6]  > 8'h60) 
                                o_dictionary_pass_gen_password[47:40] <= UPPERCASE(character[6]);  
                            else if (character[6]  < 8'h5b && character[6]  > 8'h40) 
                                o_dictionary_pass_gen_password[47:40] <= LOWERCASE(character[6]); 
                            else 
                                o_dictionary_pass_gen_password[47:40] <= character[6]; 
                            if (character[7]  < 8'h7b && character[7]  > 8'h60) 
                                o_dictionary_pass_gen_password[39:32] <= UPPERCASE(character[7]);  
                            else if (character[7]  < 8'h5b && character[7]  > 8'h40) 
                                o_dictionary_pass_gen_password[39:32] <= LOWERCASE(character[7]); 
                            else 
                                o_dictionary_pass_gen_password[39:32] <= character[7]; 
                            if (character[8]  < 8'h7b && character[8]  > 8'h60) 
                                o_dictionary_pass_gen_password[31:24] <= UPPERCASE(character[8]);  
                            else if (character[8]  < 8'h5b && character[8]  > 8'h40) 
                                o_dictionary_pass_gen_password[31:24] <= LOWERCASE(character[8]); 
                            else 
                                o_dictionary_pass_gen_password[31:24] <= character[8]; 
                            if (character[9]  < 8'h7b && character[9]  > 8'h60) 
                                o_dictionary_pass_gen_password[23:16] <= UPPERCASE(character[9]);  
                            else if (character[9]  < 8'h5b && character[9]  > 8'h40) 
                                o_dictionary_pass_gen_password[23:16] <= LOWERCASE(character[9]); 
                            else 
                                o_dictionary_pass_gen_password[23:16] <= character[9]; 
                            if (character[10]  < 8'h7b && character[10]  > 8'h60) 
                                o_dictionary_pass_gen_password[15:8]  <= UPPERCASE(character[10]);  
                            else if (character[10]  < 8'h5b && character[10]  > 8'h40) 
                                o_dictionary_pass_gen_password[15:8]  <= LOWERCASE(character[10]); 
                            else 
                                o_dictionary_pass_gen_password[15:8] <= character[10]; 
                            if (character[11]  < 8'h7b && character[11]  > 8'h60) 
                                o_dictionary_pass_gen_password[7:0]   <= UPPERCASE(character[11]);  
                            else if (character[11]  < 8'h5b && character[11]  > 8'h40) 
                                o_dictionary_pass_gen_password[7:0]   <= LOWERCASE(character[11]); 
                            else 
                                o_dictionary_pass_gen_password[7:0] <= character[11]; 

                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 14*/
                        //Convert to uppercase
                        8'h75 : begin
                            if (character[0] < 8'h7b && character[0] > 8'h60) 
                                o_dictionary_pass_gen_password[95:88] <= UPPERCASE(character[0]); 
                            else 
                                o_dictionary_pass_gen_password[95:88] <= character[0]; 
                            if (character[1] < 8'h7b && character[1] > 8'h60) 
                                o_dictionary_pass_gen_password[87:80] <= UPPERCASE(character[1]); 
                            else 
                                o_dictionary_pass_gen_password[87:80] <= character[1]; 
                            if (character[2]  < 8'h7b && character[2]  > 8'h60) 
                                o_dictionary_pass_gen_password[79:72] <= UPPERCASE(character[2]);  
                            else 
                                o_dictionary_pass_gen_password[79:72] <= character[2]; 
                            if (character[3]  < 8'h7b && character[3]  > 8'h60) 
                                o_dictionary_pass_gen_password[71:64] <= UPPERCASE(character[3]);  
                            else 
                                o_dictionary_pass_gen_password[71:64] <= character[3]; 
                            if (character[4]  < 8'h7b && character[4]  > 8'h60) 
                                o_dictionary_pass_gen_password[63:56] <= UPPERCASE(character[4]);  
                            else 
                                o_dictionary_pass_gen_password[63:56] <= character[4]; 
                            if (character[5]  < 8'h7b && character[5]  > 8'h60) 
                                o_dictionary_pass_gen_password[55:48] <= UPPERCASE(character[5]);  
                            else 
                                o_dictionary_pass_gen_password[55:48] <= character[5]; 
                            if (character[6]  < 8'h7b && character[6]  > 8'h60) 
                                o_dictionary_pass_gen_password[47:40] <= UPPERCASE(character[6]);  
                            else 
                                o_dictionary_pass_gen_password[47:40] <= character[6]; 
                            if (character[7]  < 8'h7b && character[7]  > 8'h60) 
                                o_dictionary_pass_gen_password[39:32] <= UPPERCASE(character[7]);  
                            else 
                                o_dictionary_pass_gen_password[39:32] <= character[7]; 
                            if (character[8]  < 8'h7b && character[8]  > 8'h60) 
                                o_dictionary_pass_gen_password[31:24] <= UPPERCASE(character[8]);  
                            else 
                                o_dictionary_pass_gen_password[31:24] <= character[8]; 
                            if (character[9]  < 8'h7b && character[9]  > 8'h60) 
                                o_dictionary_pass_gen_password[23:16] <= UPPERCASE(character[9]); 
                            else 
                                o_dictionary_pass_gen_password[23:16] <= character[9]; 
                            if (character[10]  < 8'h7b && character[10]  > 8'h60) 
                                o_dictionary_pass_gen_password[15:8]  <= UPPERCASE(character[10]);  
                            else 
                                o_dictionary_pass_gen_password[15:8] <= character[10]; 
                            if (character[11]  < 8'h7b && character[11]  > 8'h60) 
                                o_dictionary_pass_gen_password[7:0]  <= UPPERCASE(character[11]);  
                            else 
                                o_dictionary_pass_gen_password[7:0]  <= character[11]; 

                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 15*/
                        //Truncate the word to N character(s) length
                        8'h27 : begin
                            if(pass_len >=(value_1_int<<3) && value_1_int > 0) begin
                                o_dictionary_pass_gen_password      <= pass_reg &( mask << (96-(value_1_int << 3)));
                                o_dictionary_pass_gen_password_len  <= value_1_int << 3;
                            end
                            else begin
                                o_dictionary_pass_gen_password      <= pass_reg;
                                o_dictionary_pass_gen_password_len  <= pass_len;
                            end
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 16*/
                        //Reject the word if it is greater than N characters long. 
                        8'h3C : begin
                            if(pass_len >(value_1_int<<3)) 
                                o_dictionary_pass_gen_valid         <= 1'b0;
                            o_dictionary_pass_gen_password          <= pass_reg;
                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 17*/
                        // Reject the word if it is less than N characters long. 
                        8'h3E : begin
                            if(pass_len <(value_1_int<<3))   
                                o_dictionary_pass_gen_valid         <= 1'b0;
                            o_dictionary_pass_gen_password          <= pass_reg;
                            o_dictionary_pass_gen_password_len      <= pass_len;
                            o_dictionary_pass_gen_done              <= 1'b1;
                            passwodr_generate_state                 <= IDLE;
                        end /*RULE 18*/
                        //Increment character at position N by 1 ASCII value
                        8'h2B : begin
                            if(pass_len >(value_1_int<<3)) begin
                                case (scan_password_state)
                                    PREPARE: begin
                                        character[value_1_int]              <= character[value_1_int] + 1'b1;
                                        scan_password_state                 <= PROCESS;
                                    end
                                    PROCESS: begin
                                        o_dictionary_pass_gen_password      <= {character[0],
                                                                                character[1],
                                                                                character[2],
                                                                                character[3],
                                                                                character[4],
                                                                                character[5],
                                                                                character[6],
                                                                                character[7],
                                                                                character[8],
                                                                                character[9],
                                                                                character[10],
                                                                                character[11]
                                                                                };
                                        o_dictionary_pass_gen_password_len  <= pass_len;
                                        o_dictionary_pass_gen_done          <= 1'b1;
                                        scan_password_state                 <= PREPARE;
                                        passwodr_generate_state             <= IDLE;
                                    end
                                endcase /*scan_password_state*/
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len;
                                o_dictionary_pass_gen_done                  <= 1'b1;
                                passwodr_generate_state                     <= IDLE;
                            end
                            
                        end /*RULE 19*/
                        //Decrement character at position N by 1 ASCII value
                        8'h2D : begin
                            if(pass_len >(value_1_int<<3)) begin
                                case (scan_password_state)
                                    PREPARE: begin
                                        character[value_1_int]              <= character[value_1_int] - 1'b1;
                                        scan_password_state                 <= PROCESS;
                                    end
                                    PROCESS: begin
                                        o_dictionary_pass_gen_password      <= {character[0],
                                                                                character[1],
                                                                                character[2],
                                                                                character[3],
                                                                                character[4],
                                                                                character[5],
                                                                                character[6],
                                                                                character[7],
                                                                                character[8],
                                                                                character[9],
                                                                                character[10],
                                                                                character[11]
                                                                                };
                                        o_dictionary_pass_gen_password_len  <= pass_len;
                                        o_dictionary_pass_gen_done          <= 1'b1;
                                        scan_password_state                 <= PREPARE;
                                        passwodr_generate_state             <= IDLE;
                                    end
                                endcase /*scan_password_state*/
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len;
                                o_dictionary_pass_gen_done                  <= 1'b1;
                                passwodr_generate_state                     <= IDLE;
                            end
                        end /*RULE 20*/
                        // Replace character at position N with one at position N+1
                        8'h2E : begin
                            if(pass_len > (value_1_int+1)<<3) begin
                                case (scan_password_state)
                                    PREPARE: begin
                                        character[value_1_int]              <= character[value_1_int+1];
                                        scan_password_state                 <= PROCESS;
                                    end
                                    PROCESS: begin
                                        o_dictionary_pass_gen_password      <= {character[0],
                                                                                character[1],
                                                                                character[2],
                                                                                character[3],
                                                                                character[4],
                                                                                character[5],
                                                                                character[6],
                                                                                character[7],
                                                                                character[8],
                                                                                character[9],
                                                                                character[10],
                                                                                character[11]
                                                                                };
                                        o_dictionary_pass_gen_password_len  <= pass_len;
                                        o_dictionary_pass_gen_done          <= 1'b1;
                                        scan_password_state                 <= PREPARE;
                                        passwodr_generate_state             <= IDLE;
                                    end
                                endcase /*scan_password_state*/
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len;
                                o_dictionary_pass_gen_done                  <= 1'b1;
                                passwodr_generate_state                     <= IDLE;
                            end
                        end /*RULE 21*/
                        // Replace character at position N with one at position N-1
                        8'h2C : begin
                            if(value_1_int > 0 && value_1_int <= pass_len/8) begin
                                case (scan_password_state)
                                    PREPARE: begin
                                        character[value_1_int]              <= character[value_1_int-1];
                                        scan_password_state                 <= PROCESS;
                                    end
                                    PROCESS: begin
                                        o_dictionary_pass_gen_password      <= {character[0],
                                                                                character[1],
                                                                                character[2],
                                                                                character[3],
                                                                                character[4],
                                                                                character[5],
                                                                                character[6],
                                                                                character[7],
                                                                                character[8],
                                                                                character[9],
                                                                                character[10],
                                                                                character[11]
                                                                                };
                                        o_dictionary_pass_gen_password_len  <= pass_len;
                                        o_dictionary_pass_gen_done          <= 1'b1;
                                        scan_password_state                 <= PREPARE;
                                        passwodr_generate_state             <= IDLE;
                                    end
                                endcase /*scan_password_state*/
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len;
                                o_dictionary_pass_gen_done                  <= 1'b1;
                                passwodr_generate_state                     <= IDLE;
                            end
                        end /*RULE 22*/
                        //Delete the character at position N
                        8'h44 : begin
                            if (pass_len >(value_1_int<<3) && pass_len > 8) begin
                                o_dictionary_pass_gen_password              <= pass_reg & (mask << (96-8*value_1_int)) | (pass_reg << 8) & (mask >> 8*value_1_int);
                                o_dictionary_pass_gen_password_len          <= pass_len - 8;
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len;
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 23*/
                        // Copy the word N times. N <= 3 .. 9
                        8'h70 : begin
                            if ((pass_len*value_1_int) <= 96  && value_1_int > 1) begin
                                case (pass_len)
                                    8'd8: begin
                                        o_dictionary_pass_gen_password      <= {96{character[0]}} &( mask << (96-(value_1_int << 3)));
                                        o_dictionary_pass_gen_password_len  <= pass_len*value_1_int;
                                    end
                                    8'd16 : begin
                                        o_dictionary_pass_gen_password      <= {96{character[0], character[1]}} & (mask << (96-(pass_len*value_1_int)));
                                        o_dictionary_pass_gen_password_len  <= pass_len*value_1_int;
                                    end
                                    8'd24 : begin
                                        o_dictionary_pass_gen_password      <= {96{character[0], character[1], character[2]}} & (mask << (96-(pass_len*value_1_int)));
                                        o_dictionary_pass_gen_password_len  <= pass_len*value_1_int;
                                    end
                                    8'd32 : begin
                                        o_dictionary_pass_gen_password      <= {96{character[0], character[1], character[2], character[3]}}& (mask << (96-(pass_len*value_1_int)));
                                        o_dictionary_pass_gen_password_len  <= pass_len*value_1_int;
                                    end
                                    default: ;
                                endcase 
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len; 
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 24*/
                        //Toggle case of the character at position N. 
                        8'h54 : begin
                            if(pass_len >(value_1_int<<3)) begin
                                case (scan_password_state)
                                    PREPARE: begin
                                        if (character[value_1_int] < 8'h7b && character[value_1_int] > 8'h60) 
                                            character[value_1_int] <= UPPERCASE(character[value_1_int]); 
                                        else if (character[value_1_int] < 8'h5b && character[value_1_int] > 8'h40) 
                                            character[value_1_int] <= LOWERCASE(character[value_1_int]); 
                                        else 
                                            character[value_1_int] <= character[value_1_int];

                                        scan_password_state                 <= PROCESS;
                                    end
                                    PROCESS: begin
                                        o_dictionary_pass_gen_password      <= {character[0],
                                                                                character[1],
                                                                                character[2],
                                                                                character[3],
                                                                                character[4],
                                                                                character[5],
                                                                                character[6],
                                                                                character[7],
                                                                                character[8],
                                                                                character[9],
                                                                                character[10],
                                                                                character[11]
                                                                                };
                                        o_dictionary_pass_gen_password_len  <= pass_len;
                                        o_dictionary_pass_gen_done          <= 1'b1;
                                        scan_password_state                 <= PREPARE;
                                        passwodr_generate_state             <= IDLE;
                                    end
                                endcase /*scan_password_state*/
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len;
                                o_dictionary_pass_gen_done                  <= 1'b1;
                                passwodr_generate_state                     <= IDLE;    
                            end 
                            
                        end /*RULE 25*/
                        // Duplicate first N characters
                        8'h79 : begin
                            if (pass_len >= (value_1_int<<3) && (pass_len + (value_1_int<<3)) <= 96  && value_1_int > 0) begin
                                o_dictionary_pass_gen_password              <=  (pass_reg >> (value_1_int<<3)) | 
                                                                                (pass_reg & (mask << (96-((value_1_int<<3)))));
                                o_dictionary_pass_gen_password_len          <= pass_len + (value_1_int<<3);
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len; 
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end  /*RULE 26*/
                        //Duplicate last N characters 
                        8'h59 : begin
                            if (pass_len >= (value_1_int<<3) && (pass_len + (value_1_int<<3)) <= 96  && value_1_int > 0) begin
                                o_dictionary_pass_gen_password              <= pass_reg | ((pass_reg >> (value_1_int<<3)) & (mask >> pass_len)) ;
                                o_dictionary_pass_gen_password_len          <= pass_len + (value_1_int<<3); 
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len; 
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 27*/
                        //Duplicate the first character of the word N times. N <= 1 .. 9
                        8'h7A : begin
                            if ((pass_len + (value_1_int << 3)) <= 96 && value_1_int > 0) begin
                                o_dictionary_pass_gen_password              <= {96{character[0]}} & 
                                                                                (mask << (96 -(value_1_int<<3))) | 
                                                                                ((pass_reg >> (value_1_int<<3)));
                                o_dictionary_pass_gen_password_len          <= pass_len + (value_1_int << 3);
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len; 
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 28*/
                        //Duplicate the last character of the word N times. N <= 1 .. 9
                        8'h5A : begin
                            if ((pass_len + (value_1_int << 3)) <= 96  && value_1_int > 0 ) begin
                                o_dictionary_pass_gen_password              <=  pass_reg | 
                                                                                {96{character[(pass_len/8)-1]}} & 
                                                                                (mask >> pass_len) & 
                                                                                (mask << (96 - pass_len -(value_1_int<<3) ));
                                o_dictionary_pass_gen_password_len          <= pass_len + (value_1_int << 3); 
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len; 
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 29*/
                        // Add character X to the end of the word
                        8'h24: begin
                            if (pass_len < 96) begin
                                o_dictionary_pass_gen_password              <= pass_reg | (value_1 << (88 - pass_len));
                                o_dictionary_pass_gen_password_len          <= pass_len + 8;  
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len;
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;

                        end /*RULE 30*/
                        //Insert character X at the beginning of the word
                        8'h5E: begin
                            if (pass_len < 96) begin
                                o_dictionary_pass_gen_password              <= {value_1, 88'h0} | (pass_reg >> 8);
                                o_dictionary_pass_gen_password_len          <= pass_len + 8; 
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len; 
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 31*/
                        //Remove all characters X from the word
                        8'h40: begin
                            case (scan_password_state)
                                PREPARE: begin
                                    counter                                 <= 4'h0;
                                    char_loc                                <= 4'h0;
                                    scan_password_state                     <= PROCESS;
                                end
                                PROCESS: begin
                                    if ( char_loc == 12 || character[char_loc] == 0) begin
                                        o_dictionary_pass_gen_password      <= pass_reg;
                                        o_dictionary_pass_gen_password_len  <= pass_len; 
                                        o_dictionary_pass_gen_done          <= 1'b1;
                                        scan_password_state                 <= PREPARE;
                                        passwodr_generate_state             <= IDLE;
                                    end
                                    else begin
                                        if (character[char_loc] == value_1) begin
                                            pass_len                        <= pass_len - 8; 
                                            case (counter)
                                                4'd0 : begin
                                                    pass_reg[95:0]          <= {pass_reg[87:0], 8'h0};
                                                end
                                                4'd1 : begin
                                                    pass_reg[95:88]         <= pass_reg[95:88];
                                                    pass_reg[87:0]          <= {pass_reg[79:0], 8'h0};
                                                end
                                                4'd2 : begin
                                                    pass_reg[95:80]         <= pass_reg[95:80];
                                                    pass_reg[79:0]          <= {pass_reg[71:0], 8'h0};
                                                end
                                                4'd3 : begin
                                                    pass_reg[95:72]         <= pass_reg[95:72];
                                                    pass_reg[71:0]          <= {pass_reg[63:0], 8'h0};
                                                end
                                                4'd4 : begin
                                                    pass_reg[95:64]         <= pass_reg[95:64];
                                                    pass_reg[63:0]          <= {pass_reg[55:0], 8'h0};
                                                end
                                                4'd5 : begin
                                                    pass_reg[95:56]         <= pass_reg[95:56];
                                                    pass_reg[55:0]          <= {pass_reg[47:0], 8'h0};
                                                end
                                                4'd6 : begin
                                                    pass_reg[95:48]         <= pass_reg[95:48];
                                                    pass_reg[47:0]          <= {pass_reg[39:0], 8'h0};
                                                end
                                                4'd7 : begin
                                                    pass_reg[95:40]         <= pass_reg[95:40];
                                                    pass_reg[39:0]          <= {pass_reg[31:0], 8'h0};
                                                end
                                                4'd8 : begin
                                                    pass_reg[95:32]         <= pass_reg[95:32];
                                                    pass_reg[31:0]          <= {pass_reg[23:0], 8'h0};
                                                end
                                                4'd9 : begin
                                                    pass_reg[95:24]         <= pass_reg[95:24];
                                                    pass_reg[23:0]          <= {pass_reg[15:0], 8'h0};
                                                end
                                                4'd10 : begin
                                                    pass_reg[95:16]         <= pass_reg[95:16];
                                                    pass_reg[15:0]          <= {pass_reg[7:0], 8'h0};
                                                end
                                                4'd11 : begin
                                                    pass_reg[95:8]          <= pass_reg[95:8];
                                                    pass_reg[7:0]           <=  8'h0;
                                                end
                                                default: ;
                                            endcase
                                        end
                                        else 
                                            counter                         <= counter + 1'b1;

                                        char_loc                            <= char_loc + 1'b1;
                                    end
                                end /*PROCESS*/
                            endcase /*scan_password_state*/
                        end /*RULE 32*/
                        //Reject the word if it contains at least one character X
                        8'h21: begin
                            if (
                                character[0]  == value_1 ||
                                character[1]  == value_1 ||
                                character[2]  == value_1 ||
                                character[3]  == value_1 ||
                                character[4]  == value_1 ||
                                character[5]  == value_1 ||
                                character[6]  == value_1 ||
                                character[7]  == value_1 ||
                                character[8]  == value_1 ||
                                character[9]  == value_1 ||
                                character[10] == value_1 ||
                                character[11] == value_1
                            )
                                o_dictionary_pass_gen_valid                 <= 1'b0;

                            o_dictionary_pass_gen_password                  <= pass_reg;
                            o_dictionary_pass_gen_password_len              <= pass_len;
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 33*/
                        //Reject the word if it does not contain character X
                        8'h2F: begin
                            if (
                                character[0]  != value_1 &&
                                character[1]  != value_1 &&
                                character[2]  != value_1 &&
                                character[3]  != value_1 &&
                                character[4]  != value_1 &&
                                character[5]  != value_1 &&
                                character[6]  != value_1 &&
                                character[7]  != value_1 &&
                                character[8]  != value_1 &&
                                character[9]  != value_1 &&
                                character[10] != value_1 &&
                                character[11] != value_1
                            )
                                o_dictionary_pass_gen_valid                 <= 1'b0;

                            o_dictionary_pass_gen_password                  <= pass_reg;
                            o_dictionary_pass_gen_password_len              <= pass_len;
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 34*/
                        //Reject the word if the first character is not X
                        8'h28: begin
                            if (character[0] != value_1)
                                o_dictionary_pass_gen_valid                 <= 1'b0;

                            o_dictionary_pass_gen_password                  <= pass_reg;
                            o_dictionary_pass_gen_password_len              <= pass_len;
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 35*/
                        //Reject the word if the last character is not X
                        8'h29: begin
                            if (character[pass_len/8-1] != value_1)
                                o_dictionary_pass_gen_valid                 <= 1'b0;

                            o_dictionary_pass_gen_password                  <= pass_reg;
                            o_dictionary_pass_gen_password_len              <= pass_len;
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 36*/
                        //Reject the word if it does not contain at least M instances of the character X
                        8'h25: begin
                            case (scan_password_state)
                                PREPARE: begin
                                    char_loc                                <= 4'h0;
                                    counter                                 <= 4'h0;
                                    scan_password_state                     <= PROCESS;
                                end
                                PROCESS: begin
                                    if ( char_loc == 12 || character[char_loc] == 0) begin
                                        o_dictionary_pass_gen_password      <= pass_reg;
                                        o_dictionary_pass_gen_password_len  <= pass_len; 
                                        if (counter < value_2_int)
                                            o_dictionary_pass_gen_valid     <= 1'b0;

                                        o_dictionary_pass_gen_done          <= 1'b1;
                                        scan_password_state                 <= PREPARE;
                                        passwodr_generate_state             <= IDLE;
                                    end
                                    else begin
                                        if (character[char_loc] == value_1) 
                                            counter                         <= counter + 1'b1;

                                        char_loc                            <= char_loc + 1;
                                    end
                                end
                            endcase /*scan_password_state*/
                        end /*RULE 37*/
                        //Reject the word if the character at position N is not equal to X
                        8'h3D: begin
                            o_dictionary_pass_gen_password                  <= pass_reg;
                            o_dictionary_pass_gen_password_len              <= pass_len;
                            if(character[value_2_int] != value_1)
                                o_dictionary_pass_gen_valid                 <= 1'b0;

                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 38*/
                        //Insert the character X in position N
                        8'h69: begin
                            if (value_2_int <= pass_len/8) begin
                                o_dictionary_pass_gen_password              <=  pass_reg & (mask << (96-8*value_2_int)) | 
                                                                                value_1 << (88 - 8*value_2_int) | 
                                                                                (pass_reg >> 8) & (mask >> 8*value_2_int + 8);
                                o_dictionary_pass_gen_password_len          <= pass_len + 8;
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len;
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 39*/
                        //Overwrite a character in position N with the character X
                        8'h6F: begin
                            if (value_2_int <= pass_len/8) begin
                                o_dictionary_pass_gen_password              <=  pass_reg & (mask << (96-8*value_2_int)) | 
                                                                                value_1 << (88 - 8*value_2_int) | 
                                                                                (pass_reg) & (mask >> 8*value_2_int + 8);
                                o_dictionary_pass_gen_password_len          <= pass_len;
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len;
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 40*/
                        //Replace all characters X with Y
                        8'h73: begin
                            case (scan_password_state)
                                PREPARE: begin
                                    if(character[0]  == value_2) character[0]  <= value_1;
                                    if(character[1]  == value_2) character[1]  <= value_1;
                                    if(character[2]  == value_2) character[2]  <= value_1;
                                    if(character[3]  == value_2) character[3]  <= value_1;
                                    if(character[4]  == value_2) character[4]  <= value_1;
                                    if(character[5]  == value_2) character[5]  <= value_1;
                                    if(character[6]  == value_2) character[6]  <= value_1;
                                    if(character[7]  == value_2) character[7]  <= value_1;
                                    if(character[8]  == value_2) character[8]  <= value_1;
                                    if(character[9]  == value_2) character[9]  <= value_1;
                                    if(character[10] == value_2) character[10] <= value_1;
                                    if(character[11] == value_2) character[11] <= value_1;
                                    scan_password_state                     <= PROCESS;
                                end
                                PROCESS: begin
                                    o_dictionary_pass_gen_password          <= {character[0],
                                                                                character[1],
                                                                                character[2],
                                                                                character[3],
                                                                                character[4],
                                                                                character[5],
                                                                                character[6],
                                                                                character[7],
                                                                                character[8],
                                                                                character[9],
                                                                                character[10],
                                                                                character[11]
                                                                                };
                                    o_dictionary_pass_gen_password_len      <= pass_len;
                                    o_dictionary_pass_gen_done              <= 1'b1;
                                    scan_password_state                     <= PREPARE;
                                    passwodr_generate_state                 <= IDLE;
                                end
                            endcase /*scan_password_state*/
                        end /*RULE 41*/
                        //Extract a substring of up to M characters length, starting from position N
                        8'h78: begin
                            if((value_1_int + value_2_int)*8 <= pass_len && value_1_int > 0) begin
                                o_dictionary_pass_gen_password              <= (pass_reg <<(value_2_int<<3)) & (mask << (96-value_1_int<<3));
                                o_dictionary_pass_gen_password_len          <=(value_1_int<<3);
                            end
                            else begin
                                o_dictionary_pass_gen_password              <= pass_reg;
                                o_dictionary_pass_gen_password_len          <= pass_len;
                            end
                            o_dictionary_pass_gen_done                      <= 1'b1;
                            passwodr_generate_state                         <= IDLE;
                        end /*RULE 42*/
                        //convert int to string
                        8'h4E: begin
                            case (scan_password_state)
                                PREPARE: begin
                                    counter                                 <= 4'h0;
                                    char_loc                                <= 4'h0;
                                    scan_password_state                     <= PROCESS;
                                end
                                PROCESS: begin
                                    if ( char_loc == 12 || character[char_loc] == 0) begin
                                        o_dictionary_pass_gen_password      <= pass_reg;
                                        o_dictionary_pass_gen_password_len  <= pass_len;
                                        o_dictionary_pass_gen_done          <= 1'b1;
                                        scan_password_state                 <= PREPARE;
                                        passwodr_generate_state             <= IDLE;
                                    end
                                    else begin
                                        if (character[char_loc] == value_1) begin
                                            case (value_1)
                                                8'h30: begin //0 -> "khong"
                                                    if (pass_len + 32 <= 96) begin
                                                        pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                            (40'h6B686F6E67) << (56-8*counter) | 
                                                                            (pass_reg >> 32) & (mask >> 8*counter+40);
                                                        pass_len        <= pass_len + 32;
                                                        counter         <= counter +  8'd5;
                                                    end
                                                end /*"0"*/
                                                8'h31: begin //1 -> "mot"
                                                    if (pass_len + 16 <= 96) begin
                                                        pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                            (24'h6D6F74) << (72-8*counter) | 
                                                                            (pass_reg >> 16) & (mask >> 8*counter+24);
                                                        pass_len        <= pass_len + 16;
                                                        counter         <= counter +  8'd3;
                                                    end
                                                end /*"1"*/
                                                8'h32: begin //2 -> "hai"
                                                    if (pass_len + 16 <= 96) begin
                                                        pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                            (24'h686169) << (72-8*counter) | 
                                                                            (pass_reg >> 16) & (mask >> 8*counter+24);
                                                        pass_len        <= pass_len + 16;
                                                        counter         <= counter +  8'd3;
                                                    end
                                                end /*"2"*/
                                                8'h33: begin //3 -> "ba"
                                                    if (pass_len + 8 <= 96) begin
                                                        pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                            (16'h6261) << (80-8*counter) | 
                                                                            (pass_reg >> 8) & (mask >> 8*counter+16);
                                                        pass_len        <= pass_len + 8;
                                                        counter         <= counter +  8'd2;
                                                    end
                                                end /*"3"*/
                                                8'h34: begin //4 -> "bon"
                                                    if (pass_len + 16 <= 96) begin
                                                        pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                            (24'h626F6E) << (72-8*counter) | 
                                                                            (pass_reg >> 16) & (mask >> 8*counter+24);
                                                        pass_len        <= pass_len + 16;
                                                        counter         <= counter +  8'd3;
                                                    end
                                                end /*"4"*/
                                                8'h35: begin //5 -> "nam"
                                                    if (pass_len + 16 <= 96) begin
                                                        pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                            (24'h6E616D) << (72-8*counter) | 
                                                                            (pass_reg >> 16) & (mask >> 8*counter+24);
                                                        pass_len        <= pass_len + 16;
                                                        counter         <= counter +  8'd3;
                                                    end
                                                end /*"5"*/
                                                8'h36: begin //6 -> "sau"
                                                    if (pass_len + 16 <= 96) begin
                                                        pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                            (24'h736175) << (72-8*counter) | 
                                                                            (pass_reg >> 16) & (mask >> 8*counter+24);
                                                        pass_len        <= pass_len + 16;
                                                        counter         <= counter +  8'd3;
                                                    end
                                                end /*"6"*/
                                                8'h37: begin //7 -> "bay"
                                                    if (pass_len + 16 <= 96) begin
                                                        pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                            (24'h626179) << (72-8*counter) | 
                                                                            (pass_reg >> 16) & (mask >> 8*counter+24);
                                                        pass_len        <= pass_len + 16;
                                                        counter         <= counter +  8'd3;
                                                    end
                                                end /*"7"*/
                                                8'h38: begin //8 -> "tam"
                                                    if (pass_len + 16 <= 96) begin
                                                        pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                            (24'h74616D) << (72-8*counter) | 
                                                                            (pass_reg >> 16) & (mask >> 8*counter+24);
                                                        pass_len        <= pass_len + 16;
                                                        counter         <= counter +  8'd3;
                                                    end
                                                end /*"8"*/
                                                8'h39: begin //9 -> "chin"
                                                    if (pass_len + 24 <= 96) begin
                                                        pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                            (32'h6368696E) << (64-8*counter) | 
                                                                            (pass_reg >> 24) & (mask >> 8*counter+32);
                                                        pass_len        <= pass_len + 24;
                                                        counter         <= counter +  8'd4;
                                                    end
                                                end /*"9"*/
                                                default: ;
                                            endcase /*DIGIT*/
                                        end 
                                        else 
                                            counter <= counter +  1'b1;

                                        char_loc <= char_loc + 1'b1;
                                    end
                                end /*PROCESS*/
                            endcase /*scan_password_state*/
                        end /*RULE 43*/
                        //convert string to int
                        8'h6E : begin
                            case (scan_password_state)
                                PREPARE: begin
                                    counter                                 <= 4'h0;
                                    char_loc                                <= 4'h0;
                                    scan_password_state                     <= PROCESS;
                                end
                                PROCESS: begin
                                    case (value_1)
                                        8'h30: begin //"khong" -> 0
                                            if ( char_loc >= 8 || character[char_loc] == 0) begin
                                                o_dictionary_pass_gen_password      <= pass_reg;
                                                o_dictionary_pass_gen_password_len  <= pass_len;
                                                o_dictionary_pass_gen_done          <= 1'b1;
                                                scan_password_state                 <= PREPARE;
                                                passwodr_generate_state             <= IDLE;
                                            end
                                            else  begin 
                                                if ((character[char_loc]   == 8'h6B || character[char_loc]   == 8'h4B) &&       //"k"
                                                    (character[char_loc+1] == 8'h68 || character[char_loc]   == 8'h4B) &&       //"h"
                                                    (character[char_loc+2] == 8'h6F || character[char_loc+2] == 8'h4F) &&       //"o"
                                                    (character[char_loc+3] == 8'h6E || character[char_loc+3] == 8'h4E) &&       //"n"
                                                    (character[char_loc+4] == 8'h67 || character[char_loc+4] == 8'h47)          //"g"
                                                    ) begin
                                                    pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                        (8'h30) << (88-8*counter) | 
                                                                        (pass_reg << 32) & (mask >> 8*counter+8);
                                                    pass_len        <= pass_len - 32;
                                                    char_loc        <= char_loc + 8'd5; 
                                                end
                                                else 
                                                    char_loc        <= char_loc + 1'b1;
                                            end
                                        end /*"0"*/
                                        8'h31: begin //"mot" -> 1
                                            if ( char_loc >= 10 || character[char_loc] == 0) begin
                                                o_dictionary_pass_gen_password      <= pass_reg;
                                                o_dictionary_pass_gen_password_len  <= pass_len;
                                                o_dictionary_pass_gen_done          <= 1'b1;
                                                scan_password_state                 <= PREPARE;
                                                passwodr_generate_state             <= IDLE;
                                            end
                                            else  begin 
                                                if ((character[char_loc]   == 8'h6D || character[char_loc]   == 8'h4D) &&       //"m"
                                                    (character[char_loc+1] == 8'h6F || character[char_loc+1] == 8'h4F) &&       //"o"
                                                    (character[char_loc+2] == 8'h74 || character[char_loc+2] == 8'h54)         //"t"
                                                    ) begin
                                                    pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                        (8'h31) << (88-8*counter) | 
                                                                        (pass_reg << 16) & (mask >> 8*counter+8);
                                                    pass_len        <= pass_len - 16; 
                                                    char_loc        <= char_loc + 8'd3; 
                                                end
                                                else 
                                                    char_loc        <= char_loc + 1'b1;
                                            end
                                        end /*"1"*/
                                        8'h32: begin //"hai" -> 2
                                            if ( char_loc >= 10 || character[char_loc] == 0) begin
                                                o_dictionary_pass_gen_password      <= pass_reg;
                                                o_dictionary_pass_gen_password_len  <= pass_len;
                                                o_dictionary_pass_gen_done          <= 1'b1;
                                                scan_password_state                 <= PREPARE;
                                                passwodr_generate_state             <= IDLE;
                                            end
                                            else  begin 
                                                if ((character[char_loc]   == 8'h68 || character[char_loc]   == 8'h48) &&       //"h"
                                                    (character[char_loc+1] == 8'h61 || character[char_loc+1] == 8'h41) &&       //"a"
                                                    (character[char_loc+2] == 8'h69 || character[char_loc+2] == 8'h49)          //"i"
                                                    ) begin
                                                    pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                        (8'h32) << (88-8*counter) | 
                                                                        (pass_reg << 16) & (mask >> 8*counter+8);
                                                    pass_len        <= pass_len - 16; 
                                                    char_loc        <= char_loc + 8'd3; 
                                                end
                                                else 
                                                    char_loc        <= char_loc + 1'b1;
                                            end
                                        end /*"2"*/
                                        8'h33: begin //"ba"  -> 3
                                            if ( char_loc >= 11 || character[char_loc] == 0) begin
                                                o_dictionary_pass_gen_password      <= pass_reg;
                                                o_dictionary_pass_gen_password_len  <= pass_len;
                                                o_dictionary_pass_gen_done          <= 1'b1;
                                                scan_password_state                 <= PREPARE;
                                                passwodr_generate_state             <= IDLE;
                                            end
                                            else  begin 
                                                if ((character[char_loc]   == 8'h62 || character[char_loc]   == 8'h42) &&       //"b"
                                                    (character[char_loc+1] == 8'h61 || character[char_loc+1] == 8'h41)          //"a"
                                                    ) begin
                                                    pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                        (8'h33) << (88-8*counter) | 
                                                                        (pass_reg << 8) & (mask >> 8*counter+8);
                                                    pass_len        <= pass_len - 8; 
                                                    char_loc        <= char_loc + 8'd2; 
                                                end
                                                else 
                                                    char_loc        <= char_loc + 1'b1;
                                            end
                                        end /*"3"*/
                                        8'h34: begin //"bon"  ->  4
                                            if ( char_loc >= 10 || character[char_loc] == 0) begin
                                                o_dictionary_pass_gen_password      <= pass_reg;
                                                o_dictionary_pass_gen_password_len  <= pass_len;
                                                o_dictionary_pass_gen_done          <= 1'b1;
                                                scan_password_state                 <= PREPARE;
                                                passwodr_generate_state             <= IDLE;
                                            end
                                            else  begin 
                                                if ((character[char_loc]   == 8'h62 || character[char_loc]   == 8'h42) &&       //"b"
                                                    (character[char_loc+1] == 8'h6F || character[char_loc+1] == 8'h4F) &&       //"o"
                                                    (character[char_loc+2] == 8'h6E || character[char_loc+2] == 8'h4E)          //"n"
                                                    ) begin
                                                    pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                        (8'h34) << (88-8*counter) | 
                                                                        (pass_reg << 16) & (mask >> 8*counter+8);
                                                    pass_len        <= pass_len - 16; 
                                                    char_loc        <= char_loc + 8'd3; 
                                                end
                                                else 
                                                    char_loc        <= char_loc + 1'b1;
                                            end
                                        end /*"4"*/
                                        8'h35: begin //"nam"  -> 5
                                            if ( char_loc >= 10 || character[char_loc] == 0) begin
                                                o_dictionary_pass_gen_password      <= pass_reg;
                                                o_dictionary_pass_gen_password_len  <= pass_len;
                                                o_dictionary_pass_gen_done          <= 1'b1;
                                                scan_password_state                 <= PREPARE;
                                                passwodr_generate_state             <= IDLE;
                                            end
                                            else  begin 
                                                if ((character[char_loc]   == 8'h6E || character[char_loc]   == 8'h4E) &&       //"n"
                                                    (character[char_loc+1] == 8'h61 || character[char_loc+1] == 8'h41) &&       //"a"
                                                    (character[char_loc+2] == 8'h6D || character[char_loc+2] == 8'h4D)          //"m"
                                                    ) begin
                                                    pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                        (8'h35) << (88-8*counter) | 
                                                                        (pass_reg << 16) & (mask >> 8*counter+8);
                                                    pass_len        <= pass_len - 16;
                                                    char_loc        <= char_loc + 8'd3; 
                                                end
                                                else 
                                                    char_loc        <= char_loc + 1'b1;
                                            end
                                        end /*"5"*/
                                        8'h36: begin //"sau"  ->  6
                                            if ( char_loc >= 10 || character[char_loc] == 0) begin
                                                o_dictionary_pass_gen_password      <= pass_reg;
                                                o_dictionary_pass_gen_password_len  <= pass_len;
                                                o_dictionary_pass_gen_done          <= 1'b1;
                                                scan_password_state                 <= PREPARE;
                                                passwodr_generate_state             <= IDLE;
                                            end
                                            else  begin 
                                                if ((character[char_loc]   == 8'h73 || character[char_loc]   == 8'h53) &&       //"s"
                                                    (character[char_loc+1] == 8'h61 || character[char_loc+1] == 8'h41) &&       //"a"
                                                    (character[char_loc+2] == 8'h75 || character[char_loc+2] == 8'h55)          //"u"
                                                    ) begin
                                                    pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                        (8'h36) << (88-8*counter) | 
                                                                        (pass_reg << 16) & (mask >> 8*counter+8);
                                                    pass_len        <= pass_len - 16; 
                                                    char_loc        <= char_loc + 8'd3; 
                                                end
                                                else 
                                                    char_loc        <= char_loc + 1'b1;
                                            end
                                        end /*"6"*/
                                        8'h37: begin //"bay" -> 7
                                            if ( char_loc >= 10 || character[char_loc] == 0) begin
                                                o_dictionary_pass_gen_password      <= pass_reg;
                                                o_dictionary_pass_gen_password_len  <= pass_len;
                                                o_dictionary_pass_gen_done          <= 1'b1;
                                                scan_password_state                 <= PREPARE;
                                                passwodr_generate_state             <= IDLE;
                                            end
                                            else  begin 
                                                if ((character[char_loc]   == 8'h62 || character[char_loc]   == 8'h42) &&       //"b"
                                                    (character[char_loc+1] == 8'h61 || character[char_loc+1] == 8'h41) &&       //"a"
                                                    (character[char_loc+2] == 8'h79 || character[char_loc+2] == 8'h59)          //"y"
                                                    ) begin
                                                    pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                        (8'h37) << (88-8*counter) | 
                                                                        (pass_reg << 16) & (mask >> 8*counter+8);
                                                    pass_len        <=  pass_len - 16;
                                                    char_loc        <= char_loc + 8'd3; 
                                                end
                                                else 
                                                    char_loc        <= char_loc + 1'b1;
                                            end
                                        end /*"7"*/
                                        8'h38: begin //"tam" -> 8
                                            if ( char_loc >= 10 || character[char_loc] == 0) begin
                                                o_dictionary_pass_gen_password      <= pass_reg;
                                                o_dictionary_pass_gen_password_len  <= pass_len;
                                                o_dictionary_pass_gen_done          <= 1'b1;
                                                scan_password_state                 <= PREPARE;
                                                passwodr_generate_state             <= IDLE;
                                            end
                                            else  begin 
                                                if ((character[char_loc]   == 8'h74 || character[char_loc]   == 8'h54) &&       //"t"
                                                    (character[char_loc+1] == 8'h61 || character[char_loc+1] == 8'h41) &&       //"a"
                                                    (character[char_loc+2] == 8'h6D || character[char_loc+2] == 8'h4D)          //"m"
                                                    ) begin
                                                    pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                        (8'h38) << (88-8*counter) | 
                                                                        (pass_reg << 16) & (mask >> 8*counter+8);
                                                    pass_len        <=  pass_len - 16;
                                                    char_loc        <= char_loc + 8'd3; 
                                                end
                                                else 
                                                    char_loc        <= char_loc + 1'b1;
                                            end
                                        end /*"8"*/
                                        8'h39: begin //"chin" -> 9
                                            if ( char_loc >= 9 || character[char_loc] == 0) begin
                                                o_dictionary_pass_gen_password      <= pass_reg;
                                                o_dictionary_pass_gen_password_len  <= pass_len;
                                                o_dictionary_pass_gen_done          <= 1'b1;
                                                scan_password_state                 <= PREPARE;
                                                passwodr_generate_state             <= IDLE;
                                            end
                                            else  begin 
                                                if ((character[char_loc]   == 8'h63 || character[char_loc]   == 8'h43) &&       //"c"
                                                    (character[char_loc+1] == 8'h68 || character[char_loc+1] == 8'h48) &&       //"h"
                                                    (character[char_loc+2] == 8'h69 || character[char_loc+2] == 8'h49) &&       //"i"
                                                    (character[char_loc+3] == 8'h6E || character[char_loc+3] == 8'h4E)          //"n"
                                                    ) begin
                                                    pass_reg        <=  pass_reg & (mask << (96-8*counter)) | 
                                                                        (8'h39) << (88-8*counter) | 
                                                                        (pass_reg << 24) & (mask >> 8*counter+8);
                                                    pass_len        <= pass_len - 24; 
                                                    char_loc        <= char_loc + 8'd4; 
                                                end
                                                else 
                                                    char_loc        <= char_loc + 1'b1;
                                            end
                                        end     /*"9"*/ 
                                        default: ;
                                    endcase /*DIGIT*/
                                    counter  <= counter  + 1'b1;
                                end     /*PROCESS*/
                            endcase /*scan_password_state */
                        end     /*RULE 44*/
                    endcase /*RULE*/
                end /*GENPASS*/
                default: ;
            endcase /*passwodr_generate_state*/
        end /*reset*/
    end /*Alway @()*/

    function [7:0] UPPERCASE; /*return uppercase of char*/
        input [7:0] char;
        begin
            UPPERCASE = char - 8'h20;
        end
    endfunction
    function [7:0] LOWERCASE; /*return lowercase of char*/
        input [7:0] char;
        begin
            LOWERCASE = char + 8'h20;
        end
    endfunction
    function [95:0] REVERSE_BYTE; 
        input [96:0] pass;
        begin
            REVERSE_BYTE = {pass[07:00], 
                            pass[15:08], 
                            pass[23:16], 
                            pass[31:24], 
                            pass[39:32], 
                            pass[47:40], 
                            pass[55:48], 
                            pass[63:56], 
                            pass[71:64], 
                            pass[79:72], 
                            pass[87:80], 
                            pass[95:88]};
        end
    endfunction

    /*DISPLAY STATES*/
    reg [8*15-1:0] gen_state_display;
    always @(*)
    begin
        case(passwodr_generate_state)
            IDLE:       gen_state_display      = "IDLE";
            GEN_PASS:   gen_state_display      = "GEN_PASS";
        endcase
    end 
    reg [8*15-1:0] scan_state_display;
    always @(*)
    begin
        case(scan_password_state)
            PREPARE:   scan_state_display      = "PREPARE";
            PROCESS:   scan_state_display      = "PROCESS";
        endcase
    end
endmodule
