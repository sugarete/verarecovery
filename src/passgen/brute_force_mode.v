`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Acronicssolutions
// Engineer: PWR_Team
// 
// Create Date: 09/10/2022 04:10:44 AM
// Design Name: 
// Module Name: brute_force_mode
// Project Name: PWR_ACS
// Target Devices: ZCU-102 Evaluation Board
// Tool Versions: Vivado
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.03 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module brute_force_mode #(
	parameter NUMBER_CORE_GEN = 8'd14,
	parameter MAX_LENGTH_PASSWORD = 8'd12,

    parameter PASS_z        = 8'h7A,
	parameter PASS_A        = 8'h41,
	parameter PASS_Ac       = 8'h40,
	parameter PASS_Z        = 8'h5A,
	parameter PASS_0        = 8'h30,
	parameter PASS_9        = 8'h39,
	parameter PASS_Cthan    = 8'h21,
	parameter PASS_Xiec     = 8'h2f,
	parameter PASS_2cham    = 8'h3a,
	parameter PASS_NgoacV   = 8'h5b,
	parameter PASS_NgoacD2  = 8'h60,
	parameter PASS_NgoacN   = 8'h7b,
    parameter PASS_Ngax     = 8'h7e,
    parameter PASS_SPACE    = 8'h20
)
(
  input     wire          i_brute_force_mode_clk,
  input     wire          i_brute_force_mode_rst,
  input     wire          i_brute_force_mode_en,
  input     wire          i_brute_force_mode_load,
  input     wire [4:0]    i_brute_force_mode_char_range, 
  input     wire          i_brute_force_mode_fifo_nealy_full,
  input     wire [7:0]    i_brute_force_mode_length_gen,
  input     wire          i_brute_force_mode_status_check,
  input     wire [7:0]    i_brute_force_mode_count_fifo,
  input     wire          i_brute_force_mode_position,
   
  input     wire [95:0]   i_hybrid_mode_pass_offset,
  input     wire [7:0]    i_hybrid_mode_length_know_gen,
  input     wire          i_hybrid_in_brute_force_en,
    
  input     wire          i_brute_force_mode_pass_again_flag,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_0,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_1,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_2,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_3,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_4,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_5,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_6,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_7,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_8,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_9,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_10,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_11,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_12,
  input     wire [95:0]   i_brute_force_mode_pass_again_regions_13,
    
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_0,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_1,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_2,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_3,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_4,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_5,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_6,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_7,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_8,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_9,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_10,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_11,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_12,
  input     wire  [7:0]   i_brute_force_mode_length_pass_again_regions_13,

  input     wire  [7:0]   i_brute_force_mode_length_minimum,
    
  output    wire  [191:0] o_brute_force_mode_pass,
  output    wire  [7:0]   o_brute_force_mode_length,
  output    wire          o_brute_force_mode_pass_valid,
  output    wire          o_brute_force_mode_outside_pass
);

reg   [7:0]                   character                   [MAX_LENGTH_PASSWORD-1:0];
/* Region: NUMBER CORE GEN */
reg   [191:0]                 password_regions            [NUMBER_CORE_GEN -1:0];
reg   [7:0]                   length_pass_regions         [NUMBER_CORE_GEN-1:0];
reg   [NUMBER_CORE_GEN-1:0]   pass_start;
reg   [NUMBER_CORE_GEN-1:0]   first_export_fin;
reg                           pass_start_flag;
wire                          password_valid;
wire  [7:0]                   password_gen_length_reg;
wire  [7:0]                   password_gen_length_min_reg;
reg   [7:0]                   count_character;
wire                          pass_outside;
reg   [191:0]                 password_final;
reg   [7:0]                   PASS_START_CORE             [NUMBER_CORE_GEN-1:0];
reg   [7:0]                   PASS_END_CORE               [NUMBER_CORE_GEN-1:0];   
reg   [3:0]                   pointer;
reg                           ctrl_cnt_character_0;
reg                           ctrl_cnt_character_1;
reg                           ctrl_cnt_character_2;
reg                           ctrl_cnt_character_3;
reg                           ctrl_cnt_character_4;
reg                           ctrl_cnt_character_5;
reg                           ctrl_cnt_character_6;
reg                           ctrl_cnt_character_7;
reg                           ctrl_cnt_character_8;
reg                           ctrl_cnt_character_9;
reg                           ctrl_cnt_character_10;
reg                           ctrl_cnt_character_11;
reg                           ctrl_cnt_character_12;
reg                           ctrl_cnt_character_13;
reg   [7:0]                   brute_force_mode_count_fifo_reg;
wire  [4:0]                   brute_force_mode_char_range_reg;   

reg   [5:0]                   brute_force_mode_state;   
localparam  IDLE                        = 6'd0;
localparam  RECV                        = 6'd1;
localparam  RECV_1                      = 6'd2;
localparam  RECV_2                      = 6'd3;
localparam  EXPORT                      = 6'd4;
localparam  CHECK_BRUTE                 = 6'd5;
localparam  ROUND_GEN                   = 6'd6;
localparam  POINTER                     = 6'd7;
localparam	CHARACTER_GEN	            = 6'd8;
localparam	CHARACTER_GEN_RG_1	        = 6'd9;
localparam	CHARACTER_GEN_RG_2	        = 6'd10;
localparam	CHARACTER_GEN_RG_3	        = 6'd11;
localparam	CHARACTER_GEN_RG_4	        = 6'd12;
localparam	CHARACTER_GEN_RG_5	        = 6'd13;
localparam	CHARACTER_GEN_RG_6	        = 6'd14;
localparam	CHARACTER_GEN_RG_7	        = 6'd15;
localparam	CHARACTER_GEN_RG_8	        = 6'd16;
localparam	CHARACTER_GEN_RG_9	        = 6'd17;
localparam	CHARACTER_GEN_RG_10	        = 6'd18;
localparam	CHARACTER_GEN_RG_11	        = 6'd19;
localparam	CHARACTER_GEN_RG_12	        = 6'd20;
localparam	CHARACTER_GEN_RG_13	        = 6'd21;
localparam	CHARACTER_GEN_RG_14	        = 6'd22;
localparam	CHARACTER_GEN_RG_15	        = 6'd23;
localparam	CHARACTER_GEN_RG_16	        = 6'd24;
localparam	CHARACTER_GEN_RG_17	        = 6'd25;
localparam	CHARACTER_GEN_RG_18	        = 6'd26;
localparam	CHARACTER_GEN_RG_19	        = 6'd27;
localparam	CHARACTER_GEN_RG_20	        = 6'd28;
localparam	CHARACTER_GEN_RG_21	        = 6'd29;
localparam	CHARACTER_GEN_RG_22	        = 6'd30;
localparam	CHARACTER_GEN_RG_23	        = 6'd31;
localparam	CHARACTER_GEN_RG_24	        = 6'd32;
localparam	CHARACTER_GEN_RG_25	        = 6'd33;
localparam	CHARACTER_GEN_RG_26	        = 6'd34;
localparam	CHARACTER_GEN_RG_27	        = 6'd35;
localparam	CHARACTER_GEN_RG_28	        = 6'd36;
localparam	CHARACTER_GEN_RG_29	        = 6'd37;
localparam	CHARACTER_GEN_RG_30	        = 6'd38;
localparam	CHARACTER_FIN	            = 6'd39;
localparam  CHARACTER_FIN_RG_0          = 6'd40;
localparam  CHARACTER_FIN_RG_1          = 6'd41;
localparam  CHARACTER_FIN_RG_2          = 6'd42;
localparam  CHARACTER_FIN_RG_3          = 6'd43;
localparam  CHARACTER_FIN_RG_4          = 6'd44;
localparam  CHARACTER_FIN_RG_5          = 6'd45;
localparam  CHARACTER_FIN_RG_6          = 6'd46;
localparam  CHARACTER_FIN_RG_7          = 6'd47;
localparam  CHARACTER_FIN_RG_8          = 6'd48;
localparam  CHARACTER_FIN_RG_9          = 6'd49;
localparam  CHARACTER_FIN_RG_10         = 6'd50;
localparam  CHARACTER_FIN_RG_11         = 6'd51;
localparam  CHARACTER_FIN_RG_12         = 6'd52;
localparam  CHARACTER_FIN_RG_13         = 6'd53;
localparam  INITIAL_BRUTE               = 6'd54;
localparam  FIRST_EXPORT                = 6'd55;
localparam  WAIT_1                      = 4'd56;
localparam  WAIT_2                      = 4'd57;    

assign brute_force_mode_char_range_reg = i_brute_force_mode_char_range;
assign password_gen_length_reg      = (i_hybrid_in_brute_force_en == 1'b1)  ? i_brute_force_mode_length_gen - i_hybrid_mode_length_know_gen : i_brute_force_mode_length_gen;
assign password_gen_length_min_reg  = (i_hybrid_in_brute_force_en == 1'b1) ? i_brute_force_mode_length_minimum - i_hybrid_mode_length_know_gen : i_brute_force_mode_length_minimum;
assign password_valid               = ((brute_force_mode_state == EXPORT) & (i_brute_force_mode_fifo_nealy_full == 1'b0) & (count_character < password_gen_length_reg)) ? 1'b1 : 1'b0;
assign pass_outside                 = ((brute_force_mode_state == EXPORT) & (i_brute_force_mode_fifo_nealy_full == 1'b0) & (count_character >= password_gen_length_reg))  ? 1'b1 : 1'b0;

always @(*)
begin
    if(i_brute_force_mode_en == 1'b1)
    begin
        case(brute_force_mode_char_range_reg)
        5'd1: begin   /* Initial division region based lowercase */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h61; /* a - a */
          PASS_START_CORE [1]  = 8'h62; PASS_END_CORE   [1]  = 8'h62; /* b - b */
          PASS_START_CORE [2]  = 8'h63; PASS_END_CORE   [2]  = 8'h64; /* c - d */
          PASS_START_CORE [3]  = 8'h65; PASS_END_CORE   [3]  = 8'h66; /* e - f */
          PASS_START_CORE [4]  = 8'h67; PASS_END_CORE   [4]  = 8'h68; /* g - h */
          PASS_START_CORE [5]  = 8'h69; PASS_END_CORE   [5]  = 8'h6a; /* i - j */
          PASS_START_CORE [6]  = 8'h6b; PASS_END_CORE   [6]  = 8'h6c; /* k - l */
          PASS_START_CORE [7]  = 8'h6d; PASS_END_CORE   [7]  = 8'h6e; /* m - n */
          PASS_START_CORE [8]  = 8'h6f; PASS_END_CORE   [8]  = 8'h70; /* o - p */
          PASS_START_CORE [9]  = 8'h71; PASS_END_CORE   [9]  = 8'h72; /* q - r */
          PASS_START_CORE [10] = 8'h73; PASS_END_CORE   [10] = 8'h74; /* s - t */
          PASS_START_CORE [11] = 8'h75; PASS_END_CORE   [11] = 8'h76; /* u - v */
          PASS_START_CORE [12] = 8'h77; PASS_END_CORE   [12] = 8'h78; /* w - x */
          PASS_START_CORE [13] = 8'h79; PASS_END_CORE   [13] = 8'h7a; /* y - z */
        end

        5'd2: begin   /* Initial division region based uppercase */
          PASS_START_CORE [0]  = 8'h41; PASS_END_CORE   [0]  = 8'h41; /* A - A */  
          PASS_START_CORE [1]  = 8'h42; PASS_END_CORE   [1]  = 8'h42; /* B - B */  
          PASS_START_CORE [2]  = 8'h43; PASS_END_CORE   [2]  = 8'h44; /* C - D */  
          PASS_START_CORE [3]  = 8'h45; PASS_END_CORE   [3]  = 8'h46; /* E - F */  
          PASS_START_CORE [4]  = 8'h47; PASS_END_CORE   [4]  = 8'h48; /* G - H */  
          PASS_START_CORE [5]  = 8'h49; PASS_END_CORE   [5]  = 8'h4a; /* I - J */  
          PASS_START_CORE [6]  = 8'h4b; PASS_END_CORE   [6]  = 8'h4c; /* K - L */  
          PASS_START_CORE [7]  = 8'h4d; PASS_END_CORE   [7]  = 8'h4e; /* M - N */  
          PASS_START_CORE [8]  = 8'h4f; PASS_END_CORE   [8]  = 8'h50; /* O - P */  
          PASS_START_CORE [9]  = 8'h51; PASS_END_CORE   [9]  = 8'h52; /* Q - R */  
          PASS_START_CORE [10] = 8'h53; PASS_END_CORE   [10] = 8'h54; /* S - T */  
          PASS_START_CORE [11] = 8'h55; PASS_END_CORE   [11] = 8'h56; /* U - V */  
          PASS_START_CORE [12] = 8'h57; PASS_END_CORE   [12] = 8'h58; /* W - X */  
          PASS_START_CORE [13] = 8'h59; PASS_END_CORE   [13] = 8'h5a; /* Y - Z */  
        end

        5'd3: begin   /* Initial division region based lowercase + uppercase */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h63; /* a - c */
          PASS_START_CORE [1]  = 8'h64; PASS_END_CORE   [1]  = 8'h66; /* d - f */
          PASS_START_CORE [2]  = 8'h67; PASS_END_CORE   [2]  = 8'h69; /* g - i */
          PASS_START_CORE [3]  = 8'h6a; PASS_END_CORE   [3]  = 8'h6c; /* j - l */
          PASS_START_CORE [4]  = 8'h6d; PASS_END_CORE   [4]  = 8'h70; /* m - p */
          PASS_START_CORE [5]  = 8'h71; PASS_END_CORE   [5]  = 8'h74; /* q - t */
          PASS_START_CORE [6]  = 8'h75; PASS_END_CORE   [6]  = 8'h78; /* u - x */
          PASS_START_CORE [7]  = 8'h79; PASS_END_CORE   [7]  = 8'h42; /* y - B */ /* Trans z - A */
          PASS_START_CORE [8]  = 8'h43; PASS_END_CORE   [8]  = 8'h46; /* C - F */
          PASS_START_CORE [9]  = 8'h47; PASS_END_CORE   [9]  = 8'h4a; /* G - J */
          PASS_START_CORE [10] = 8'h4b; PASS_END_CORE   [10] = 8'h4e; /* K - N */
          PASS_START_CORE [11] = 8'h4f; PASS_END_CORE   [11] = 8'h52; /* O - R */
          PASS_START_CORE [12] = 8'h53; PASS_END_CORE   [12] = 8'h56; /* S - V */
          PASS_START_CORE [13] = 8'h57; PASS_END_CORE   [13] = 8'h5a; /* W - Z */
        end

        5'd4: begin   /* Initial division region based Digits */
          PASS_START_CORE [0]  = 8'h30; PASS_END_CORE   [0]  = 8'h30; /* 0 - 0 */
          PASS_START_CORE [1]  = 8'h31; PASS_END_CORE   [1]  = 8'h31; /* 1 - 1 */
          PASS_START_CORE [2]  = 8'h32; PASS_END_CORE   [2]  = 8'h32; /* 2 - 2 */
          PASS_START_CORE [3]  = 8'h33; PASS_END_CORE   [3]  = 8'h33; /* 3 - 3 */
          PASS_START_CORE [4]  = 8'h34; PASS_END_CORE   [4]  = 8'h34; /* 4 - 4 */
          PASS_START_CORE [5]  = 8'h35; PASS_END_CORE   [5]  = 8'h35; /* 5 - 5 */
          PASS_START_CORE [6]  = 8'h36; PASS_END_CORE   [6]  = 8'h36; /* 6 - 6 */
          PASS_START_CORE [7]  = 8'h37; PASS_END_CORE   [7]  = 8'h37; /* 7 - 7 */
          PASS_START_CORE [8]  = 8'h38; PASS_END_CORE   [8]  = 8'h38; /* 8 - 8 */
          PASS_START_CORE [9]  = 8'h39; PASS_END_CORE   [9]  = 8'h39; /* 9 - 9 */
          PASS_START_CORE [10] = 8'h39; PASS_END_CORE   [10] = 8'h39; /* 9 - 9 */
          PASS_START_CORE [11] = 8'h39; PASS_END_CORE   [11] = 8'h39; /* 9 - 9 */
          PASS_START_CORE [12] = 8'h39; PASS_END_CORE   [12] = 8'h39; /* 9 - 9 */
          PASS_START_CORE [13] = 8'h39; PASS_END_CORE   [13] = 8'h39; /* 9 - 9 */
        end

        5'd5: begin   /* Initial division region based lowercase + Digits */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h62; /* a - b */
          PASS_START_CORE [1]  = 8'h63; PASS_END_CORE   [1]  = 8'h64; /* c - d */
          PASS_START_CORE [2]  = 8'h65; PASS_END_CORE   [2]  = 8'h66; /* e - f */
          PASS_START_CORE [3]  = 8'h67; PASS_END_CORE   [3]  = 8'h68; /* g - h */
          PASS_START_CORE [4]  = 8'h69; PASS_END_CORE   [4]  = 8'h6a; /* i - j */
          PASS_START_CORE [5]  = 8'h6b; PASS_END_CORE   [5]  = 8'h6c; /* k - l */
          PASS_START_CORE [6]  = 8'h6d; PASS_END_CORE   [6]  = 8'h6f; /* m - o */
          PASS_START_CORE [7]  = 8'h70; PASS_END_CORE   [7]  = 8'h72; /* p - r */
          PASS_START_CORE [8]  = 8'h73; PASS_END_CORE   [8]  = 8'h75; /* s - u */
          PASS_START_CORE [9]  = 8'h76; PASS_END_CORE   [9]  = 8'h78; /* v - x */
          PASS_START_CORE [10] = 8'h79; PASS_END_CORE   [10] = 8'h7a; /* y - z */
          PASS_START_CORE [11] = 8'h30; PASS_END_CORE   [11] = 8'h32; /* 0 - 2 */
          PASS_START_CORE [12] = 8'h33; PASS_END_CORE   [12] = 8'h35; /* 3 - 5 */
          PASS_START_CORE [13] = 8'h36; PASS_END_CORE   [13] = 8'h39; /* 6 - 9 */
        end

        5'd6: begin   /* Initial division region based uppercase + Digits */
          PASS_START_CORE [0]  = 8'h41; PASS_END_CORE   [0]  = 8'h42; /* A - B */
          PASS_START_CORE [1]  = 8'h43; PASS_END_CORE   [1]  = 8'h44; /* C - D */
          PASS_START_CORE [2]  = 8'h45; PASS_END_CORE   [2]  = 8'h46; /* E - F */
          PASS_START_CORE [3]  = 8'h47; PASS_END_CORE   [3]  = 8'h48; /* G - H */
          PASS_START_CORE [4]  = 8'h49; PASS_END_CORE   [4]  = 8'h4a; /* I - J */
          PASS_START_CORE [5]  = 8'h4b; PASS_END_CORE   [5]  = 8'h4c; /* K - L */
          PASS_START_CORE [6]  = 8'h4d; PASS_END_CORE   [6]  = 8'h4f; /* M - O */
          PASS_START_CORE [7]  = 8'h50; PASS_END_CORE   [7]  = 8'h52; /* P - R */
          PASS_START_CORE [8]  = 8'h53; PASS_END_CORE   [8]  = 8'h55; /* S - U */
          PASS_START_CORE [9]  = 8'h56; PASS_END_CORE   [9]  = 8'h58; /* V - X */
          PASS_START_CORE [10] = 8'h59; PASS_END_CORE   [10] = 8'h5a; /* Y - Z */
          PASS_START_CORE [11] = 8'h30; PASS_END_CORE   [11] = 8'h32; /* 0 - 2 */
          PASS_START_CORE [12] = 8'h33; PASS_END_CORE   [12] = 8'h35; /* 3 - 5 */
          PASS_START_CORE [13] = 8'h36; PASS_END_CORE   [13] = 8'h39; /* 6 - 9 */
        end

        5'd7: begin   /* Initial division region based lowercase + uppercase + Digits */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h64; /* a - d */
          PASS_START_CORE [1]  = 8'h65; PASS_END_CORE   [1]  = 8'h68; /* e - h */
          PASS_START_CORE [2]  = 8'h69; PASS_END_CORE   [2]  = 8'h6c; /* i - l */
          PASS_START_CORE [3]  = 8'h6d; PASS_END_CORE   [3]  = 8'h70; /* m - p */
          PASS_START_CORE [4]  = 8'h71; PASS_END_CORE   [4]  = 8'h74; /* q - t */
          PASS_START_CORE [5]  = 8'h75; PASS_END_CORE   [5]  = 8'h78; /* u - x */
          PASS_START_CORE [6]  = 8'h79; PASS_END_CORE   [6]  = 8'h42; /* y - B */ /* Trans z - A */
          PASS_START_CORE [7]  = 8'h43; PASS_END_CORE   [7]  = 8'h46; /* C - F */
          PASS_START_CORE [8]  = 8'h47; PASS_END_CORE   [8]  = 8'h4b; /* G - K */
          PASS_START_CORE [9]  = 8'h4c; PASS_END_CORE   [9]  = 8'h50; /* L - P */
          PASS_START_CORE [10] = 8'h51; PASS_END_CORE   [10] = 8'h55; /* Q - U */
          PASS_START_CORE [11] = 8'h56; PASS_END_CORE   [11] = 8'h5a; /* V - Z */
          PASS_START_CORE [12] = 8'h30; PASS_END_CORE   [12] = 8'h34; /* 0 - 4 */
          PASS_START_CORE [13] = 8'h35; PASS_END_CORE   [13] = 8'h39; /* 5 - 9 */
        end

        5'd8: begin   /* Initial division region based symbolds */
          PASS_START_CORE [0]  = 8'h21; PASS_END_CORE   [0]  = 8'h22; /* ! - " */ 
          PASS_START_CORE [1]  = 8'h23; PASS_END_CORE   [1]  = 8'h24; /* # - $ */
          PASS_START_CORE [2]  = 8'h25; PASS_END_CORE   [2]  = 8'h26; /* % - & */ 
          PASS_START_CORE [3]  = 8'h27; PASS_END_CORE   [3]  = 8'h28; /* ' - ( */
          PASS_START_CORE [4]  = 8'h29; PASS_END_CORE   [4]  = 8'h2a; /* ) - * */ 
          PASS_START_CORE [5]  = 8'h2b; PASS_END_CORE   [5]  = 8'h2c; /* + - , */ 
          PASS_START_CORE [6]  = 8'h2d; PASS_END_CORE   [6]  = 8'h2f; /* - - / */ 
          PASS_START_CORE [7]  = 8'h3a; PASS_END_CORE   [7]  = 8'h3b; /* : - ; */
          PASS_START_CORE [8]  = 8'h3c; PASS_END_CORE   [8]  = 8'h3d; /* < - = */ 
          PASS_START_CORE [9]  = 8'h3e; PASS_END_CORE   [9]  = 8'h40; /* > - @ */ 
          PASS_START_CORE [10] = 8'h5b; PASS_END_CORE   [10] = 8'h5d; /* [ - ] */
          PASS_START_CORE [11] = 8'h5e; PASS_END_CORE   [11] = 8'h60; /* ^ - ` */ 
          PASS_START_CORE [12] = 8'h7b; PASS_END_CORE   [12] = 8'h7c; /* { - | */ 
          PASS_START_CORE [13] = 8'h7d; PASS_END_CORE   [13] = 8'h7e; /* } - ~ */ 
        end

        5'd9: begin   /* Initial division region based lowercase + symbolds */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h64; /* a - d */
          PASS_START_CORE [1]  = 8'h65; PASS_END_CORE   [1]  = 8'h68; /* e - h */
          PASS_START_CORE [2]  = 8'h69; PASS_END_CORE   [2]  = 8'h6c; /* i - l */
          PASS_START_CORE [3]  = 8'h6d; PASS_END_CORE   [3]  = 8'h70; /* m - p */
          PASS_START_CORE [4]  = 8'h71; PASS_END_CORE   [4]  = 8'h74; /* q - t */
          PASS_START_CORE [5]  = 8'h75; PASS_END_CORE   [5]  = 8'h78; /* u - x */
          PASS_START_CORE [6]  = 8'h79; PASS_END_CORE   [6]  = 8'h22; /* y - " */ /* Trans z - ! */
          PASS_START_CORE [7]  = 8'h23; PASS_END_CORE   [7]  = 8'h26; /* # - & */
          PASS_START_CORE [8]  = 8'h27; PASS_END_CORE   [8]  = 8'h2a; /* ' - * */
          PASS_START_CORE [9]  = 8'h2b; PASS_END_CORE   [9]  = 8'h2e; /* + - . */
          PASS_START_CORE [10] = 8'h2f; PASS_END_CORE   [10] = 8'h3c; /* / - < */
          PASS_START_CORE [11] = 8'h3d; PASS_END_CORE   [11] = 8'h40; /* = - @ */
          PASS_START_CORE [12] = 8'h5b; PASS_END_CORE   [12] = 8'h5f; /* [ - _ */
          PASS_START_CORE [13] = 8'h60; PASS_END_CORE   [13] = 8'h7e; /* ` - ~ */
        end

        5'd10: begin  /* Initial division region based uppercase + symbolds */
          PASS_START_CORE [0]  = 8'h41; PASS_END_CORE   [0]  = 8'h44; /* A - D */ 
          PASS_START_CORE [1]  = 8'h45; PASS_END_CORE   [1]  = 8'h48; /* E - H */
          PASS_START_CORE [2]  = 8'h49; PASS_END_CORE   [2]  = 8'h4c; /* I - L */
          PASS_START_CORE [3]  = 8'h4d; PASS_END_CORE   [3]  = 8'h50; /* M - P */
          PASS_START_CORE [4]  = 8'h51; PASS_END_CORE   [4]  = 8'h54; /* Q - T */
          PASS_START_CORE [5]  = 8'h55; PASS_END_CORE   [5]  = 8'h58; /* U - X */
          PASS_START_CORE [6]  = 8'h59; PASS_END_CORE   [6]  = 8'h22; /* Y - " */ 
          PASS_START_CORE [7]  = 8'h23; PASS_END_CORE   [7]  = 8'h26; /* # - & */
          PASS_START_CORE [8]  = 8'h27; PASS_END_CORE   [8]  = 8'h2a; /* ' - * */
          PASS_START_CORE [9]  = 8'h2b; PASS_END_CORE   [9]  = 8'h2e; /* + - . */
          PASS_START_CORE [10] = 8'h2f; PASS_END_CORE   [10] = 8'h3c; /* / - < */
          PASS_START_CORE [11] = 8'h3d; PASS_END_CORE   [11] = 8'h40; /* = - @ */ 
          PASS_START_CORE [12] = 8'h5b; PASS_END_CORE   [12] = 8'h5f; /* [ - _ */ 
          PASS_START_CORE [13] = 8'h60; PASS_END_CORE   [13] = 8'h7e; /* ` - ~ */ 
        end

        5'd11: begin  /* Initial division region based lowercase + uppercase + symboilds */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h66; /* A - D */
          PASS_START_CORE [1]  = 8'h67; PASS_END_CORE   [1]  = 8'h6c; /* E - H */
          PASS_START_CORE [2]  = 8'h6d; PASS_END_CORE   [2]  = 8'h72; /* I - L */
          PASS_START_CORE [3]  = 8'h73; PASS_END_CORE   [3]  = 8'h78; /* M - P */
          PASS_START_CORE [4]  = 8'h79; PASS_END_CORE   [4]  = 8'h44; /* Q - T */
          PASS_START_CORE [5]  = 8'h45; PASS_END_CORE   [5]  = 8'h4a; /* U - X */
          PASS_START_CORE [6]  = 8'h4b; PASS_END_CORE   [6]  = 8'h50; /* Y - " */
          PASS_START_CORE [7]  = 8'h51; PASS_END_CORE   [7]  = 8'h56; /* # - & */
          PASS_START_CORE [8]  = 8'h57; PASS_END_CORE   [8]  = 8'h22; /* ' - * */
          PASS_START_CORE [9]  = 8'h23; PASS_END_CORE   [9]  = 8'h28; /* + - . */
          PASS_START_CORE [10] = 8'h29; PASS_END_CORE   [10] = 8'h2e; /* / - < */
          PASS_START_CORE [11] = 8'h2f; PASS_END_CORE   [11] = 8'h3e; /* = - @ */ 
          PASS_START_CORE [12] = 8'h3f; PASS_END_CORE   [12] = 8'h5e; /* [ - _ */ 
          PASS_START_CORE [13] = 8'h5f; PASS_END_CORE   [13] = 8'h7e; /* ` - ~ */ 
        end

        5'd12: begin  /* Initial division region based Digits + symboilds */
          PASS_START_CORE [0]  = 8'h30; PASS_END_CORE   [0]  = 8'h32;
          PASS_START_CORE [1]  = 8'h33; PASS_END_CORE   [1]  = 8'h35;
          PASS_START_CORE [2]  = 8'h36; PASS_END_CORE   [2]  = 8'h38;
          PASS_START_CORE [3]  = 8'h39; PASS_END_CORE   [3]  = 8'h22;
          PASS_START_CORE [4]  = 8'h23; PASS_END_CORE   [4]  = 8'h25;
          PASS_START_CORE [5]  = 8'h26; PASS_END_CORE   [5]  = 8'h28;
          PASS_START_CORE [6]  = 8'h29; PASS_END_CORE   [6]  = 8'h2b;
          PASS_START_CORE [7]  = 8'h2c; PASS_END_CORE   [7]  = 8'h2e;
          PASS_START_CORE [8]  = 8'h2f; PASS_END_CORE   [8]  = 8'h3b;
          PASS_START_CORE [9]  = 8'h3c; PASS_END_CORE   [9]  = 8'h3e;
          PASS_START_CORE [10] = 8'h3f; PASS_END_CORE   [10] = 8'h5b;
          PASS_START_CORE [11] = 8'h5c; PASS_END_CORE   [11] = 8'h5e; 
          PASS_START_CORE [12] = 8'h5f; PASS_END_CORE   [12] = 8'h7b; 
          PASS_START_CORE [13] = 8'h7c; PASS_END_CORE   [13] = 8'h7e; 
        end

        5'd13: begin  /* Initial division region based lowercase + Digits + symboilds*/
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h64; 
          PASS_START_CORE [1]  = 8'h65; PASS_END_CORE   [1]  = 8'h68; 
          PASS_START_CORE [2]  = 8'h69; PASS_END_CORE   [2]  = 8'h6d; 
          PASS_START_CORE [3]  = 8'h6e; PASS_END_CORE   [3]  = 8'h72;
          PASS_START_CORE [4]  = 8'h73; PASS_END_CORE   [4]  = 8'h77; 
          PASS_START_CORE [5]  = 8'h78; PASS_END_CORE   [5]  = 8'h31; 
          PASS_START_CORE [6]  = 8'h32; PASS_END_CORE   [6]  = 8'h36; 
          PASS_START_CORE [7]  = 8'h37; PASS_END_CORE   [7]  = 8'h22;
          PASS_START_CORE [8]  = 8'h23; PASS_END_CORE   [8]  = 8'h27; 
          PASS_START_CORE [9]  = 8'h28; PASS_END_CORE   [9]  = 8'h2c; 
          PASS_START_CORE [10] = 8'h2d; PASS_END_CORE   [10] = 8'h3b;
          PASS_START_CORE [11] = 8'h3c; PASS_END_CORE   [11] = 8'h40; 
          PASS_START_CORE [12] = 8'h5b; PASS_END_CORE   [12] = 8'h5f; 
          PASS_START_CORE [13] = 8'h60; PASS_END_CORE   [13] = 8'h7e; 
        end

        5'd14: begin  /* Initial division region based uppercase + Digits + symboilds */
          PASS_START_CORE [0]  = 8'h41; PASS_END_CORE   [0]  = 8'h44; 
          PASS_START_CORE [1]  = 8'h45; PASS_END_CORE   [1]  = 8'h48; 
          PASS_START_CORE [2]  = 8'h49; PASS_END_CORE   [2]  = 8'h4d; 
          PASS_START_CORE [3]  = 8'h4e; PASS_END_CORE   [3]  = 8'h52;
          PASS_START_CORE [4]  = 8'h53; PASS_END_CORE   [4]  = 8'h57; 
          PASS_START_CORE [5]  = 8'h58; PASS_END_CORE   [5]  = 8'h31; //trans hex 5a->30
          PASS_START_CORE [6]  = 8'h32; PASS_END_CORE   [6]  = 8'h36; 
          PASS_START_CORE [7]  = 8'h37; PASS_END_CORE   [7]  = 8'h22; //trans hex 39->21
          PASS_START_CORE [8]  = 8'h23; PASS_END_CORE   [8]  = 8'h27; 
          PASS_START_CORE [9]  = 8'h28; PASS_END_CORE   [9]  = 8'h2c; 
          PASS_START_CORE [10] = 8'h2d; PASS_END_CORE   [10] = 8'h3b; //trans hex 2f->3a
          PASS_START_CORE [11] = 8'h3c; PASS_END_CORE   [11] = 8'h40; 
          PASS_START_CORE [12] = 8'h5b; PASS_END_CORE   [12] = 8'h5f; 
          PASS_START_CORE [13] = 8'h60; PASS_END_CORE   [13] = 8'h7e; //trans hex 60->7b 
        end

        5'd15: begin  /* Initial division region based lowercase + uppercase + Digits + symboilds */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h66;
          PASS_START_CORE [1]  = 8'h67; PASS_END_CORE   [1]  = 8'h6c; 
          PASS_START_CORE [2]  = 8'h6d; PASS_END_CORE   [2]  = 8'h72; 
          PASS_START_CORE [3]  = 8'h73; PASS_END_CORE   [3]  = 8'h78;
          PASS_START_CORE [4]  = 8'h79; PASS_END_CORE   [4]  = 8'h45; //trans hex 7a->41
          PASS_START_CORE [5]  = 8'h46; PASS_END_CORE   [5]  = 8'h4c; 
          PASS_START_CORE [6]  = 8'h4d; PASS_END_CORE   [6]  = 8'h53; 
          PASS_START_CORE [7]  = 8'h54; PASS_END_CORE   [7]  = 8'h5a;
          PASS_START_CORE [8]  = 8'h30; PASS_END_CORE   [8]  = 8'h36; 
          PASS_START_CORE [9]  = 8'h37; PASS_END_CORE   [9]  = 8'h24; //trans hex 39->21
          PASS_START_CORE [10] = 8'h25; PASS_END_CORE   [10] = 8'h2b;
          PASS_START_CORE [11] = 8'h2c; PASS_END_CORE   [11] = 8'h3e; 
          PASS_START_CORE [12] = 8'h3f; PASS_END_CORE   [12] = 8'h5d; //trans hex 40->5b
          PASS_START_CORE [13] = 8'h5e; PASS_END_CORE   [13] = 8'h7e; //trans hex 60->7b
        end

        5'd16: begin  /* Initial division region based lowercase + space */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h61; 
          PASS_START_CORE [1]  = 8'h62; PASS_END_CORE   [1]  = 8'h62; 
          PASS_START_CORE [2]  = 8'h63; PASS_END_CORE   [2]  = 8'h64; 
          PASS_START_CORE [3]  = 8'h65; PASS_END_CORE   [3]  = 8'h66;
          PASS_START_CORE [4]  = 8'h67; PASS_END_CORE   [4]  = 8'h68; 
          PASS_START_CORE [5]  = 8'h69; PASS_END_CORE   [5]  = 8'h6a; 
          PASS_START_CORE [6]  = 8'h6b; PASS_END_CORE   [6]  = 8'h6c; 
          PASS_START_CORE [7]  = 8'h6d; PASS_END_CORE   [7]  = 8'h6e;
          PASS_START_CORE [8]  = 8'h6f; PASS_END_CORE   [8]  = 8'h70; 
          PASS_START_CORE [9]  = 8'h71; PASS_END_CORE   [9]  = 8'h72; 
          PASS_START_CORE [10] = 8'h73; PASS_END_CORE   [10] = 8'h74;
          PASS_START_CORE [11] = 8'h75; PASS_END_CORE   [11] = 8'h76; 
          PASS_START_CORE [12] = 8'h77; PASS_END_CORE   [12] = 8'h78; 
          PASS_START_CORE [13] = 8'h79; PASS_END_CORE   [13] = 8'h20; //trans hex 7a->20
        end

        5'd17: begin  /* Initial division region based uppercase + space */
          PASS_START_CORE [0]  = 8'h41; PASS_END_CORE   [0]  = 8'h41; 
          PASS_START_CORE [1]  = 8'h42; PASS_END_CORE   [1]  = 8'h42; 
          PASS_START_CORE [2]  = 8'h43; PASS_END_CORE   [2]  = 8'h44; 
          PASS_START_CORE [3]  = 8'h45; PASS_END_CORE   [3]  = 8'h46;
          PASS_START_CORE [4]  = 8'h47; PASS_END_CORE   [4]  = 8'h48; 
          PASS_START_CORE [5]  = 8'h49; PASS_END_CORE   [5]  = 8'h4a; 
          PASS_START_CORE [6]  = 8'h4b; PASS_END_CORE   [6]  = 8'h4c; 
          PASS_START_CORE [7]  = 8'h4d; PASS_END_CORE   [7]  = 8'h4e;
          PASS_START_CORE [8]  = 8'h4f; PASS_END_CORE   [8]  = 8'h50; 
          PASS_START_CORE [9]  = 8'h51; PASS_END_CORE   [9]  = 8'h52; 
          PASS_START_CORE [10] = 8'h53; PASS_END_CORE   [10] = 8'h54;
          PASS_START_CORE [11] = 8'h55; PASS_END_CORE   [11] = 8'h56; 
          PASS_START_CORE [12] = 8'h57; PASS_END_CORE   [12] = 8'h58; 
          PASS_START_CORE [13] = 8'h59; PASS_END_CORE   [13] = 8'h20; //trans hex 5a->20 
        end

        5'd18: begin  /* Initial division region based lowercase + uppercase + space */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h63; 
          PASS_START_CORE [1]  = 8'h64; PASS_END_CORE   [1]  = 8'h66; 
          PASS_START_CORE [2]  = 8'h67; PASS_END_CORE   [2]  = 8'h69; 
          PASS_START_CORE [3]  = 8'h6a; PASS_END_CORE   [3]  = 8'h6c;
          PASS_START_CORE [4]  = 8'h6d; PASS_END_CORE   [4]  = 8'h70; 
          PASS_START_CORE [5]  = 8'h71; PASS_END_CORE   [5]  = 8'h74; 
          PASS_START_CORE [6]  = 8'h75; PASS_END_CORE   [6]  = 8'h78; 
          PASS_START_CORE [7]  = 8'h79; PASS_END_CORE   [7]  = 8'h42; //trans hex 7a->41
          PASS_START_CORE [8]  = 8'h43; PASS_END_CORE   [8]  = 8'h46; 
          PASS_START_CORE [9]  = 8'h47; PASS_END_CORE   [9]  = 8'h4a; 
          PASS_START_CORE [10] = 8'h4b; PASS_END_CORE   [10] = 8'h4e;
          PASS_START_CORE [11] = 8'h4f; PASS_END_CORE   [11] = 8'h52; 
          PASS_START_CORE [12] = 8'h53; PASS_END_CORE   [12] = 8'h56; 
          PASS_START_CORE [13] = 8'h57; PASS_END_CORE   [13] = 8'h20; //trans hex 5a->20
        end

        5'd19: begin  /* Initial division region based Digits + space */
          PASS_START_CORE [0]  = 8'h30; PASS_END_CORE   [0]  = 8'h30; 
          PASS_START_CORE [1]  = 8'h31; PASS_END_CORE   [1]  = 8'h31; 
          PASS_START_CORE [2]  = 8'h32; PASS_END_CORE   [2]  = 8'h32; 
          PASS_START_CORE [3]  = 8'h33; PASS_END_CORE   [3]  = 8'h33;
          PASS_START_CORE [4]  = 8'h34; PASS_END_CORE   [4]  = 8'h34; 
          PASS_START_CORE [5]  = 8'h35; PASS_END_CORE   [5]  = 8'h35; 
          PASS_START_CORE [6]  = 8'h36; PASS_END_CORE   [6]  = 8'h36; 
          PASS_START_CORE [7]  = 8'h37; PASS_END_CORE   [7]  = 8'h37;
          PASS_START_CORE [8]  = 8'h38; PASS_END_CORE   [8]  = 8'h38; 
          PASS_START_CORE [9]  = 8'h39; PASS_END_CORE   [9]  = 8'h39; 
          PASS_START_CORE [10] = 8'h20; PASS_END_CORE   [10] = 8'h20;
          ////////////////
          PASS_START_CORE [11] = 8'h20; PASS_END_CORE   [11] = 8'h20; 
          PASS_START_CORE [12] = 8'h20; PASS_END_CORE   [12] = 8'h20; 
          PASS_START_CORE [13] = 8'h20; PASS_END_CORE   [13] = 8'h20; 
        end

        5'd20: begin  /* Initial division region based lowercase + Digits + space */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h62; 
          PASS_START_CORE [1]  = 8'h63; PASS_END_CORE   [1]  = 8'h64; 
          PASS_START_CORE [2]  = 8'h65; PASS_END_CORE   [2]  = 8'h66; 
          PASS_START_CORE [3]  = 8'h67; PASS_END_CORE   [3]  = 8'h68;
          PASS_START_CORE [4]  = 8'h69; PASS_END_CORE   [4]  = 8'h6a; 
          PASS_START_CORE [5]  = 8'h6b; PASS_END_CORE   [5]  = 8'h6c; 
          PASS_START_CORE [6]  = 8'h6d; PASS_END_CORE   [6]  = 8'h6f; 
          PASS_START_CORE [7]  = 8'h70; PASS_END_CORE   [7]  = 8'h72;
          PASS_START_CORE [8]  = 8'h73; PASS_END_CORE   [8]  = 8'h75; 
          PASS_START_CORE [9]  = 8'h76; PASS_END_CORE   [9]  = 8'h78; 
          PASS_START_CORE [10] = 8'h79; PASS_END_CORE   [10] = 8'h7a;
          PASS_START_CORE [11] = 8'h30; PASS_END_CORE   [11] = 8'h32; 
          PASS_START_CORE [12] = 8'h33; PASS_END_CORE   [12] = 8'h35; 
          PASS_START_CORE [13] = 8'h36; PASS_END_CORE   [13] = 8'h20; //trans hex 39->20
        end

        5'd21: begin  /* Initial division region based uppercase + Digits + space */
          PASS_START_CORE [0]  = 8'h41; PASS_END_CORE   [0]  = 8'h42; 
          PASS_START_CORE [1]  = 8'h43; PASS_END_CORE   [1]  = 8'h44; 
          PASS_START_CORE [2]  = 8'h45; PASS_END_CORE   [2]  = 8'h46; 
          PASS_START_CORE [3]  = 8'h47; PASS_END_CORE   [3]  = 8'h48;
          PASS_START_CORE [4]  = 8'h49; PASS_END_CORE   [4]  = 8'h4a; 
          PASS_START_CORE [5]  = 8'h4b; PASS_END_CORE   [5]  = 8'h4c; 
          PASS_START_CORE [6]  = 8'h4d; PASS_END_CORE   [6]  = 8'h4f; 
          PASS_START_CORE [7]  = 8'h50; PASS_END_CORE   [7]  = 8'h52;
          PASS_START_CORE [8]  = 8'h53; PASS_END_CORE   [8]  = 8'h55; 
          PASS_START_CORE [9]  = 8'h56; PASS_END_CORE   [9]  = 8'h58; 
          PASS_START_CORE [10] = 8'h59; PASS_END_CORE   [10] = 8'h5a;
          PASS_START_CORE [11] = 8'h30; PASS_END_CORE   [11] = 8'h32; 
          PASS_START_CORE [12] = 8'h33; PASS_END_CORE   [12] = 8'h35; 
          PASS_START_CORE [13] = 8'h36; PASS_END_CORE   [13] = 8'h20; //trans hex 39->20
        end

        5'd22: begin  /* Initial division region based lowercase + uppercase + Digits + space */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h64; 
          PASS_START_CORE [1]  = 8'h65; PASS_END_CORE   [1]  = 8'h68; 
          PASS_START_CORE [2]  = 8'h69; PASS_END_CORE   [2]  = 8'h6c; 
          PASS_START_CORE [3]  = 8'h6d; PASS_END_CORE   [3]  = 8'h70;
          PASS_START_CORE [4]  = 8'h71; PASS_END_CORE   [4]  = 8'h74; 
          PASS_START_CORE [5]  = 8'h75; PASS_END_CORE   [5]  = 8'h78; 
          PASS_START_CORE [6]  = 8'h79; PASS_END_CORE   [6]  = 8'h42; //trans hex 7a->41 
          PASS_START_CORE [7]  = 8'h43; PASS_END_CORE   [7]  = 8'h46;
          PASS_START_CORE [8]  = 8'h47; PASS_END_CORE   [8]  = 8'h4b; 
          PASS_START_CORE [9]  = 8'h4c; PASS_END_CORE   [9]  = 8'h50; 
          PASS_START_CORE [10] = 8'h51; PASS_END_CORE   [10] = 8'h55;
          PASS_START_CORE [11] = 8'h56; PASS_END_CORE   [11] = 8'h5a; 
          PASS_START_CORE [12] = 8'h30; PASS_END_CORE   [12] = 8'h34; 
          PASS_START_CORE [13] = 8'h35; PASS_END_CORE   [13] = 8'h20; //trans hex 39->20
        end

        5'd23: begin  /* Initial division region based symboilds + space */
          PASS_START_CORE [0]  = 8'h21; PASS_END_CORE   [0]  = 8'h22; 
          PASS_START_CORE [1]  = 8'h23; PASS_END_CORE   [1]  = 8'h24; 
          PASS_START_CORE [2]  = 8'h25; PASS_END_CORE   [2]  = 8'h26; 
          PASS_START_CORE [3]  = 8'h27; PASS_END_CORE   [3]  = 8'h28;
          PASS_START_CORE [4]  = 8'h29; PASS_END_CORE   [4]  = 8'h2a; 
          PASS_START_CORE [5]  = 8'h2b; PASS_END_CORE   [5]  = 8'h2c; 
          PASS_START_CORE [6]  = 8'h2d; PASS_END_CORE   [6]  = 8'h2f; 
          PASS_START_CORE [7]  = 8'h3a; PASS_END_CORE   [7]  = 8'h3b;
          PASS_START_CORE [8]  = 8'h3c; PASS_END_CORE   [8]  = 8'h3d; 
          PASS_START_CORE [9]  = 8'h3e; PASS_END_CORE   [9]  = 8'h40; 
          PASS_START_CORE [10] = 8'h5b; PASS_END_CORE   [10] = 8'h5d;
          PASS_START_CORE [11] = 8'h5e; PASS_END_CORE   [11] = 8'h60; 
          PASS_START_CORE [12] = 8'h7b; PASS_END_CORE   [12] = 8'h7c; 
          PASS_START_CORE [13] = 8'h7d; PASS_END_CORE   [13] = 8'h20; //trans hex 7e->20
        end

        5'd24: begin  /* Initial division region based lowercase + symboilds + space */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h64; 
          PASS_START_CORE [1]  = 8'h65; PASS_END_CORE   [1]  = 8'h68; 
          PASS_START_CORE [2]  = 8'h69; PASS_END_CORE   [2]  = 8'h6c; 
          PASS_START_CORE [3]  = 8'h6d; PASS_END_CORE   [3]  = 8'h70;
          PASS_START_CORE [4]  = 8'h71; PASS_END_CORE   [4]  = 8'h74; 
          PASS_START_CORE [5]  = 8'h75; PASS_END_CORE   [5]  = 8'h78; 
          PASS_START_CORE [6]  = 8'h79; PASS_END_CORE   [6]  = 8'h22; //trans hex 7a->21
          PASS_START_CORE [7]  = 8'h23; PASS_END_CORE   [7]  = 8'h26;
          PASS_START_CORE [8]  = 8'h27; PASS_END_CORE   [8]  = 8'h2a; 
          PASS_START_CORE [9]  = 8'h2b; PASS_END_CORE   [9]  = 8'h2e; 
          PASS_START_CORE [10] = 8'h2f; PASS_END_CORE   [10] = 8'h3c; //trans hex 2f->3a
          PASS_START_CORE [11] = 8'h3d; PASS_END_CORE   [11] = 8'h40; 
          PASS_START_CORE [12] = 8'h5b; PASS_END_CORE   [12] = 8'h5f; 
          PASS_START_CORE [13] = 8'h60; PASS_END_CORE   [13] = 8'h20; //trans hex 60->7b; 7e->20
        end

        5'd25: begin  /* Initial division region based uppercase + syboilds + space */
          PASS_START_CORE [0]  = 8'h41; PASS_END_CORE   [0]  = 8'h44; 
          PASS_START_CORE [1]  = 8'h45; PASS_END_CORE   [1]  = 8'h48; 
          PASS_START_CORE [2]  = 8'h49; PASS_END_CORE   [2]  = 8'h4c; 
          PASS_START_CORE [3]  = 8'h4d; PASS_END_CORE   [3]  = 8'h50;
          PASS_START_CORE [4]  = 8'h51; PASS_END_CORE   [4]  = 8'h54; 
          PASS_START_CORE [5]  = 8'h55; PASS_END_CORE   [5]  = 8'h58; 
          PASS_START_CORE [6]  = 8'h59; PASS_END_CORE   [6]  = 8'h22; //trans hex 5a->21
          PASS_START_CORE [7]  = 8'h23; PASS_END_CORE   [7]  = 8'h26;
          PASS_START_CORE [8]  = 8'h27; PASS_END_CORE   [8]  = 8'h2a; 
          PASS_START_CORE [9]  = 8'h2b; PASS_END_CORE   [9]  = 8'h2e; 
          PASS_START_CORE [10] = 8'h2f; PASS_END_CORE   [10] = 8'h3c; //trans hex 2f->3a
          PASS_START_CORE [11] = 8'h3d; PASS_END_CORE   [11] = 8'h40; 
          PASS_START_CORE [12] = 8'h5b; PASS_END_CORE   [12] = 8'h5f; 
          PASS_START_CORE [13] = 8'h60; PASS_END_CORE   [13] = 8'h20; //trans hex 60->7b; 7e->20
        end

        5'd26: begin  /* Initial division region based lowercase + uppercase + symboilds + space */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h66;
          PASS_START_CORE [1]  = 8'h67; PASS_END_CORE   [1]  = 8'h6c; 
          PASS_START_CORE [2]  = 8'h6d; PASS_END_CORE   [2]  = 8'h72; 
          PASS_START_CORE [3]  = 8'h73; PASS_END_CORE   [3]  = 8'h78;
          PASS_START_CORE [4]  = 8'h79; PASS_END_CORE   [4]  = 8'h44; 
          PASS_START_CORE [5]  = 8'h45; PASS_END_CORE   [5]  = 8'h4a; 
          PASS_START_CORE [6]  = 8'h4b; PASS_END_CORE   [6]  = 8'h50; 
          PASS_START_CORE [7]  = 8'h51; PASS_END_CORE   [7]  = 8'h56;
          PASS_START_CORE [8]  = 8'h57; PASS_END_CORE   [8]  = 8'h22; 
          PASS_START_CORE [9]  = 8'h23; PASS_END_CORE   [9]  = 8'h28; 
          PASS_START_CORE [10] = 8'h29; PASS_END_CORE   [10] = 8'h2e;
          PASS_START_CORE [11] = 8'h2f; PASS_END_CORE   [11] = 8'h3e; 
          PASS_START_CORE [12] = 8'h3f; PASS_END_CORE   [12] = 8'h5e; 
          PASS_START_CORE [13] = 8'h5f; PASS_END_CORE   [13] = 8'h20; 
        end

        5'd27: begin  /* Initial division region based Digits + symboilds + space */
          PASS_START_CORE [0]  = 8'h30; PASS_END_CORE   [0]  = 8'h32; 
          PASS_START_CORE [1]  = 8'h33; PASS_END_CORE   [1]  = 8'h35; 
          PASS_START_CORE [2]  = 8'h36; PASS_END_CORE   [2]  = 8'h38; 
          PASS_START_CORE [3]  = 8'h39; PASS_END_CORE   [3]  = 8'h22;
          PASS_START_CORE [4]  = 8'h23; PASS_END_CORE   [4]  = 8'h25; 
          PASS_START_CORE [5]  = 8'h26; PASS_END_CORE   [5]  = 8'h28; 
          PASS_START_CORE [6]  = 8'h29; PASS_END_CORE   [6]  = 8'h2b; 
          PASS_START_CORE [7]  = 8'h2c; PASS_END_CORE   [7]  = 8'h2e;
          PASS_START_CORE [8]  = 8'h2f; PASS_END_CORE   [8]  = 8'h3b; 
          PASS_START_CORE [9]  = 8'h3c; PASS_END_CORE   [9]  = 8'h3e; 
          PASS_START_CORE [10] = 8'h3f; PASS_END_CORE   [10] = 8'h5b;
          PASS_START_CORE [11] = 8'h5c; PASS_END_CORE   [11] = 8'h5e; 
          PASS_START_CORE [12] = 8'h5f; PASS_END_CORE   [12] = 8'h7b; 
          PASS_START_CORE [13] = 8'h7c; PASS_END_CORE   [13] = 8'h20; 
        end

        5'd28: begin  /* Initial division region based lowercase + Digits + symboilds + space */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h64; 
          PASS_START_CORE [1]  = 8'h65; PASS_END_CORE   [1]  = 8'h68; 
          PASS_START_CORE [2]  = 8'h69; PASS_END_CORE   [2]  = 8'h6d; 
          PASS_START_CORE [3]  = 8'h6e; PASS_END_CORE   [3]  = 8'h72;
          PASS_START_CORE [4]  = 8'h73; PASS_END_CORE   [4]  = 8'h77; 
          PASS_START_CORE [5]  = 8'h78; PASS_END_CORE   [5]  = 8'h31; //trans hex 7a->30
          PASS_START_CORE [6]  = 8'h32; PASS_END_CORE   [6]  = 8'h36; 
          PASS_START_CORE [7]  = 8'h37; PASS_END_CORE   [7]  = 8'h22; //trans hex 39->21
          PASS_START_CORE [8]  = 8'h23; PASS_END_CORE   [8]  = 8'h27; 
          PASS_START_CORE [9]  = 8'h28; PASS_END_CORE   [9]  = 8'h2c; 
          PASS_START_CORE [10] = 8'h2d; PASS_END_CORE   [10] = 8'h3b; //trans hex 2f->3a
          PASS_START_CORE [11] = 8'h3c; PASS_END_CORE   [11] = 8'h40; 
          PASS_START_CORE [12] = 8'h5b; PASS_END_CORE   [12] = 8'h5f; 
          PASS_START_CORE [13] = 8'h60; PASS_END_CORE   [13] = 8'h20; //trans hex 60->7b; 7e->20
        end

        5'd29: begin  /* Initial division region based uppercase + Digits + symboilds + space */
          PASS_START_CORE [0]  = 8'h41; PASS_END_CORE   [0]  = 8'h44; 
          PASS_START_CORE [1]  = 8'h45; PASS_END_CORE   [1]  = 8'h48; 
          PASS_START_CORE [2]  = 8'h49; PASS_END_CORE   [2]  = 8'h4d; 
          PASS_START_CORE [3]  = 8'h4e; PASS_END_CORE   [3]  = 8'h52;
          PASS_START_CORE [4]  = 8'h53; PASS_END_CORE   [4]  = 8'h57; 
          PASS_START_CORE [5]  = 8'h58; PASS_END_CORE   [5]  = 8'h31; //trans hex 5a->30
          PASS_START_CORE [6]  = 8'h32; PASS_END_CORE   [6]  = 8'h36; 
          PASS_START_CORE [7]  = 8'h37; PASS_END_CORE   [7]  = 8'h22; //trans hex 39->21
          PASS_START_CORE [8]  = 8'h23; PASS_END_CORE   [8]  = 8'h27; 
          PASS_START_CORE [9]  = 8'h28; PASS_END_CORE   [9]  = 8'h2c; 
          PASS_START_CORE [10] = 8'h2d; PASS_END_CORE   [10] = 8'h3b; //trans hex 2f->3a
          PASS_START_CORE [11] = 8'h3c; PASS_END_CORE   [11] = 8'h40; 
          PASS_START_CORE [12] = 8'h5b; PASS_END_CORE   [12] = 8'h5f; 
          PASS_START_CORE [13] = 8'h60; PASS_END_CORE   [13] = 8'h20; //trans hex 60->7b; 7e->20
        end

        5'd30: begin  /* Initial division region based lowercase + uppercase + Digits + symboild + space */
          PASS_START_CORE [0]  = 8'h61; PASS_END_CORE   [0]  = 8'h66;
          PASS_START_CORE [1]  = 8'h67; PASS_END_CORE   [1]  = 8'h6c; 
          PASS_START_CORE [2]  = 8'h6d; PASS_END_CORE   [2]  = 8'h72; 
          PASS_START_CORE [3]  = 8'h73; PASS_END_CORE   [3]  = 8'h78;
          PASS_START_CORE [4]  = 8'h79; PASS_END_CORE   [4]  = 8'h45; //trans hex 7a->41
          PASS_START_CORE [5]  = 8'h46; PASS_END_CORE   [5]  = 8'h4c; 
          PASS_START_CORE [6]  = 8'h4d; PASS_END_CORE   [6]  = 8'h53; 
          PASS_START_CORE [7]  = 8'h54; PASS_END_CORE   [7]  = 8'h5a;
          PASS_START_CORE [8]  = 8'h30; PASS_END_CORE   [8]  = 8'h36; 
          PASS_START_CORE [9]  = 8'h37; PASS_END_CORE   [9]  = 8'h24; //trans hex 39->21
          PASS_START_CORE [10] = 8'h25; PASS_END_CORE   [10] = 8'h2b;
          PASS_START_CORE [11] = 8'h2c; PASS_END_CORE   [11] = 8'h3e; 
          PASS_START_CORE [12] = 8'h3f; PASS_END_CORE   [12] = 8'h5d; //trans hex 40->5b
          PASS_START_CORE [13] = 8'h5e; PASS_END_CORE   [13] = 8'h20; //trans hex 60->7b; 7e->20
        end
      endcase   
      brute_force_mode_count_fifo_reg = i_brute_force_mode_count_fifo;     
    end
end

always @(posedge i_brute_force_mode_clk or negedge i_brute_force_mode_rst)
begin
    if(!i_brute_force_mode_rst)
    begin
    character[0]	          <= 8'h00;
    character[1]	          <= 8'h00;
    character[2]	          <= 8'h00;
    character[3]	          <= 8'h00;
    character[4]	          <= 8'h00;
    character[5]	          <= 8'h00;
    character[6]	          <= 8'h00;
    character[7]	          <= 8'h00;
    character[8]	          <= 8'h00;
    character[9]	          <= 8'h00;
    character[10]			  <= 8'h00;
    character[11]			  <= 8'h00;
    password_regions[0]       <= 192'd0;
    password_regions[1]       <= 192'd0;
    password_regions[2]       <= 192'd0;
    password_regions[3]       <= 192'd0;
    password_regions[4]       <= 192'd0;
	password_regions[5]       <= 192'd0;
	password_regions[6]       <= 192'd0;
	password_regions[7]       <= 192'd0;
	password_regions[8]       <= 192'd0;
	password_regions[9]       <= 192'd0;
	password_regions[10]      <= 192'd0;
	password_regions[11]      <= 192'd0;
	password_regions[12]      <= 192'd0;
	password_regions[13]      <= 192'd0;

    length_pass_regions[0]      <= 8'd0;
    length_pass_regions[1]      <= 8'd0;
    length_pass_regions[2]      <= 8'd0;
    length_pass_regions[3]      <= 8'd0;
	length_pass_regions[4]      <= 8'd0;
	length_pass_regions[5]      <= 8'd0;
	length_pass_regions[6]      <= 8'd0;
	length_pass_regions[7]      <= 8'd0;
	length_pass_regions[8]      <= 8'd0;
	length_pass_regions[9]      <= 8'd0;
	length_pass_regions[10]     <= 8'd0;
	length_pass_regions[11]     <= 8'd0;
	length_pass_regions[12]     <= 8'd0;
	length_pass_regions[13]     <= 8'd0;   

      count_character         <= 8'd0;
      pass_start              <= 14'h3fff;
      first_export_fin        <= 14'h0;
      pass_start_flag         <= 1'b0;
      pointer                 <= 4'd0;
      ctrl_cnt_character_0      <= 1'b0;
      ctrl_cnt_character_1      <= 1'b0;
      ctrl_cnt_character_2      <= 1'b0;
      ctrl_cnt_character_3      <= 1'b0;
      ctrl_cnt_character_4      <= 1'b0;
      ctrl_cnt_character_5      <= 1'b0;
      ctrl_cnt_character_6      <= 1'b0;
      ctrl_cnt_character_7      <= 1'b0;
      ctrl_cnt_character_8      <= 1'b0;
      ctrl_cnt_character_9      <= 1'b0;
      ctrl_cnt_character_10     <= 1'b0;
      ctrl_cnt_character_11     <= 1'b0;
      ctrl_cnt_character_12     <= 1'b0;
      ctrl_cnt_character_13     <= 1'b0;
      brute_force_mode_state    <= IDLE;
    end
    else
    begin
        if(i_brute_force_mode_status_check == 1'b1 || i_brute_force_mode_en == 1'b0 
        ||(length_pass_regions[0]  >= password_gen_length_reg && length_pass_regions[1]  >= password_gen_length_reg && length_pass_regions[2]  >= password_gen_length_reg 
        && length_pass_regions[3]  >= password_gen_length_reg && length_pass_regions[4]  >= password_gen_length_reg && length_pass_regions[5]  >= password_gen_length_reg 
        && length_pass_regions[6]  >= password_gen_length_reg && length_pass_regions[7]  >= password_gen_length_reg && length_pass_regions[8]  >= password_gen_length_reg
        && length_pass_regions[9]  >= password_gen_length_reg && length_pass_regions[10] >= password_gen_length_reg && length_pass_regions[11] >= password_gen_length_reg
        && length_pass_regions[12] >= password_gen_length_reg && length_pass_regions[13] >= password_gen_length_reg))
        begin
            character[11]			<= 8'h00;
            character[10]			<= 8'h00;
            character[9]			<= 8'h00;
            character[8]			<= 8'h00;
            character[7] 			<= 8'h00;
            character[6]			<= 8'h00;
            character[5]			<= 8'h00;
            character[4]			<= 8'h00;
            character[3]			<= 8'h00;
            character[2]			<= 8'h00;
            character[1]			<= 8'h00;
            character[0] 			<= 8'h00;
            length_pass_regions[0]  <= 8'd0;
            length_pass_regions[1]  <= 8'd0;
            length_pass_regions[2]  <= 8'd0;
            length_pass_regions[3]  <= 8'd0;  
            length_pass_regions[4]     <= 8'd0;
            length_pass_regions[5]     <= 8'd0;
            length_pass_regions[6]     <= 8'd0;
            length_pass_regions[7]     <= 8'd0;
            length_pass_regions[8]     <= 8'd0;
            length_pass_regions[9]     <= 8'd0;
            length_pass_regions[10]    <= 8'd0;
            length_pass_regions[11]    <= 8'd0;
            length_pass_regions[12]    <= 8'd0;
            length_pass_regions[13]    <= 8'd0;                       
            count_character         <= 8'd0;
            pass_start              <= 14'h3fff;
            first_export_fin        <= 14'h0;
            pass_start_flag         <= 1'b0;  
            pointer                 <= 4'd0;          
            ctrl_cnt_character_0    <= 1'b0;
            ctrl_cnt_character_1    <= 1'b0;
            ctrl_cnt_character_2    <= 1'b0;
            ctrl_cnt_character_3    <= 1'b0;
            ctrl_cnt_character_4    <= 1'b0;
            ctrl_cnt_character_5    <= 1'b0;
            ctrl_cnt_character_6    <= 1'b0;
            ctrl_cnt_character_7    <= 1'b0;
            ctrl_cnt_character_8    <= 1'b0;
            ctrl_cnt_character_9    <= 1'b0;
            ctrl_cnt_character_10   <= 1'b0;
            ctrl_cnt_character_11   <= 1'b0;
            ctrl_cnt_character_12   <= 1'b0;
            ctrl_cnt_character_13   <= 1'b0;      
			password_regions[0]		<= 192'd0;
			password_regions[1]		<= 192'd0;
			password_regions[2]		<= 192'd0;
			password_regions[3]		<= 192'd0;
			password_regions[4]		<= 192'd0;
			password_regions[5]		<= 192'd0;
			password_regions[6]		<= 192'd0;
			password_regions[7]		<= 192'd0;
			password_regions[8]		<= 192'd0;
			password_regions[9]		<= 192'd0;
			password_regions[10]	<= 192'd0;
			password_regions[11]	<= 192'd0;
			password_regions[12]	<= 192'd0;
			password_regions[13]	<= 192'd0;
            brute_force_mode_state  <= IDLE;              
        end
        else
        begin 
            case(brute_force_mode_state)
            IDLE: begin
                if( i_brute_force_mode_load == 1'b1 && i_brute_force_mode_en == 1'b1 )
                begin
                    case(i_brute_force_mode_pass_again_flag)
                    0: begin
                        brute_force_mode_state  <= RECV_2;
                    end
                    1: begin
                        brute_force_mode_state  <= RECV_1; 
                    end                        
                    endcase
				end 
                else
                begin
                    brute_force_mode_state  <= IDLE;  
                end
            end     

            RECV_1: begin
                password_regions[0] <= {i_brute_force_mode_pass_again_regions_0[95:88], 8'd0, i_brute_force_mode_pass_again_regions_0[87:80], 8'd0, i_brute_force_mode_pass_again_regions_0[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_0[71:64], 8'd0, i_brute_force_mode_pass_again_regions_0[63:56], 8'd0, i_brute_force_mode_pass_again_regions_0[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_0[47:40], 8'd0, i_brute_force_mode_pass_again_regions_0[39:32], 8'd0, i_brute_force_mode_pass_again_regions_0[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_0[23:16], 8'd0, i_brute_force_mode_pass_again_regions_0[15:8],  8'd0, i_brute_force_mode_pass_again_regions_0[7:0],   8'd0};
                                
                password_regions[1] <= {i_brute_force_mode_pass_again_regions_1[95:88], 8'd0, i_brute_force_mode_pass_again_regions_1[87:80], 8'd0, i_brute_force_mode_pass_again_regions_1[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_1[71:64], 8'd0, i_brute_force_mode_pass_again_regions_1[63:56], 8'd0, i_brute_force_mode_pass_again_regions_1[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_1[47:40], 8'd0, i_brute_force_mode_pass_again_regions_1[39:32], 8'd0, i_brute_force_mode_pass_again_regions_1[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_1[23:16], 8'd0, i_brute_force_mode_pass_again_regions_1[15:8],  8'd0, i_brute_force_mode_pass_again_regions_1[7:0],   8'd0}; 
                                
                password_regions[2] <= {i_brute_force_mode_pass_again_regions_2[95:88], 8'd0, i_brute_force_mode_pass_again_regions_2[87:80], 8'd0, i_brute_force_mode_pass_again_regions_2[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_2[71:64], 8'd0, i_brute_force_mode_pass_again_regions_2[63:56], 8'd0, i_brute_force_mode_pass_again_regions_2[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_2[47:40], 8'd0, i_brute_force_mode_pass_again_regions_2[39:32], 8'd0, i_brute_force_mode_pass_again_regions_2[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_2[23:16], 8'd0, i_brute_force_mode_pass_again_regions_2[15:8],  8'd0, i_brute_force_mode_pass_again_regions_2[7:0],   8'd0};
                                
                password_regions[3] <= {i_brute_force_mode_pass_again_regions_3[95:88], 8'd0, i_brute_force_mode_pass_again_regions_3[87:80], 8'd0, i_brute_force_mode_pass_again_regions_3[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_3[71:64], 8'd0, i_brute_force_mode_pass_again_regions_3[63:56], 8'd0, i_brute_force_mode_pass_again_regions_3[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_3[47:40], 8'd0, i_brute_force_mode_pass_again_regions_3[39:32], 8'd0, i_brute_force_mode_pass_again_regions_3[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_3[23:16], 8'd0, i_brute_force_mode_pass_again_regions_3[15:8],  8'd0, i_brute_force_mode_pass_again_regions_3[7:0],   8'd0};     

                password_regions[4] <= {i_brute_force_mode_pass_again_regions_4[95:88], 8'd0, i_brute_force_mode_pass_again_regions_4[87:80], 8'd0, i_brute_force_mode_pass_again_regions_4[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_4[71:64], 8'd0, i_brute_force_mode_pass_again_regions_4[63:56], 8'd0, i_brute_force_mode_pass_again_regions_4[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_4[47:40], 8'd0, i_brute_force_mode_pass_again_regions_4[39:32], 8'd0, i_brute_force_mode_pass_again_regions_4[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_4[23:16], 8'd0, i_brute_force_mode_pass_again_regions_4[15:8],  8'd0, i_brute_force_mode_pass_again_regions_4[7:0],   8'd0};
                                
                password_regions[5] <= {i_brute_force_mode_pass_again_regions_5[95:88], 8'd0, i_brute_force_mode_pass_again_regions_5[87:80], 8'd0, i_brute_force_mode_pass_again_regions_5[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_5[71:64], 8'd0, i_brute_force_mode_pass_again_regions_5[63:56], 8'd0, i_brute_force_mode_pass_again_regions_5[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_5[47:40], 8'd0, i_brute_force_mode_pass_again_regions_5[39:32], 8'd0, i_brute_force_mode_pass_again_regions_5[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_5[23:16], 8'd0, i_brute_force_mode_pass_again_regions_5[15:8],  8'd0, i_brute_force_mode_pass_again_regions_5[7:0],   8'd0}; 
                                
                password_regions[6] <= {i_brute_force_mode_pass_again_regions_6[95:88], 8'd0, i_brute_force_mode_pass_again_regions_6[87:80], 8'd0, i_brute_force_mode_pass_again_regions_6[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_6[71:64], 8'd0, i_brute_force_mode_pass_again_regions_6[63:56], 8'd0, i_brute_force_mode_pass_again_regions_6[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_6[47:40], 8'd0, i_brute_force_mode_pass_again_regions_6[39:32], 8'd0, i_brute_force_mode_pass_again_regions_6[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_6[23:16], 8'd0, i_brute_force_mode_pass_again_regions_6[15:8],  8'd0, i_brute_force_mode_pass_again_regions_6[7:0],   8'd0};
                                
                password_regions[7] <= {i_brute_force_mode_pass_again_regions_7[95:88], 8'd0, i_brute_force_mode_pass_again_regions_7[87:80], 8'd0, i_brute_force_mode_pass_again_regions_7[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_7[71:64], 8'd0, i_brute_force_mode_pass_again_regions_7[63:56], 8'd0, i_brute_force_mode_pass_again_regions_7[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_7[47:40], 8'd0, i_brute_force_mode_pass_again_regions_7[39:32], 8'd0, i_brute_force_mode_pass_again_regions_7[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_7[23:16], 8'd0, i_brute_force_mode_pass_again_regions_7[15:8],  8'd0, i_brute_force_mode_pass_again_regions_7[7:0],   8'd0};     

                password_regions[8] <= {i_brute_force_mode_pass_again_regions_8[95:88], 8'd0, i_brute_force_mode_pass_again_regions_8[87:80], 8'd0, i_brute_force_mode_pass_again_regions_8[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_8[71:64], 8'd0, i_brute_force_mode_pass_again_regions_8[63:56], 8'd0, i_brute_force_mode_pass_again_regions_8[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_8[47:40], 8'd0, i_brute_force_mode_pass_again_regions_8[39:32], 8'd0, i_brute_force_mode_pass_again_regions_8[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_8[23:16], 8'd0, i_brute_force_mode_pass_again_regions_8[15:8],  8'd0, i_brute_force_mode_pass_again_regions_8[7:0],   8'd0};
                                
                password_regions[9] <= {i_brute_force_mode_pass_again_regions_9[95:88], 8'd0, i_brute_force_mode_pass_again_regions_9[87:80], 8'd0, i_brute_force_mode_pass_again_regions_9[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_9[71:64], 8'd0, i_brute_force_mode_pass_again_regions_9[63:56], 8'd0, i_brute_force_mode_pass_again_regions_9[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_9[47:40], 8'd0, i_brute_force_mode_pass_again_regions_9[39:32], 8'd0, i_brute_force_mode_pass_again_regions_9[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_9[23:16], 8'd0, i_brute_force_mode_pass_again_regions_9[15:8],  8'd0, i_brute_force_mode_pass_again_regions_9[7:0],   8'd0}; 
                                
                password_regions[10] <= {i_brute_force_mode_pass_again_regions_10[95:88], 8'd0, i_brute_force_mode_pass_again_regions_10[87:80], 8'd0, i_brute_force_mode_pass_again_regions_10[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_10[71:64], 8'd0, i_brute_force_mode_pass_again_regions_10[63:56], 8'd0, i_brute_force_mode_pass_again_regions_10[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_10[47:40], 8'd0, i_brute_force_mode_pass_again_regions_10[39:32], 8'd0, i_brute_force_mode_pass_again_regions_10[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_10[23:16], 8'd0, i_brute_force_mode_pass_again_regions_10[15:8],  8'd0, i_brute_force_mode_pass_again_regions_10[7:0],   8'd0};
                                
                password_regions[11] <= {i_brute_force_mode_pass_again_regions_11[95:88], 8'd0, i_brute_force_mode_pass_again_regions_11[87:80], 8'd0, i_brute_force_mode_pass_again_regions_11[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_11[71:64], 8'd0, i_brute_force_mode_pass_again_regions_11[63:56], 8'd0, i_brute_force_mode_pass_again_regions_11[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_11[47:40], 8'd0, i_brute_force_mode_pass_again_regions_11[39:32], 8'd0, i_brute_force_mode_pass_again_regions_11[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_11[23:16], 8'd0, i_brute_force_mode_pass_again_regions_11[15:8],  8'd0, i_brute_force_mode_pass_again_regions_11[7:0],   8'd0};     

                password_regions[12] <= {i_brute_force_mode_pass_again_regions_12[95:88], 8'd0, i_brute_force_mode_pass_again_regions_12[87:80], 8'd0, i_brute_force_mode_pass_again_regions_12[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_12[71:64], 8'd0, i_brute_force_mode_pass_again_regions_12[63:56], 8'd0, i_brute_force_mode_pass_again_regions_12[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_12[47:40], 8'd0, i_brute_force_mode_pass_again_regions_12[39:32], 8'd0, i_brute_force_mode_pass_again_regions_12[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_12[23:16], 8'd0, i_brute_force_mode_pass_again_regions_12[15:8],  8'd0, i_brute_force_mode_pass_again_regions_12[7:0],   8'd0};
                                
                password_regions[13] <= {i_brute_force_mode_pass_again_regions_13[95:88], 8'd0, i_brute_force_mode_pass_again_regions_13[87:80], 8'd0, i_brute_force_mode_pass_again_regions_13[79:72], 8'd0, 
                                        i_brute_force_mode_pass_again_regions_13[71:64], 8'd0, i_brute_force_mode_pass_again_regions_13[63:56], 8'd0, i_brute_force_mode_pass_again_regions_13[55:48], 8'd0,
                                        i_brute_force_mode_pass_again_regions_13[47:40], 8'd0, i_brute_force_mode_pass_again_regions_13[39:32], 8'd0, i_brute_force_mode_pass_again_regions_13[31:24], 8'd0,
                                        i_brute_force_mode_pass_again_regions_13[23:16], 8'd0, i_brute_force_mode_pass_again_regions_13[15:8],  8'd0, i_brute_force_mode_pass_again_regions_13[7:0],   8'd0}; 
                                                        
                length_pass_regions[0] <= i_brute_force_mode_length_pass_again_regions_0 - 1'b1; 
                length_pass_regions[1] <= i_brute_force_mode_length_pass_again_regions_1 - 1'b1; 
                length_pass_regions[2] <= i_brute_force_mode_length_pass_again_regions_2 - 1'b1; 
                length_pass_regions[3] <= i_brute_force_mode_length_pass_again_regions_3 - 1'b1;    
                length_pass_regions[4] <= i_brute_force_mode_length_pass_again_regions_4 - 1'b1; 
                length_pass_regions[5] <= i_brute_force_mode_length_pass_again_regions_5 - 1'b1; 
                length_pass_regions[6] <= i_brute_force_mode_length_pass_again_regions_6 - 1'b1; 
                length_pass_regions[7] <= i_brute_force_mode_length_pass_again_regions_7 - 1'b1;    
                length_pass_regions[8] <= i_brute_force_mode_length_pass_again_regions_8 - 1'b1; 
                length_pass_regions[9] <= i_brute_force_mode_length_pass_again_regions_9 - 1'b1; 
                length_pass_regions[10] <= i_brute_force_mode_length_pass_again_regions_10 - 1'b1; 
                length_pass_regions[11] <= i_brute_force_mode_length_pass_again_regions_11 - 1'b1;    
                length_pass_regions[12] <= i_brute_force_mode_length_pass_again_regions_12 - 1'b1; 
                length_pass_regions[13] <= i_brute_force_mode_length_pass_again_regions_13 - 1'b1;    
                first_export_fin  <= 14'h0; 
                //brute_force_mode_state  <= INITIAL_BRUTE;    
                brute_force_mode_state  <= WAIT_1;                                                                                                                                             
            end

            RECV_2: begin
                if(count_character <= password_gen_length_min_reg - 1)
                begin
                    if(brute_force_mode_char_range_reg == 5'd1 || brute_force_mode_char_range_reg == 5'd3 || brute_force_mode_char_range_reg == 5'd5 || brute_force_mode_char_range_reg == 5'd7
                    || brute_force_mode_char_range_reg == 5'd9 || brute_force_mode_char_range_reg == 5'd11 || brute_force_mode_char_range_reg == 5'd13 || brute_force_mode_char_range_reg == 5'd15
                    || brute_force_mode_char_range_reg == 5'd16 || brute_force_mode_char_range_reg == 5'd18 || brute_force_mode_char_range_reg == 5'd20 || brute_force_mode_char_range_reg == 5'd22
                    || brute_force_mode_char_range_reg == 5'd24 || brute_force_mode_char_range_reg == 5'd26 || brute_force_mode_char_range_reg == 5'd28 || brute_force_mode_char_range_reg == 5'd30)
                    begin /* Initial first password: 0x61 - lowercase */
                        character[MAX_LENGTH_PASSWORD - password_gen_length_min_reg + count_character]    <= 8'h61;
                        count_character   <= count_character + 1;
                    end
                    else if(brute_force_mode_char_range_reg == 5'd2 || brute_force_mode_char_range_reg == 5'd6 || brute_force_mode_char_range_reg == 5'd10 || brute_force_mode_char_range_reg == 5'd14
                            || brute_force_mode_char_range_reg == 5'd17 || brute_force_mode_char_range_reg == 5'd21 || brute_force_mode_char_range_reg == 5'd25 || brute_force_mode_char_range_reg == 5'd29)
                    begin /* Initial first password: 0x41 - uppercase */
                        character[MAX_LENGTH_PASSWORD - password_gen_length_min_reg + count_character]    <= 8'h41;
                        count_character   <= count_character + 1;                          
                    end
                    else if(brute_force_mode_char_range_reg == 5'd4 || brute_force_mode_char_range_reg == 5'd12 || brute_force_mode_char_range_reg == 5'd19 || brute_force_mode_char_range_reg == 5'd27)
                    begin /* Initial first password: 0x30 - digits */
                        character[MAX_LENGTH_PASSWORD - password_gen_length_min_reg + count_character]    <= 8'h30;
                        count_character   <= count_character + 1;                         
                    end
                    else if (brute_force_mode_char_range_reg == 5'd8 || brute_force_mode_char_range_reg == 5'd23)
                    begin /* Initial first password: 0x12 - symbols */
                        character[MAX_LENGTH_PASSWORD - password_gen_length_min_reg + count_character]    <= 8'h21;
                        count_character   <= count_character + 1;                         
                    end
                end
                else begin /* Assign first password to region register */
                      password_regions[0] <= {PASS_START_CORE[0], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0}; 
                      
                      password_regions[1] <= {PASS_START_CORE[1], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};
                      
                      password_regions[2] <= {PASS_START_CORE[2], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};
                      
                      password_regions[3] <= {PASS_START_CORE[3], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0}; 
                      
                      password_regions[4] <= {PASS_START_CORE[4], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};

                      password_regions[5] <= {PASS_START_CORE[5], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};  
                      
                      password_regions[6] <= {PASS_START_CORE[6], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};
                      
                      password_regions[7] <= {PASS_START_CORE[7], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0}; 
                      
                      password_regions[8] <= {PASS_START_CORE[8], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0}; 

                      password_regions[9] <= {PASS_START_CORE[9], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0}; 
                      
                      password_regions[10] <= {PASS_START_CORE[10], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};  
                      
                      password_regions[11] <= {PASS_START_CORE[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0}; 
                      
                      password_regions[12] <= {PASS_START_CORE[12], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};

                      password_regions[13] <= {PASS_START_CORE[13], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                              character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};
                                                        
                      length_pass_regions[0]  <= password_gen_length_min_reg -1;
                      length_pass_regions[1]  <= password_gen_length_min_reg -1;                        
                      length_pass_regions[2]  <= password_gen_length_min_reg -1;                                    
                      length_pass_regions[3]  <= password_gen_length_min_reg -1;   
                      length_pass_regions[4]  <= password_gen_length_min_reg -1;
                      length_pass_regions[5]  <= password_gen_length_min_reg -1;                        
                      length_pass_regions[6]  <= password_gen_length_min_reg -1;                                    
                      length_pass_regions[7]  <= password_gen_length_min_reg -1;   
                      length_pass_regions[8]  <= password_gen_length_min_reg -1;
                      length_pass_regions[9]  <= password_gen_length_min_reg -1;                        
                      length_pass_regions[10]  <= password_gen_length_min_reg -1;                                    
                      length_pass_regions[11]  <= password_gen_length_min_reg -1;   
                      length_pass_regions[12]  <= password_gen_length_min_reg -1;
                      length_pass_regions[13]  <= password_gen_length_min_reg -1;                        
                      first_export_fin  <= 14'h3fff;  
                      //brute_force_mode_state  <= INITIAL_BRUTE; 
                      brute_force_mode_state  <= WAIT_1;                         
                end                
            end

            WAIT_1:
            begin
                brute_force_mode_state <= INITIAL_BRUTE;    
            end            

            INITIAL_BRUTE: begin
                    character[11]			<= password_regions[brute_force_mode_count_fifo_reg][191:184];
                    character[10]		    <= password_regions[brute_force_mode_count_fifo_reg][175:168];
                    character[9]			<= password_regions[brute_force_mode_count_fifo_reg][159:152];
                    character[8]			<= password_regions[brute_force_mode_count_fifo_reg][143:136];
                    character[7] 			<= password_regions[brute_force_mode_count_fifo_reg][127:120];
                    character[6]			<= password_regions[brute_force_mode_count_fifo_reg][111:104];
                    character[5]			<= password_regions[brute_force_mode_count_fifo_reg][95:88];
                    character[4]		    <= password_regions[brute_force_mode_count_fifo_reg][79:72];
                    character[3]			<= password_regions[brute_force_mode_count_fifo_reg][63:56];
                    character[2]			<= password_regions[brute_force_mode_count_fifo_reg][47:40];
                    character[1]			<= password_regions[brute_force_mode_count_fifo_reg][31:24];
                    character[0] 			<= password_regions[brute_force_mode_count_fifo_reg][15:8];
                    count_character         <= length_pass_regions[brute_force_mode_count_fifo_reg];     
                    pass_start_flag         <= 1'b0;
                    first_export_fin[brute_force_mode_count_fifo_reg] <= 1'b1;
                    //brute_force_mode_state  <= EXPORT;   
                    brute_force_mode_state  <= WAIT_2;                                    
            end

            WAIT_2:
            begin
                brute_force_mode_state <= EXPORT;    
            end            
            
            EXPORT: begin
                if(i_brute_force_mode_fifo_nealy_full == 1'b0)
                begin                    
                    password_regions[brute_force_mode_count_fifo_reg] <= {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0,
                                                                        character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};                   
                    length_pass_regions[brute_force_mode_count_fifo_reg]        <= count_character; 
                    pass_start[brute_force_mode_count_fifo_reg]                 <= pass_start_flag;      
                    if (i_brute_force_mode_pass_again_flag == 1 && first_export_fin != 14'h3fff) begin 
                        brute_force_mode_state  <= FIRST_EXPORT;   
                    end
                    else begin
                        brute_force_mode_state  <= ROUND_GEN;
                    end  
                end  
                else 
                begin
                    brute_force_mode_state  <= EXPORT; 
                end         
            end 
            
            FIRST_EXPORT: begin
                brute_force_mode_state  <= INITIAL_BRUTE;
            end
            
		    ROUND_GEN: begin
                character[11]			<= password_regions[brute_force_mode_count_fifo_reg][191:184];
                character[10]			<= password_regions[brute_force_mode_count_fifo_reg][175:168];
                character[9]			<= password_regions[brute_force_mode_count_fifo_reg][159:152];
                character[8]			<= password_regions[brute_force_mode_count_fifo_reg][143:136];
                character[7]			<= password_regions[brute_force_mode_count_fifo_reg][127:120];
                character[6]			<= password_regions[brute_force_mode_count_fifo_reg][111:104];
                character[5]			<= password_regions[brute_force_mode_count_fifo_reg][95:88];
                character[4]			<= password_regions[brute_force_mode_count_fifo_reg][79:72];
                character[3]			<= password_regions[brute_force_mode_count_fifo_reg][63:56];
                character[2]			<= password_regions[brute_force_mode_count_fifo_reg][47:40];
                character[1]			<= password_regions[brute_force_mode_count_fifo_reg][31:24];
                character[0]			<= password_regions[brute_force_mode_count_fifo_reg][15:8];
                count_character         <= length_pass_regions[brute_force_mode_count_fifo_reg]; 
                pass_start_flag         <= pass_start[brute_force_mode_count_fifo_reg];    
                brute_force_mode_state  <= CHECK_BRUTE;                 
            end                        
            
            CHECK_BRUTE: /* Checking length password allowed */
                begin 
                //   ctrl_cnt_character <= 0;
                  case(count_character)
                      8'd0: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                // ctrl_cnt_character <= 0;
                                if(character[11] == PASS_END_CORE[0]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[0]; end
                                // if((PASS_START_CORE[0] == PASS_END_CORE[0]) && ctrl_cnt_character_0 == 0)
                                // begin
                                //     count_character <= 8'd0;
                                //     ctrl_cnt_character_0 <= 1;
                                // end                          
                            end
                            8'd1: begin
                                // ctrl_cnt_character <= 0;
                                if(character[11] == PASS_END_CORE[1]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[1]; end
                                if((PASS_START_CORE[1] == PASS_END_CORE[1]) && ctrl_cnt_character_1 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_1 <= 1;
                                end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[2]; end
                                if((PASS_START_CORE[2] == PASS_END_CORE[2]) && ctrl_cnt_character_2 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_2 <= 1;
                                end                                
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[3]; end
                                if((PASS_START_CORE[3] == PASS_END_CORE[3]) && ctrl_cnt_character_3 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_3 <= 1;
                                end                               
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[4]; end
                                if((PASS_START_CORE[4] == PASS_END_CORE[4]) && ctrl_cnt_character_4 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_4 <= 1;
                                end                           
                            end
                            8'd5: begin
                                if(character[11] == PASS_END_CORE[5]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[5]; end
                                if((PASS_START_CORE[5] == PASS_END_CORE[5]) && ctrl_cnt_character_5 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_5 <= 1;
                                end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[6]; end
                                if((PASS_START_CORE[6] == PASS_END_CORE[6]) && ctrl_cnt_character_6 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_6 <= 1;
                                end                                
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[7]; end
                                if((PASS_START_CORE[7] == PASS_END_CORE[7]) && ctrl_cnt_character_7 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_7 <= 1;
                                end                               
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[8]; end
                                if((PASS_START_CORE[8] == PASS_END_CORE[8]) && ctrl_cnt_character_8 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_8 <= 1;
                                end                           
                            end
                            8'd9: begin
                                if(character[11] == PASS_END_CORE[9]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[9]; end
                                if((PASS_START_CORE[9] == PASS_END_CORE[9]) && ctrl_cnt_character_9 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_9 <= 1;
                                end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[10]; end
                                if((PASS_START_CORE[10] == PASS_END_CORE[10]) && ctrl_cnt_character_10 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_10 <= 1;
                                end                                
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[11]; end
                                if((PASS_START_CORE[11] == PASS_END_CORE[11]) && ctrl_cnt_character_11 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_11 <= 1;
                                end                               
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[12]; end
                                if((PASS_START_CORE[12] == PASS_END_CORE[12]) && ctrl_cnt_character_12 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_12 <= 1;
                                end                           
                            end
                            8'd13: begin
                                if(character[11] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd1; character[11] <= PASS_START_CORE[13]; end
                                if((PASS_START_CORE[13] == PASS_END_CORE[13]) && ctrl_cnt_character_13 == 0)
                                begin
                                    count_character <= 8'd0;
                                    ctrl_cnt_character_13 <= 1;
                                end                                
                            end
                          endcase
                          brute_force_mode_state <= POINTER;  
                      end
                      8'd1: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; end                           
                            end
                            8'd1: begin
                                if(character[11] == PASS_END_CORE[1] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; end                                 
                            end
                            8'd3: begin 
                               if(character[11] == PASS_END_CORE[3] && character[10] == PASS_END_CORE[13]) 
                               begin count_character <= 8'd2; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; end                                
                           end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; end                           
                            end
                            8'd5: begin
                                if(character[11] == PASS_END_CORE[5] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; end                                 
                            end
                            8'd7: begin 
                               if(character[11] == PASS_END_CORE[7] && character[10] == PASS_END_CORE[13]) 
                               begin count_character <= 8'd2; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; end                                
                           end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; end                           
                            end
                            8'd9: begin
                                if(character[11] == PASS_END_CORE[9] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; end                                 
                            end
                            8'd11: begin 
                               if(character[11] == PASS_END_CORE[11] && character[10] == PASS_END_CORE[13]) 
                               begin count_character <= 8'd2; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; end                                
                           end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; end                           
                            end
                            8'd13: begin
                                if(character[11] == PASS_END_CORE[13] && character[10] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd2; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; end                                
                            end
                          endcase   
                          brute_force_mode_state <= POINTER;                       
                      end
                      8'd2: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                           
                            end
                            8'd1: begin
                                if(character[11] == PASS_END_CORE[1] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                                 
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0];end                                
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                           
                            end
                            8'd5: begin
                                if(character[11] == PASS_END_CORE[5] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                                 
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0];end                                
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                           
                            end
                            8'd9: begin
                                if(character[11] == PASS_END_CORE[9] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                                 
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0];end                                
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                           
                            end
                            8'd13: begin
                                if(character[11] == PASS_END_CORE[13] && character[10] ==  PASS_END_CORE[13] && character[9] ==  PASS_END_CORE[13]) 
                                begin count_character <= 8'd3; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; end                                
                            end
                          endcase    
                          brute_force_mode_state <= POINTER;      
                      end
                      8'd3: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                           
                            end
                            8'd1: begin
                                if(character[11] ==  PASS_END_CORE[1] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                                 
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];end                                
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                           
                            end
                            8'd5: begin
                                if(character[11] ==  PASS_END_CORE[5] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                                 
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];end                                
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                           
                            end
                            8'd9: begin
                                if(character[11] ==  PASS_END_CORE[9] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                                 
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];end                                
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                           
                            end
                            8'd13: begin
                                if(character[11] ==  PASS_END_CORE[13] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd4; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; end                                
                            end
                          endcase 
                          brute_force_mode_state <= POINTER;                              
                      end
                      8'd4: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                           
                            end
                            8'd1: begin
                                if(character[11] ==  PASS_END_CORE[1] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                                
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                           
                            end
                            8'd5: begin
                                if(character[11] ==  PASS_END_CORE[5] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];  character[7]  <= PASS_START_CORE[0];end                                
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                           
                            end
                            8'd9: begin
                                if(character[11] ==  PASS_END_CORE[9] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                                
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                           
                            end
                            8'd13: begin
                                if(character[11] ==  PASS_END_CORE[13] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd5; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0];end                                
                            end
                          endcase  
                          brute_force_mode_state <= POINTER;                             
                      end
                      8'd5: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                           
                            end
                            8'd1: begin
                                if(character[11] ==  PASS_END_CORE[1] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                                
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                           
                            end
                            8'd5: begin
                                if(character[11] ==  PASS_END_CORE[5] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];  character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                                
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                           
                            end
                            8'd9: begin
                                if(character[11] ==  PASS_END_CORE[9] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                                
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                           
                            end
                            8'd13: begin
                                if(character[11] ==  PASS_END_CORE[13] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd6; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0];end                                
                            end
                          endcase 
                          brute_force_mode_state <= POINTER;                              
                      end
                      8'd6: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                           
                            end
                            8'd1: begin
                                if(character[11] ==  PASS_END_CORE[1] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                                
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                           
                            end
                            8'd5: begin
                                if(character[11] ==  PASS_END_CORE[5] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];  character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                                
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                           
                            end
                            8'd9: begin
                                if(character[11] ==  PASS_END_CORE[9] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                                
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                           
                            end
                            8'd13: begin
                                if(character[11] ==  PASS_END_CORE[13] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd7; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0];end                                
                            end
                          endcase     
                          brute_force_mode_state <= POINTER;                          
                      end
                      8'd7: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                           
                            end
                            8'd1: begin
                                if(character[11] ==  PASS_END_CORE[1] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                                
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                           
                            end
                            8'd5: begin
                                if(character[11] ==  PASS_END_CORE[5] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];  character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                                
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                           
                            end
                            8'd9: begin
                                if(character[11] ==  PASS_END_CORE[9] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                                
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                           
                            end
                            8'd13: begin
                                if(character[11] ==  PASS_END_CORE[13] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd8; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0];end                                
                            end
                          endcase    
                          brute_force_mode_state <= POINTER;                                    
                      end
                      8'd8: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                           
                            end
                            8'd1: begin
                                if(character[11] ==  PASS_END_CORE[1] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                                 
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                                
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                           
                            end
                            8'd5: begin
                                if(character[11] ==  PASS_END_CORE[5] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                                 
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];  character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                                
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                           
                            end
                            8'd9: begin
                                if(character[11] ==  PASS_END_CORE[9] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                                 
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                                
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                           
                            end
                            8'd13: begin
                                if(character[11] ==  PASS_END_CORE[13] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd9; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];end                                
                            end
                          endcase     
                          brute_force_mode_state <= POINTER;                     
                      end		          
                      8'd9: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                           
                            end
                            8'd1: begin
                                if(character[11] ==  PASS_END_CORE[1] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                                
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                           
                            end
                            8'd5: begin
                                if(character[11] ==  PASS_END_CORE[5] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];  character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                                
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                           
                            end
                            8'd9: begin
                                if(character[11] ==  PASS_END_CORE[9] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                                
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                           
                            end
                            8'd13: begin
                                if(character[11] ==  PASS_END_CORE[13] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd10; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0];end                                
                            end
                          endcase  
                          brute_force_mode_state <= POINTER;                        		          
                      end
                      8'd10: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                           
                            end
                            8'd1: begin
                                if(character[11] ==  PASS_END_CORE[1] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                                
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                           
                            end
                            8'd5: begin
                                if(character[11] ==  PASS_END_CORE[5] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];  character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                                
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                           
                            end
                            8'd9: begin
                                if(character[11] ==  PASS_END_CORE[9] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                                
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                           
                            end
                            8'd13: begin
                                if(character[11] ==  PASS_END_CORE[13] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd11; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];end                                
                            end
                          endcase         
                          brute_force_mode_state <= POINTER;                   
                      end	          
                      8'd11: begin
                          case(brute_force_mode_count_fifo_reg)
                            8'd0: begin
                                if(character[11] == PASS_END_CORE[0] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[0]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                           
                            end
                            8'd1: begin
                                if(character[11] ==  PASS_END_CORE[1] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[1]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                                
                            end
                            8'd2: begin
                                if(character[11] == PASS_END_CORE[2] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[2]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd3: begin 
                                if(character[11] == PASS_END_CORE[3] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[3]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                                
                            end
                            8'd4: begin
                                if(character[11] == PASS_END_CORE[4] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[4]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                           
                            end
                            8'd5: begin
                                if(character[11] ==  PASS_END_CORE[5] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[5]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                                
                            end
                            8'd6: begin
                                if(character[11] == PASS_END_CORE[6] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[6]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd7: begin 
                                if(character[11] == PASS_END_CORE[7] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[7]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0];  character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                                
                            end
                            8'd8: begin
                                if(character[11] == PASS_END_CORE[8] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[8]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                           
                            end
                            8'd9: begin
                                if(character[11] ==  PASS_END_CORE[9] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[9]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                                
                            end
                            8'd10: begin
                                if(character[11] == PASS_END_CORE[10] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[10]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                                 
                            end
                            8'd11: begin 
                                if(character[11] == PASS_END_CORE[11] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[11]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                                
                            end
                            8'd12: begin
                                if(character[11] == PASS_END_CORE[12] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[12]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                           
                            end
                            8'd13: begin
                                if(character[11] ==  PASS_END_CORE[13] && character[10] == PASS_END_CORE[13] && character[9] == PASS_END_CORE[13] && character[8] == PASS_END_CORE[13] && character[7] == PASS_END_CORE[13] && character[6] == PASS_END_CORE[13] && character[5] == PASS_END_CORE[13] && character[4] == PASS_END_CORE[13] && character[3] == PASS_END_CORE[13] && character[2] == PASS_END_CORE[13] && character[1] == PASS_END_CORE[13] && character[0] == PASS_END_CORE[13]) 
                                begin count_character <= 8'd12; character[11] <= PASS_START_CORE[13]; character[10] <= PASS_START_CORE[0]; character[9]  <= PASS_START_CORE[0]; character[8]  <= PASS_START_CORE[0]; character[7]  <= PASS_START_CORE[0]; character[6]  <= PASS_START_CORE[0]; character[5]  <= PASS_START_CORE[0]; character[4]  <= PASS_START_CORE[0]; character[3] <= PASS_START_CORE[0];  character[2]  <= PASS_START_CORE[0]; character[1]  <= PASS_START_CORE[0];  character[0]  <= PASS_START_CORE[0];end                                
                            end
                          endcase    
                          brute_force_mode_state <= POINTER;                      	          
                      end
                  endcase
                end                	                    
            
            POINTER: begin /* Calculator pointer of password generating */
                case(MAX_LENGTH_PASSWORD - (count_character + 1))
                    8'd0: begin
                        pointer   <= 4'd0;
                        brute_force_mode_state   <= CHARACTER_GEN;                  
                    end
                    8'd1: begin
                        pointer   <= 4'd1;
                        brute_force_mode_state   <= CHARACTER_GEN; 
                    end
                    8'd2: begin
                        pointer   <= 4'd2;
                        brute_force_mode_state   <= CHARACTER_GEN; 
                    end
                    8'd3: begin
                        pointer   <= 4'd3;
                        brute_force_mode_state   <= CHARACTER_GEN;                
                    end
                    8'd4: begin
                        pointer   <= 4'd4;
                        brute_force_mode_state   <= CHARACTER_GEN;               
                    end 
                    8'd5: begin
                        pointer   <= 4'd5;
                        brute_force_mode_state   <= CHARACTER_GEN;                  
                    end  
                    8'd6: begin
                        pointer   <= 4'd6;
                        brute_force_mode_state   <= CHARACTER_GEN;                    
                    end 
                    8'd7: begin
                        pointer   <= 4'd7;
                        brute_force_mode_state   <= CHARACTER_GEN;
                    end 
                    8'd8: begin
                        pointer   <= 4'd8;
                        brute_force_mode_state   <= CHARACTER_GEN;                 
                    end  
                    8'd9: begin
                        pointer   <= 4'd9;
                        brute_force_mode_state   <= CHARACTER_GEN;                
                    end
                    8'd10: begin
                        pointer   <= 4'd10;
                        brute_force_mode_state   <= CHARACTER_GEN;                
                    end  
                    8'd11: begin
                        brute_force_mode_state   <= CHARACTER_FIN;               
                    end                                                                                                                                                       
                endcase
            end

            CHARACTER_GEN: begin 
                case(brute_force_mode_char_range_reg)
                    5'd1:  begin brute_force_mode_state <= CHARACTER_GEN_RG_1; end
                    5'd2:  begin brute_force_mode_state <= CHARACTER_GEN_RG_2; end
                    5'd3:  begin brute_force_mode_state <= CHARACTER_GEN_RG_3; end
                    5'd4:  begin brute_force_mode_state <= CHARACTER_GEN_RG_4; end
                    5'd5:  begin brute_force_mode_state <= CHARACTER_GEN_RG_5; end
                    5'd6:  begin brute_force_mode_state <= CHARACTER_GEN_RG_6; end
                    5'd7:  begin brute_force_mode_state <= CHARACTER_GEN_RG_7; end
                    5'd8:  begin brute_force_mode_state <= CHARACTER_GEN_RG_8; end   
                    5'd9:  begin brute_force_mode_state <= CHARACTER_GEN_RG_9; end 
                    5'd10: begin brute_force_mode_state <= CHARACTER_GEN_RG_10; end 
                    5'd11: begin brute_force_mode_state <= CHARACTER_GEN_RG_11; end 
                    5'd12: begin brute_force_mode_state <= CHARACTER_GEN_RG_12; end 
                    5'd13: begin brute_force_mode_state <= CHARACTER_GEN_RG_13; end 
                    5'd14: begin brute_force_mode_state <= CHARACTER_GEN_RG_14; end 
                    5'd15: begin brute_force_mode_state <= CHARACTER_GEN_RG_15; end 
                    5'd16: begin brute_force_mode_state <= CHARACTER_GEN_RG_16; end 
                    5'd17: begin brute_force_mode_state <= CHARACTER_GEN_RG_17; end  
                    5'd18: begin brute_force_mode_state <= CHARACTER_GEN_RG_18; end 
                    5'd19: begin brute_force_mode_state <= CHARACTER_GEN_RG_19; end 
                    5'd20: begin brute_force_mode_state <= CHARACTER_GEN_RG_20; end 
                    5'd21: begin brute_force_mode_state <= CHARACTER_GEN_RG_21; end     
                    5'd22: begin brute_force_mode_state <= CHARACTER_GEN_RG_22; end 
                    5'd23: begin brute_force_mode_state <= CHARACTER_GEN_RG_23; end 
                    5'd24: begin brute_force_mode_state <= CHARACTER_GEN_RG_24; end 
                    5'd25: begin brute_force_mode_state <= CHARACTER_GEN_RG_25; end 
                    5'd26: begin brute_force_mode_state <= CHARACTER_GEN_RG_26; end 
                    5'd27: begin brute_force_mode_state <= CHARACTER_GEN_RG_27; end 
                    5'd28: begin brute_force_mode_state <= CHARACTER_GEN_RG_28; end 
                    5'd29: begin brute_force_mode_state <= CHARACTER_GEN_RG_29; end 
                    5'd30: begin brute_force_mode_state <= CHARACTER_GEN_RG_30; end 
                endcase
            end

            CHARACTER_GEN_RG_1: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7a: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_1;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_2: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5a: begin
                        character[pointer] <= 8'h41;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_2;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_3: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7a: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5a: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_3;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_4: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h39: begin
                        character[pointer] <= 8'h30;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_4;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_5: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7a: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h39: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_5;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_6: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5a: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h39: begin
                        character[pointer] <= 8'h41;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_6;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_7: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7a: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5a: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end                          
                    8'h39: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_7;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_8: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h21;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_8;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_9: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7A: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_9;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_10: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5A: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h41;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_10;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_11: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7A: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h5A: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_11;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_12: begin
                case(character[pointer])  
                    8'h00: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end                
                    8'h39: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h30;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_12;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_13: begin
                case(character[pointer]) 
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7A: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end                                        
                    8'h39: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_13;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_14: begin
                case(character[pointer]) 
                    8'h00: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5A: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end                                        
                    8'h39: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h41;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_14;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_15: begin
                case(character[pointer]) 
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7A: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h5A: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end                                                                 
                    8'h39: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_15;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_16: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7a: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_16;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_17: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5a: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h41;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_17;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_18: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7a: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5a: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end                          
                    8'h20: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_18;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_19: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h39: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h30;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_19;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_20: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7A: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h39: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end                          
                    8'h20: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_20;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                  
            end

            CHARACTER_GEN_RG_21: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5A: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h39: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end                          
                    8'h20: begin
                        character[pointer] <= 8'h41;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_21;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                 
            end

            CHARACTER_GEN_RG_22: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7A: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h5A: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h39: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end                          
                    8'h20: begin
                        character[pointer] <= 8'h41;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_22;
                    end
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                 
            end

            CHARACTER_GEN_RG_23: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h21;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_23;
                    end                          
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_24: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7A: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_24;
                    end                          
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_25: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5A: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h41;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_25;
                    end                          
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_26: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7A: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end                        
                    8'h5A: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_26;
                    end                          
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_27: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h39: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h30;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_27;
                    end                          
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_28: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7A: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end                        
                    8'h39: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_28;
                    end                          
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_29: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h5A: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end                        
                    8'h39: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h41;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_29;
                    end                          
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_GEN_RG_30: begin
                case(character[pointer])
                    8'h00: begin
                        character[pointer] <= 8'h61;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h7A: begin
                        character[pointer] <= 8'h41;
                        brute_force_mode_state <= EXPORT;
                    end                        
                    8'h5A: begin
                        character[pointer] <= 8'h30;
                        brute_force_mode_state <= EXPORT;
                    end                        
                    8'h39: begin
                        character[pointer] <= 8'h21;
                        brute_force_mode_state <= EXPORT;
                    end                      
                    8'h2F: begin
                        character[pointer] <= 8'h3A;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h40: begin
                        character[pointer] <= 8'h5B;
                        brute_force_mode_state <= EXPORT;
                    end  
                    8'h60: begin
                        character[pointer] <= 8'h7B;
                        brute_force_mode_state <= EXPORT;
                    end                                                   
                    8'h7E: begin
                        character[pointer] <= 8'h20;
                        brute_force_mode_state <= EXPORT;
                    end
                    8'h20: begin
                        character[pointer] <= 8'h61;
                        pointer <= pointer + 1;
                        brute_force_mode_state <= CHARACTER_GEN_RG_30;
                    end                          
                    default: begin
                    if(pass_start_flag == 1'b0)
                    begin
                        character[pointer] <= character[pointer] + 1'b1; 
                    end 
                    else
                    begin
                        pass_start_flag <= 1'b0;
                        character[pointer] <= character[pointer];
                    end
                    brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_FIN: begin
                case (brute_force_mode_count_fifo_reg)
                    8'd0:  begin brute_force_mode_state <= CHARACTER_FIN_RG_0; end
                    8'd1:  begin brute_force_mode_state <= CHARACTER_FIN_RG_1; end
                    8'd2:  begin brute_force_mode_state <= CHARACTER_FIN_RG_2; end
                    8'd3:  begin brute_force_mode_state <= CHARACTER_FIN_RG_3; end
                    8'd4:  begin brute_force_mode_state <= CHARACTER_FIN_RG_4; end
                    8'd5:  begin brute_force_mode_state <= CHARACTER_FIN_RG_5; end
                    8'd6:  begin brute_force_mode_state <= CHARACTER_FIN_RG_6; end
                    8'd7:  begin brute_force_mode_state <= CHARACTER_FIN_RG_7; end
                    8'd8:  begin brute_force_mode_state <= CHARACTER_FIN_RG_8; end
                    8'd9:  begin brute_force_mode_state <= CHARACTER_FIN_RG_9; end
                    8'd10: begin brute_force_mode_state <= CHARACTER_FIN_RG_10; end
                    8'd11: begin brute_force_mode_state <= CHARACTER_FIN_RG_11; end
                    8'd12: begin brute_force_mode_state <= CHARACTER_FIN_RG_12; end
                    8'd13: begin brute_force_mode_state <= CHARACTER_FIN_RG_13; end
                endcase
            end

            CHARACTER_FIN_RG_0: begin
                case(character[11])
                    PASS_END_CORE[0]: begin
                        brute_force_mode_state <= EXPORT;
                    end
                    default: begin
                        if(pass_start_flag == 1'b0)
                        begin
                            character[11] <= character[11] + 1'b1; 
                        end 
                        else
                        begin
                            pass_start_flag <= 1'b0;
                            character[11] <= character[11];
                        end
                        brute_force_mode_state <= EXPORT;                    	      
                    end
                endcase                
            end

            CHARACTER_FIN_RG_1: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= character[11] + 1'b1; 
                            end 
                            else
                            begin
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11];
                            end
                            brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_END_CORE[1]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                 
            end

            CHARACTER_FIN_RG_2: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])                           
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])                          
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])                      
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])                             
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])                           
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_END_CORE[2]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                
            end

            CHARACTER_FIN_RG_3: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])                        
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_9:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_Cthan;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end                              
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                                character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])                             
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])                             
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])                                   
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])                           
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])                           
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])                         
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])                           
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11]) 
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])                               
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])                                 
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])                                                            
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_9:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_Cthan;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                                character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])                             
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])                              
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])                                    
                        PASS_END_CORE[3]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                
            end

            CHARACTER_FIN_RG_4: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_A;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                                character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_A;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_A;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_A;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[4]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                 
            end

            CHARACTER_FIN_RG_5: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end


                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_0;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_Z:  begin
                            character[11] <= PASS_0;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_0;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_Z:  begin
                            character[11] <= PASS_0;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_END_CORE[5]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                 
            end

            CHARACTER_FIN_RG_6: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_A;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_Z:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_A;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_Z:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_END_CORE[6]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                 
            end

            CHARACTER_FIN_RG_7: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_A;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_9:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_9:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_A;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_Xiec)
                            //     character[11] <= PASS_2cham;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_9:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_9:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_END_CORE[7]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_Z)
                            //     character[11] <= PASS_0;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                
            end

            CHARACTER_FIN_RG_8: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_Z:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_Xiec:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_2cham;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_Z:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_Xiec:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_2cham;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_END_CORE[8]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                
            end

            CHARACTER_FIN_RG_9: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_9:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_9:  begin
                            character[11] <= PASS_Cthan;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[9]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                
            end

            CHARACTER_FIN_RG_10: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_z)
                            //     character[11] <= PASS_0;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_Z)
                            //     character[11] <= PASS_0;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_Ac)
                            //     character[11] <= PASS_NgoacV;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_Xiec:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_2cham;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
//                                        if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_Xiec:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_2cham;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_Ac:  begin
                            character[11] <= PASS_NgoacV;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_Xiec:  begin
                            character[11] <=PASS_2cham;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_Xiec:  begin
                            character[11] <= PASS_2cham;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_z)
                            //     character[11] <= PASS_0;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_Z)
                            //     character[11] <= PASS_0;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_Ac)
                            //     character[11] <= PASS_NgoacV;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_Xiec:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_2cham;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_Xiec:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_2cham;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_Ac:  begin
                            character[11] <= PASS_NgoacV;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_Xiec:  begin
                            character[11] <= PASS_2cham;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_Xiec:  begin
                            character[11] <= PASS_2cham;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_END_CORE[10]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                
            end

            CHARACTER_FIN_RG_11: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_Xiec:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_2cham;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_Xiec)
                            //     character[11] <= PASS_2cham;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_Z)
                            //     character[11] <= PASS_0;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              
                            // if(character[11] == PASS_Ac)
                            //     character[11] <= PASS_NgoacV;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_Xiec:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_2cham;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              
                            // if(character[11] == PASS_Ac)
                            //     character[11] <= PASS_NgoacV;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              
                            // if(character[11] == PASS_Xiec)
                            //     character[11] <= PASS_2cham;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_END_CORE[11]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              
                            // if(character[11] == PASS_Xiec)
                            //     character[11] <= PASS_2cham;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                  
            end

            CHARACTER_FIN_RG_12: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_NgoacD2)
                            //     character[11] <= PASS_NgoacN;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_Ac:  begin
                            character[11] <=PASS_NgoacV;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_NgoacD2:  begin
                            character[11] <= PASS_NgoacN;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_Ac:  begin
                            character[11] <= PASS_NgoacV;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_NgoacD2)
                            //     character[11] <= PASS_NgoacN;
                            // else
                              character[11] <= character[11] + 1'b1;
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_Ac:  begin
                            character[11] <= PASS_NgoacV;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_NgoacD2:  begin
                            character[11] <= PASS_NgoacN;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                            // if(character[11] == PASS_Ngax)
                            //     character[11] <= PASS_SPACE;
                            // else
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_Ac:  begin
                            character[11] <= PASS_NgoacV;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[12]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                 
            end

            CHARACTER_FIN_RG_13: begin
                case(brute_force_mode_char_range_reg)
                5'd1: begin   //lowercase
                    case(character[11])
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd2: begin   //uppercase
                    case(character[11])
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd3: begin   // lowercase + uppercase
                    case(character[11])
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd4: begin   // Digits
                    case(character[11])
                        PASS_END_CORE[13]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd5: begin   //lowercase + Digits
                    case(character[11])
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd6: begin   //uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd7: begin   //lowercase + uppercase + Digits
                    case(character[11])
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd8: begin   //symbolds
                    case(character[11])
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd9: begin   //lowercase + symbolds
                    case(character[11])
                        PASS_NgoacD2:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_NgoacN;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd10: begin  //uppercase + symbolds
                    case(character[11])
                        PASS_NgoacD2:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_NgoacN;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd11: begin  //lowercase + uppercase + symboilds
                    case(character[11])
                        PASS_NgoacD2:  begin
                            character[11] <= PASS_NgoacN;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd12: begin  //Digits + symboilds
                    case(character[11])
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd13: begin  //lowercase + Digits + symboilds
                    case(character[11])
                        PASS_NgoacD2:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_NgoacN;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd14: begin  //uppercase + Digits + symboilds
                    case(character[11])
                        PASS_NgoacD2:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_NgoacN;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd15: begin  //lowercase + uppercase + Digits + symboilds
                    case(character[11])
                        PASS_NgoacD2:  begin
                            character[11] <= PASS_NgoacN;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= character[11] + 1'b1; 
                            end 
                            else
                            begin
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11];
                            end
                            brute_force_mode_state <= EXPORT;                    	      
                            end
                    endcase
                end

                5'd16: begin  //lowercase + space
                    case(character[11])
                        PASS_z:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd17: begin  //uppercase + space
                    case(character[11])
                        PASS_Z:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd18: begin  //lowercase + uppercase + space
                    case(character[11])
                       PASS_Z:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd19: begin  //Digits + space
                    case(character[11])
                        PASS_END_CORE[13]: begin
                            if(pass_start_flag == 1'b1) pass_start_flag <= 1'b0;
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd20: begin  //lowercase + Digits + space
                    case(character[11])
                        PASS_9: begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase   
                end

                5'd21: begin  //uppercase + Digits + space
                    case(character[11])
                        PASS_9: begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd22: begin  //lowercase + uppercase + Digits + space
                    case(character[11])
                        PASS_9: begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase 
                end

                5'd23: begin  //symboilds + space
                    case(character[11])
                        PASS_Ngax:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd24: begin  //lowercase + symboilds + space
                    case(character[11])
                        PASS_NgoacD2:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_NgoacN;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end   
                        PASS_Ngax:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd25: begin  //uppercase + syboilds + space
                    case(character[11])
                        PASS_NgoacD2:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_NgoacN;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end    
                        PASS_Ngax:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd26: begin  //lowercase + uppercase + symboilds + space
                    case(character[11])
                        PASS_NgoacD2:  begin
                            character[11] <= PASS_NgoacN;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_Ngax:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd27: begin  //Digits + symboilds + space
                    case(character[11])
                        PASS_Ngax:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd28: begin  //lowercase + Digits + symboilds + space
                    case(character[11])
                        PASS_NgoacD2:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_NgoacN;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_Ngax:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd29: begin  //uppercase + Digits + symboilds + space
                    case(character[11])
                        PASS_NgoacD2:  begin
                            if(pass_start_flag == 1'b0)
                            begin
                                character[11] <= PASS_NgoacN;
                            end
                            else begin  
                                pass_start_flag <= 1'b0;
                                character[11] <= character[11]; 
                            end    
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_Ngax:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end

                5'd30: begin  //lowercase + uppercase + Digits + symboild + space
                    case(character[11])
                        PASS_NgoacD2:  begin
                            character[11] <= PASS_NgoacN;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_Ngax:  begin
                            character[11] <= PASS_SPACE;
                            brute_force_mode_state <= EXPORT;
                        end  
                        PASS_END_CORE[13]: begin
                            brute_force_mode_state <= EXPORT;
                        end
                        default: begin
                          if(pass_start_flag == 1'b0)
                          begin
                              character[11] <= character[11] + 1'b1; 
                          end 
                          else
                          begin
                              pass_start_flag <= 1'b0;
                              character[11] <= character[11];
                          end
                          brute_force_mode_state <= EXPORT;                    	      
                        end
                    endcase
                end
              endcase                
            end
              
          default: brute_force_mode_state <= IDLE;		         
          endcase          
        end
    end
end

always @(*)
begin
    if(brute_force_mode_state == EXPORT)
    begin
        case(i_hybrid_in_brute_force_en)
            1'b0: begin
                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0,character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};           
            end    
        
            1'b1: begin
                case(i_brute_force_mode_position)
                    1'b0: begin
                        case(i_hybrid_mode_length_know_gen)
                            8'd0: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0,character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};   
                            end
                            8'd1: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0,character[3], 8'd0, character[2], 8'd0, character[1], 8'd0};
                            end
                            8'd2: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0,character[3], 8'd0, character[2], 8'd0};
                            end
                            8'd3: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0, character[3], 8'd0};
                            end 
                            8'd4: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0};
                            end
                            8'd5: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0};
                            end
                            8'd6: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0};               
                            end
                            8'd7: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, i_hybrid_mode_pass_offset[47:40], 8'd0, character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0};                
                            end
                            8'd8: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, i_hybrid_mode_pass_offset[47:40], 8'd0, i_hybrid_mode_pass_offset[39:32], 8'd0, character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0};            
                            end
                            8'd9: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, i_hybrid_mode_pass_offset[47:40], 8'd0, i_hybrid_mode_pass_offset[39:32], 8'd0, i_hybrid_mode_pass_offset[31:24], 8'd0, character[11], 8'd0, character[10], 8'd0, character[9], 8'd0};                  
                            end
                            8'd10: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, i_hybrid_mode_pass_offset[47:40], 8'd0, i_hybrid_mode_pass_offset[39:32], 8'd0, i_hybrid_mode_pass_offset[31:24], 8'd0, i_hybrid_mode_pass_offset[23:16], 8'd0, character[11], 8'd0, character[10], 8'd0};                
                            end
                            8'd11: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, i_hybrid_mode_pass_offset[47:40], 8'd0, i_hybrid_mode_pass_offset[39:32], 8'd0, i_hybrid_mode_pass_offset[31:24], 8'd0, i_hybrid_mode_pass_offset[23:16], 8'd0, i_hybrid_mode_pass_offset[15:8], 8'd0, character[11], 8'd0};                
                            end
                            8'd12: begin
                                password_final = {i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0,
                                                  i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, 
                                                  i_hybrid_mode_pass_offset[47:40], 8'd0, i_hybrid_mode_pass_offset[39:32], 8'd0, i_hybrid_mode_pass_offset[31:24], 8'd0,
                                                  i_hybrid_mode_pass_offset[23:16], 8'd0, i_hybrid_mode_pass_offset[15:8], 8'd0, i_hybrid_mode_pass_offset[7:0], 8'd0};                
                            end
                        endcase                   
                    end
                    
                    1'b1: begin
                        case(count_character)
                            8'd0: begin
                                password_final = {character[11], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, i_hybrid_mode_pass_offset[47:40], 8'd0, i_hybrid_mode_pass_offset[39:32], 8'd0, i_hybrid_mode_pass_offset[31:24], 8'd0, i_hybrid_mode_pass_offset[23:16], 8'd0, i_hybrid_mode_pass_offset[15:8], 8'd0};                      
                            end
                            8'd1: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, i_hybrid_mode_pass_offset[47:40], 8'd0, i_hybrid_mode_pass_offset[39:32], 8'd0, i_hybrid_mode_pass_offset[31:24], 8'd0, i_hybrid_mode_pass_offset[23:16], 8'd0};                           
                            end
                            8'd2: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, i_hybrid_mode_pass_offset[47:40], 8'd0, i_hybrid_mode_pass_offset[39:32], 8'd0, i_hybrid_mode_pass_offset[31:24], 8'd0};                       
                            end
                            8'd3: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, i_hybrid_mode_pass_offset[47:40], 8'd0, i_hybrid_mode_pass_offset[39:32], 8'd0};                       
                            end
                            8'd4: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0, i_hybrid_mode_pass_offset[47:40], 8'd0};                                               
                            end
                            8'd5: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0, i_hybrid_mode_pass_offset[55:48], 8'd0};                                                                       
                            end
                            8'd6: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0, i_hybrid_mode_pass_offset[63:56], 8'd0};                                                                                               
                            end
                            8'd7: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0, i_hybrid_mode_pass_offset[71:64], 8'd0};                                                                                                                       
                            end
                            8'd8: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0, i_hybrid_mode_pass_offset[79:72], 8'd0};                                                                                                                                               
                            end
                            8'd9: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0, i_hybrid_mode_pass_offset[87:80], 8'd0};                                                                                                                                                                       
                            end
                            8'd10: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, i_hybrid_mode_pass_offset[95:88], 8'd0};                                                                                                                                                                                               
                            end
                            8'd11: begin
                                password_final = {character[11], 8'd0, character[10], 8'd0, character[9], 8'd0, character[8], 8'd0, character[7], 8'd0, character[6], 8'd0, character[5], 8'd0, character[4], 8'd0, character[3], 8'd0, character[2], 8'd0, character[1], 8'd0, character[0], 8'd0};                                                                                                                                                                                                                       
                            end
                        endcase
                    end
                endcase
            end

            default: begin
                password_final = 192'd0;
            end
        endcase
   end
end
																																								
assign o_brute_force_mode_length        = (i_hybrid_in_brute_force_en == 1'b1) ? ((count_character + 1 + i_hybrid_mode_length_know_gen)*8*2) : ((count_character + 1)*8*2);
assign o_brute_force_mode_pass          = password_final;
assign o_brute_force_mode_pass_valid    = password_valid;
assign o_brute_force_mode_outside_pass  = pass_outside;

/* Display FMS simualator */
reg [8*20-1:0] state_display;
always @(*)
begin
	case (brute_force_mode_state)
        IDLE:                 state_display = "IDLE";
        RECV:                 state_display = "RECV";
        RECV_1:               state_display = "RECV_1";
        RECV_2:               state_display = "RECV_2";
        EXPORT:	              state_display = "EXPORT";
        CHARACTER_GEN:        state_display = "CHARACTER_GEN";
        CHARACTER_GEN_RG_1:   state_display = "CHARACTER_GEN_RG_1";
        CHARACTER_GEN_RG_2:   state_display = "CHARACTER_GEN_RG_2";
        CHARACTER_GEN_RG_3:   state_display = "CHARACTER_GEN_RG_3";
        CHARACTER_GEN_RG_4:   state_display = "CHARACTER_GEN_RG_4";
        CHARACTER_GEN_RG_5:   state_display = "CHARACTER_GEN_RG_5";
        CHARACTER_GEN_RG_6:   state_display = "CHARACTER_GEN_RG_6";
        CHARACTER_GEN_RG_7:   state_display = "CHARACTER_GEN_RG_7";
        CHARACTER_GEN_RG_8:   state_display = "CHARACTER_GEN_RG_8";
        CHARACTER_GEN_RG_9:   state_display = "CHARACTER_GEN_RG_9";
        CHARACTER_GEN_RG_10:  state_display = "CHARACTER_GEN_RG_10";
        CHARACTER_GEN_RG_11:  state_display = "CHARACTER_GEN_RG_11";
        CHARACTER_GEN_RG_12:  state_display = "CHARACTER_GEN_RG_12";
        CHARACTER_GEN_RG_13:  state_display = "CHARACTER_GEN_RG_13";
        CHARACTER_GEN_RG_14:  state_display = "CHARACTER_GEN_RG_14";
        CHARACTER_GEN_RG_15:  state_display = "CHARACTER_GEN_RG_15";
        CHARACTER_GEN_RG_16:  state_display = "CHARACTER_GEN_RG_16";
        CHARACTER_GEN_RG_17:  state_display = "CHARACTER_GEN_RG_17";
        CHARACTER_GEN_RG_18:  state_display = "CHARACTER_GEN_RG_18";
        CHARACTER_GEN_RG_19:  state_display = "CHARACTER_GEN_RG_19";
        CHARACTER_GEN_RG_20:  state_display = "CHARACTER_GEN_RG_20";
        CHARACTER_GEN_RG_21:  state_display = "CHARACTER_GEN_RG_21";
        CHARACTER_GEN_RG_22:  state_display = "CHARACTER_GEN_RG_22";
        CHARACTER_GEN_RG_23:  state_display = "CHARACTER_GEN_RG_23";
        CHARACTER_GEN_RG_24:  state_display = "CHARACTER_GEN_RG_24";
        CHARACTER_GEN_RG_25:  state_display = "CHARACTER_GEN_RG_25";
        CHARACTER_GEN_RG_26:  state_display = "CHARACTER_GEN_RG_26";
        CHARACTER_GEN_RG_27:  state_display = "CHARACTER_GEN_RG_27";
        CHARACTER_GEN_RG_28:  state_display = "CHARACTER_GEN_RG_28";
        CHARACTER_GEN_RG_29:  state_display = "CHARACTER_GEN_RG_29";
        CHARACTER_GEN_RG_30:  state_display = "CHARACTER_GEN_RG_30";
        CHARACTER_FIN:        state_display = "CHARACTER_FIN";
        CHARACTER_FIN_RG_0:   state_display = "CHARACTER_FIN_RG_0";        
        CHARACTER_FIN_RG_1:   state_display = "CHARACTER_FIN_RG_1";  
        CHARACTER_FIN_RG_2:   state_display = "CHARACTER_FIN_RG_2";
        CHARACTER_FIN_RG_3:   state_display = "CHARACTER_FIN_RG_3";
        CHARACTER_FIN_RG_4:   state_display = "CHARACTER_FIN_RG_4";
        CHARACTER_FIN_RG_5:   state_display = "CHARACTER_FIN_RG_5";
        CHARACTER_FIN_RG_6:   state_display = "CHARACTER_FIN_RG_6";
        CHARACTER_FIN_RG_7:   state_display = "CHARACTER_FIN_RG_7";
        CHARACTER_FIN_RG_8:   state_display = "CHARACTER_FIN_RG_8";
        CHARACTER_FIN_RG_9:   state_display = "CHARACTER_FIN_RG_9";
        CHARACTER_FIN_RG_10:  state_display = "CHARACTER_FIN_RG_1"; 
        CHARACTER_FIN_RG_11:  state_display = "CHARACTER_FIN_RG_1"; 
        CHARACTER_FIN_RG_12:  state_display = "CHARACTER_FIN_RG_1"; 
        CHECK_BRUTE:          state_display = "CHECK_BRUTE";
        ROUND_GEN:            state_display = "ROUND_GEN";
        POINTER:              state_display = "POINTER";
        INITIAL_BRUTE:        state_display = "INITIAL_BRUTE";
	endcase
end
    
endmodule
