`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2022 04:06:09 AM
// Design Name: 
// Module Name: pass_gen_top
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
module pass_gen_top #
(
	parameter NUMBER_CORE_GEN = 8'd14,
	parameter MAX_LENGTH_PASSWORD = 8'd12
)
(
    input wire          i_pass_gen_top_clk,
    input wire          i_pass_gen_top_rst,
    input wire          i_pass_gen_top_load_en,
    input wire          i_pass_gen_top_start_en,
    input wire [1:0]    i_pass_gen_top_mode,
    input wire          i_hybrid_in_brute_force_en,
    input wire [7:0]    i_pass_gen_top_length_gen,
    input wire [95:0]   i_pass_gen_top_pass_offset,
    input wire [7:0]    i_pass_gen_top_length_know_gen,
    input wire          i_pass_gen_top_position,
    input wire [95:0]   i_pass_gen_top_pass_in,     /* Password index for dictionary mode */
    input wire          i_pass_gen_top_pass_valid,   /* Password index for dictionary mode */
    input wire          i_pass_gen_top_pause,

    input wire [95:0]   i_pass_gen_top_dict_rule,
    input wire [191:0]  i_pass_gen_top_dict_rule_value,    
    
    input wire [7:0]    i_pass_gen_top_valid_0,
    input wire [7:0]    i_pass_gen_top_valid_1,
    input wire [7:0]    i_pass_gen_top_valid_2,
    input wire [7:0]    i_pass_gen_top_valid_3,
    input wire [7:0]    i_pass_gen_top_valid_4,
    input wire [7:0]    i_pass_gen_top_valid_5,
    input wire [7:0]    i_pass_gen_top_valid_6,
    input wire [7:0]    i_pass_gen_top_valid_7,
    input wire [7:0]    i_pass_gen_top_valid_8,
    input wire [7:0]    i_pass_gen_top_valid_9,
    input wire [7:0]    i_pass_gen_top_valid_10,
    input wire [7:0]    i_pass_gen_top_valid_11, 
    input wire [7:0]    i_pass_gen_top_valid_12,
    input wire [7:0]    i_pass_gen_top_valid_13, 
    // input wire [7:0]    i_pass_gen_top_valid_14,
    // input wire [7:0]    i_pass_gen_top_valid_15,
    // input wire [7:0]    i_pass_gen_top_valid_16,
    // input wire [7:0]    i_pass_gen_top_valid_17,
    // input wire [7:0]    i_pass_gen_top_valid_18,
    // input wire [7:0]    i_pass_gen_top_valid_19,
    // input wire [7:0]    i_pass_gen_top_valid_20,
    // input wire [7:0]    i_pass_gen_top_valid_21, 
    // input wire [7:0]    i_pass_gen_top_valid_22,
    // input wire [7:0]    i_pass_gen_top_valid_23, 
    // input wire [7:0]    i_pass_gen_top_valid_24,
    // input wire [7:0]    i_pass_gen_top_valid_25,
    // input wire [7:0]    i_pass_gen_top_valid_26,
    // input wire [7:0]    i_pass_gen_top_valid_27,
    // input wire [7:0]    i_pass_gen_top_valid_28,
    // input wire [7:0]    i_pass_gen_top_valid_29,
    // input wire [7:0]    i_pass_gen_top_valid_30,
    // input wire [7:0]    i_pass_gen_top_valid_31, 
    // input wire [7:0]    i_pass_gen_top_valid_32,
    // input wire [7:0]    i_pass_gen_top_valid_33, 
    // input wire [7:0]    i_pass_gen_top_valid_34,
    // input wire [7:0]    i_pass_gen_top_valid_35,
    // input wire [7:0]    i_pass_gen_top_valid_36,
    // input wire [7:0]    i_pass_gen_top_valid_37,
    // input wire [7:0]    i_pass_gen_top_valid_38,
//    input wire [7:0]    i_pass_gen_top_valid_39,
//    input wire [7:0]    i_pass_gen_top_valid_40,
//    input wire [7:0]    i_pass_gen_top_valid_41, 
    
    input wire          i_pass_gen_top_pass_again_flag,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_0,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_1,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_2,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_3,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_4,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_5,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_6,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_7,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_8,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_9,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_10,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_11,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_12,
    input wire [95:0]   i_pass_gen_top_pass_again_regions_13,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_14,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_15,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_16,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_17,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_18,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_19,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_20,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_21,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_22,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_23,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_24,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_25,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_26,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_27,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_28,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_29,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_30,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_31,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_32,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_33,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_34,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_35,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_36,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_37,
    // input wire [95:0]   i_pass_gen_top_pass_again_regions_38,
//    input wire [95:0]   i_pass_gen_top_pass_again_regions_39,
//    input wire [95:0]   i_pass_gen_top_pass_again_regions_40,
//    input wire [95:0]   i_pass_gen_top_pass_again_regions_41,

    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_0,
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_1,
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_2,
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_3,  
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_4,
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_5,
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_6,
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_7,  
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_8,
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_9,
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_10,
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_11,  
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_12,
    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_13,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_14,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_15,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_16,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_17,  
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_18,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_19,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_20,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_21,  
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_22,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_23,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_24,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_25,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_26,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_27,  
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_28,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_29,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_30,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_31,  
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_32,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_33,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_34,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_35,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_36,
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_37,  
    // input wire [7:0]    i_pass_gen_top_length_pass_again_regions_38,
//    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_39,
//    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_40,
//    input wire [7:0]    i_pass_gen_top_length_pass_again_regions_41,  
    
    input wire [7:0]    i_pass_gen_top_length_minimum, 
    
    input wire [4:0]    i_range_character_set,
    
    input wire [11:0]   i_mask_attack_bit,
    input wire [96 : 0] i_mask_attack_pass_set,
    input wire [7 : 0]  i_mask_attack_length_pass_set,    
    
    output wire         dictionary_export_done,
    
    output wire [63:0]  o_pass_gen_top_countert_analysted,
    
    output wire         o_pass_gen_top_fifo_empty,
    output wire         o_pass_gen_top_fifo_empty_1,
    output wire         o_pass_gen_top_fifo_empty_2,
    output wire         o_pass_gen_top_fifo_empty_3,
    output wire         o_pass_gen_top_fifo_empty_4,
    output wire         o_pass_gen_top_fifo_empty_5,
    output wire         o_pass_gen_top_fifo_empty_6,
    output wire         o_pass_gen_top_fifo_empty_7,
    output wire         o_pass_gen_top_fifo_empty_8,
    output wire         o_pass_gen_top_fifo_empty_9,
    output wire         o_pass_gen_top_fifo_empty_10,
    output wire         o_pass_gen_top_fifo_empty_11,
    output wire         o_pass_gen_top_fifo_empty_12,
    output wire         o_pass_gen_top_fifo_empty_13,
    // output wire         o_pass_gen_top_fifo_empty_14,
    // output wire         o_pass_gen_top_fifo_empty_15,
    // output wire         o_pass_gen_top_fifo_empty_16,
    // output wire         o_pass_gen_top_fifo_empty_17,
    // output wire         o_pass_gen_top_fifo_empty_18,
    // output wire         o_pass_gen_top_fifo_empty_19,
    // output wire         o_pass_gen_top_fifo_empty_20,
    // output wire         o_pass_gen_top_fifo_empty_21,
    // output wire         o_pass_gen_top_fifo_empty_22,
    // output wire         o_pass_gen_top_fifo_empty_23,
    // output wire         o_pass_gen_top_fifo_empty_24,
    // output wire         o_pass_gen_top_fifo_empty_25,
    // output wire         o_pass_gen_top_fifo_empty_26,
    // output wire         o_pass_gen_top_fifo_empty_27,
    // output wire         o_pass_gen_top_fifo_empty_28,
    // output wire         o_pass_gen_top_fifo_empty_29,
    // output wire         o_pass_gen_top_fifo_empty_30,
    // output wire         o_pass_gen_top_fifo_empty_31,
    // output wire         o_pass_gen_top_fifo_empty_32,
    // output wire         o_pass_gen_top_fifo_empty_33,
    // output wire         o_pass_gen_top_fifo_empty_34,
    // output wire         o_pass_gen_top_fifo_empty_35,
    // output wire         o_pass_gen_top_fifo_empty_36,
    // output wire         o_pass_gen_top_fifo_empty_37,
    // output wire         o_pass_gen_top_fifo_empty_38,
//    output wire         o_pass_gen_top_fifo_empty_39,
//    output wire         o_pass_gen_top_fifo_empty_40,
//    output wire         o_pass_gen_top_fifo_empty_41,
    
    output wire         o_pass_gen_top_responde_valid,  /* Password index for dictionary mode */
         
    output wire [191:0] o_pass_gen_top_pass_0,
    output wire [31:0]  o_pass_gen_top_length_0,
    output wire         o_pass_gen_top_valid_0,  
    
    output wire [191:0] o_pass_gen_top_pass_1,
    output wire [31:0]  o_pass_gen_top_length_1,
    output wire         o_pass_gen_top_valid_1,  
    
    output wire [191:0] o_pass_gen_top_pass_2,
    output wire [31:0]  o_pass_gen_top_length_2,
    output wire         o_pass_gen_top_valid_2,   
    
    output wire [191:0] o_pass_gen_top_pass_3,
    output wire [31:0]  o_pass_gen_top_length_3,
    output wire         o_pass_gen_top_valid_3,
    
    output wire [191:0] o_pass_gen_top_pass_4,
    output wire [31:0]  o_pass_gen_top_length_4,
    output wire         o_pass_gen_top_valid_4,  
    
    output wire [191:0] o_pass_gen_top_pass_5,
    output wire [31:0]  o_pass_gen_top_length_5,
    output wire         o_pass_gen_top_valid_5,  
    
    output wire [191:0] o_pass_gen_top_pass_6,
    output wire [31:0]  o_pass_gen_top_length_6,
    output wire         o_pass_gen_top_valid_6,   
    
    output wire [191:0] o_pass_gen_top_pass_7,
    output wire [31:0]  o_pass_gen_top_length_7,
    output wire         o_pass_gen_top_valid_7,
    
    output wire [191:0] o_pass_gen_top_pass_8,
    output wire [31:0]  o_pass_gen_top_length_8,
    output wire         o_pass_gen_top_valid_8,  
    
    output wire [191:0] o_pass_gen_top_pass_9,
    output wire [31:0]  o_pass_gen_top_length_9,
    output wire         o_pass_gen_top_valid_9,  
    
    output wire [191:0] o_pass_gen_top_pass_10,
    output wire [31:0]  o_pass_gen_top_length_10,
    output wire         o_pass_gen_top_valid_10,   
    
    output wire [191:0] o_pass_gen_top_pass_11,
    output wire [31:0]  o_pass_gen_top_length_11,
    output wire         o_pass_gen_top_valid_11,
    
    output wire [191:0] o_pass_gen_top_pass_12,
    output wire [31:0]  o_pass_gen_top_length_12,
    output wire         o_pass_gen_top_valid_12,  
    
    output wire [191:0] o_pass_gen_top_pass_13,
    output wire [31:0]  o_pass_gen_top_length_13,
    output wire         o_pass_gen_top_valid_13

    // output wire [191:0] o_pass_gen_top_pass_14,
    // output wire [31:0]  o_pass_gen_top_length_14,
    // output wire         o_pass_gen_top_valid_14,  
    
    // output wire [191:0] o_pass_gen_top_pass_15,
    // output wire [31:0]  o_pass_gen_top_length_15,
    // output wire         o_pass_gen_top_valid_15,  
    
    // output wire [191:0] o_pass_gen_top_pass_16,
    // output wire [31:0]  o_pass_gen_top_length_16,
    // output wire         o_pass_gen_top_valid_16,   
    
    // output wire [191:0] o_pass_gen_top_pass_17,
    // output wire [31:0]  o_pass_gen_top_length_17,
    // output wire         o_pass_gen_top_valid_17,
    
    // output wire [191:0] o_pass_gen_top_pass_18,
    // output wire [31:0]  o_pass_gen_top_length_18,
    // output wire         o_pass_gen_top_valid_18,  
    
    // output wire [191:0] o_pass_gen_top_pass_19,
    // output wire [31:0]  o_pass_gen_top_length_19,
    // output wire         o_pass_gen_top_valid_19,  
    
    // output wire [191:0] o_pass_gen_top_pass_20,
    // output wire [31:0]  o_pass_gen_top_length_20,
    // output wire         o_pass_gen_top_valid_20,   
    
    // output wire [191:0] o_pass_gen_top_pass_21,
    // output wire [31:0]  o_pass_gen_top_length_21,
    // output wire         o_pass_gen_top_valid_21,
    
    // output wire [191:0] o_pass_gen_top_pass_22,
    // output wire [31:0]  o_pass_gen_top_length_22,
    // output wire         o_pass_gen_top_valid_22,  
    
    // output wire [191:0] o_pass_gen_top_pass_23,
    // output wire [31:0]  o_pass_gen_top_length_23,
    // output wire         o_pass_gen_top_valid_23,

    // output wire [191:0] o_pass_gen_top_pass_24,
    // output wire [31:0]  o_pass_gen_top_length_24,
    // output wire         o_pass_gen_top_valid_24,  
    
    // output wire [191:0] o_pass_gen_top_pass_25,
    // output wire [31:0]  o_pass_gen_top_length_25,
    // output wire         o_pass_gen_top_valid_25,  
    
    // output wire [191:0] o_pass_gen_top_pass_26,
    // output wire [31:0]  o_pass_gen_top_length_26,
    // output wire         o_pass_gen_top_valid_26,   
    
    // output wire [191:0] o_pass_gen_top_pass_27,
    // output wire [31:0]  o_pass_gen_top_length_27,
    // output wire         o_pass_gen_top_valid_27,
    
    // output wire [191:0] o_pass_gen_top_pass_28,
    // output wire [31:0]  o_pass_gen_top_length_28,
    // output wire         o_pass_gen_top_valid_28,  
    
    // output wire [191:0] o_pass_gen_top_pass_29,
    // output wire [31:0]  o_pass_gen_top_length_29,
    // output wire         o_pass_gen_top_valid_29,  
    
    // output wire [191:0] o_pass_gen_top_pass_30,
    // output wire [31:0]  o_pass_gen_top_length_30,
    // output wire         o_pass_gen_top_valid_30,   
    
    // output wire [191:0] o_pass_gen_top_pass_31,
    // output wire [31:0]  o_pass_gen_top_length_31,
    // output wire         o_pass_gen_top_valid_31,
    
    // output wire [191:0] o_pass_gen_top_pass_32,
    // output wire [31:0]  o_pass_gen_top_length_32,
    // output wire         o_pass_gen_top_valid_32,  
    
    // output wire [191:0] o_pass_gen_top_pass_33,
    // output wire [31:0]  o_pass_gen_top_length_33,
    // output wire         o_pass_gen_top_valid_33,

    // output wire [191:0] o_pass_gen_top_pass_34,
    // output wire [31:0]  o_pass_gen_top_length_34,
    // output wire         o_pass_gen_top_valid_34,  
    
    // output wire [191:0] o_pass_gen_top_pass_35,
    // output wire [31:0]  o_pass_gen_top_length_35,
    // output wire         o_pass_gen_top_valid_35,  
    
    // output wire [191:0] o_pass_gen_top_pass_36,
    // output wire [31:0]  o_pass_gen_top_length_36,
    // output wire         o_pass_gen_top_valid_36,   
    
    // output wire [191:0] o_pass_gen_top_pass_37,
    // output wire [31:0]  o_pass_gen_top_length_37,
    // output wire         o_pass_gen_top_valid_37,
    
    // output wire [191:0] o_pass_gen_top_pass_38,
    // output wire [31:0]  o_pass_gen_top_length_38,
    // output wire         o_pass_gen_top_valid_38
    
//    output wire [191:0] o_pass_gen_top_pass_39,
//    output wire [31:0]  o_pass_gen_top_length_39,
//    output wire         o_pass_gen_top_valid_39,  
    
//    output wire [191:0] o_pass_gen_top_pass_40,
//    output wire [31:0]  o_pass_gen_top_length_40,
//    output wire         o_pass_gen_top_valid_40,   
    
//    output wire [191:0] o_pass_gen_top_pass_41,
//    output wire [31:0]  o_pass_gen_top_length_41,
//    output wire         o_pass_gen_top_valid_41
    );
    
    wire     [191:0]              password_out                [NUMBER_CORE_GEN-1:0];
    wire     [31:0]               password_length_out         [NUMBER_CORE_GEN-1:0];
    wire                          password_valid_out          [NUMBER_CORE_GEN-1:0];
    reg     [7:0]                 count;   
    wire			              check_valid;  
    wire                          responde_valid;  
    wire [191:0]                  password_brute_force_gen;
    wire [7:0]                    password_brute_force_length;   
    wire [191:0]                  password_dictionary_gen;
    wire [7:0]                    password_dictionary_length;
    wire [191:0]                  password_mask_attack_gen;
    wire [7:0]                    password_mask_attack_length;
    wire                          pass_brute_force_valid;
    reg                           pass_brute_force_valid_reg;
    wire                          pass_dictionary_valid;
    reg                           pass_dictionary_valid_reg;
    wire                          pass_mask_attack_valid;
    reg                           pass_mask_attack_valid_reg;
    reg                           nearly_fifo_dictionary;
    reg                           nearly_fifo_brute;
    wire                          brute_force_en;
    wire                          dictionary_en;
    reg                           nearly_fifo_mask; 
    wire                          mask_en;
    wire                          fifo_ctrl_rst;
 
    reg     [191:0]               fifo_password_in          [NUMBER_CORE_GEN-1 :0];
    reg     [7:0]                 fifo_length_in            [NUMBER_CORE_GEN-1 :0];
    wire    [191:0]               fifo_password_out         [NUMBER_CORE_GEN-1 :0];
    wire    [7:0]                 fifo_length_out           [NUMBER_CORE_GEN-1 :0];   
    reg     [NUMBER_CORE_GEN-1:0] wr_en;
    wire    [NUMBER_CORE_GEN-1:0] fifo_nearly_full;
    wire    [NUMBER_CORE_GEN-1:0] fifo_empty;
    wire    [NUMBER_CORE_GEN-1:0] rd_en;
    wire    [7:0]                 valid                     [NUMBER_CORE_GEN-1:0]; 
    wire    [31:0]                counter_pass_analysted    [NUMBER_CORE_GEN-1:0]; 
    reg     [191:0]               password_gen;
    reg     [7:0]                 password_length; 
    reg                           password_valid;
    reg                           fifo_nearly_full_reg;
    wire                          password_outside_brute;
    wire                          password_outside_hybrid;
    wire                          password_outside_mask;
    reg                           password_outside;   
    
    assign check_valid	  =	((i_pass_gen_top_valid_0 == 8'h11) | (i_pass_gen_top_valid_1 == 8'h11) | (i_pass_gen_top_valid_2 == 8'h11) | (i_pass_gen_top_valid_3 == 8'h11) 
                            | (i_pass_gen_top_valid_4 == 8'h11) | (i_pass_gen_top_valid_5 == 8'h11) | (i_pass_gen_top_valid_6 == 8'h11) | (i_pass_gen_top_valid_7 == 8'h11) 
                            | (i_pass_gen_top_valid_8 == 8'h11) | (i_pass_gen_top_valid_9 == 8'h11) | (i_pass_gen_top_valid_10 == 8'h11) | (i_pass_gen_top_valid_11 == 8'h11) 
                            | (i_pass_gen_top_valid_12 == 8'h11) | (i_pass_gen_top_valid_13 == 8'h11)) ? 1'b1 : 1'b0;		
//                             | (i_pass_gen_top_valid_14 == 8'h11) | (i_pass_gen_top_valid_15 == 8'h11) 
//                             | (i_pass_gen_top_valid_16 == 8'h11) | (i_pass_gen_top_valid_17 == 8'h11) | (i_pass_gen_top_valid_18 == 8'h11) | (i_pass_gen_top_valid_19 == 8'h11) 
//                             | (i_pass_gen_top_valid_20 == 8'h11) | (i_pass_gen_top_valid_21 == 8'h11) | (i_pass_gen_top_valid_22 == 8'h11) | (i_pass_gen_top_valid_23 == 8'h11) 
//                             | (i_pass_gen_top_valid_24 == 8'h11) | (i_pass_gen_top_valid_25 == 8'h11) | (i_pass_gen_top_valid_26 == 8'h11) | (i_pass_gen_top_valid_27 == 8'h11) 
//                             | (i_pass_gen_top_valid_28 == 8'h11) | (i_pass_gen_top_valid_29 == 8'h11) | (i_pass_gen_top_valid_30 == 8'h11) | (i_pass_gen_top_valid_31 == 8'h11)
//                             | (i_pass_gen_top_valid_32 == 8'h11) | (i_pass_gen_top_valid_33 == 8'h11) | (i_pass_gen_top_valid_34 == 8'h11) | (i_pass_gen_top_valid_35 == 8'h11) 
//                             | (i_pass_gen_top_valid_36 == 8'h11) | (i_pass_gen_top_valid_37 == 8'h11) | (i_pass_gen_top_valid_38 == 8'h11)) ? 1'b1 : 1'b0;
// //                             | (i_pass_gen_top_valid_39 == 8'h11) 
//                            | (i_pass_gen_top_valid_40 == 8'h11) | (i_pass_gen_top_valid_41 == 8'h11)) ? 1'b1 : 1'b0;					     
    assign dictionary_en  = (i_pass_gen_top_mode == 2'b00 & i_pass_gen_top_start_en == 1'b1) ? 1'b1 : 1'b0;
    assign brute_force_en = (i_pass_gen_top_mode == 2'b01 & i_pass_gen_top_start_en == 1'b1) ? 1'b1 : 1'b0; 
    assign mask_en        = (i_pass_gen_top_mode == 2'b10 & i_pass_gen_top_start_en == 1'b1) ? 1'b1 : 1'b0;
    
    assign valid[0]  = i_pass_gen_top_valid_0;
    assign valid[1]  = i_pass_gen_top_valid_1;
    assign valid[2]  = i_pass_gen_top_valid_2;
    assign valid[3]  = i_pass_gen_top_valid_3;
    assign valid[4]  = i_pass_gen_top_valid_4;
    assign valid[5]  = i_pass_gen_top_valid_5;
    assign valid[6]  = i_pass_gen_top_valid_6;
    assign valid[7]  = i_pass_gen_top_valid_7;
    assign valid[8]  = i_pass_gen_top_valid_8;
    assign valid[9]  = i_pass_gen_top_valid_9;
    assign valid[10] = i_pass_gen_top_valid_10;
    assign valid[11] = i_pass_gen_top_valid_11;
    assign valid[12] = i_pass_gen_top_valid_12;
    assign valid[13] = i_pass_gen_top_valid_13;
    // assign valid[14] = i_pass_gen_top_valid_14;
    // assign valid[15] = i_pass_gen_top_valid_15;
    // assign valid[16] = i_pass_gen_top_valid_16;
    // assign valid[17] = i_pass_gen_top_valid_17;
    // assign valid[18] = i_pass_gen_top_valid_18;
    // assign valid[19] = i_pass_gen_top_valid_19;
    // assign valid[20] = i_pass_gen_top_valid_20;
    // assign valid[21] = i_pass_gen_top_valid_21;
    // assign valid[22] = i_pass_gen_top_valid_22;
    // assign valid[23] = i_pass_gen_top_valid_23;
    // assign valid[24] = i_pass_gen_top_valid_24;
    // assign valid[25] = i_pass_gen_top_valid_25;
    // assign valid[26] = i_pass_gen_top_valid_26;
    // assign valid[27] = i_pass_gen_top_valid_27;
    // assign valid[28] = i_pass_gen_top_valid_28;
    // assign valid[29] = i_pass_gen_top_valid_29;
    // assign valid[30] = i_pass_gen_top_valid_30;
    // assign valid[31] = i_pass_gen_top_valid_31;
    // assign valid[32] = i_pass_gen_top_valid_32;
    // assign valid[33] = i_pass_gen_top_valid_33;
    // assign valid[34] = i_pass_gen_top_valid_34;
    // assign valid[35] = i_pass_gen_top_valid_35;
    // assign valid[36] = i_pass_gen_top_valid_36;
    // assign valid[37] = i_pass_gen_top_valid_37;
    // assign valid[38] = i_pass_gen_top_valid_38;
//    assign valid[39] = i_pass_gen_top_valid_39;
//    assign valid[40] = i_pass_gen_top_valid_40;
//    assign valid[41] = i_pass_gen_top_valid_41;
    
    brute_force_mode#(
        .NUMBER_CORE_GEN       (NUMBER_CORE_GEN),
        .MAX_LENGTH_PASSWORD   (MAX_LENGTH_PASSWORD) 
    )brute_force_mode
    (   
        .i_brute_force_mode_clk                             (i_pass_gen_top_clk),
        .i_brute_force_mode_rst                             (i_pass_gen_top_rst),
        .i_brute_force_mode_en                              (brute_force_en),
        .i_brute_force_mode_load                            (i_pass_gen_top_load_en),
        .i_brute_force_mode_char_range                      (i_range_character_set),
        .i_brute_force_mode_fifo_nealy_full                 (nearly_fifo_brute),
        .i_brute_force_mode_length_gen                      (i_pass_gen_top_length_gen),
        .i_brute_force_mode_status_check                    (check_valid),
        .i_brute_force_mode_count_fifo                      (count),
        .i_brute_force_mode_position                        (i_pass_gen_top_position),

        .i_hybrid_mode_pass_offset                          (i_pass_gen_top_pass_offset),
        .i_hybrid_mode_length_know_gen                      (i_pass_gen_top_length_know_gen),
        .i_hybrid_in_brute_force_en                         (i_hybrid_in_brute_force_en), 

        .i_brute_force_mode_pass_again_flag                 (i_pass_gen_top_pass_again_flag),
        .i_brute_force_mode_pass_again_regions_0            (i_pass_gen_top_pass_again_regions_0),
        .i_brute_force_mode_pass_again_regions_1            (i_pass_gen_top_pass_again_regions_1),
        .i_brute_force_mode_pass_again_regions_2            (i_pass_gen_top_pass_again_regions_2),
        .i_brute_force_mode_pass_again_regions_3            (i_pass_gen_top_pass_again_regions_3),
        .i_brute_force_mode_pass_again_regions_4            (i_pass_gen_top_pass_again_regions_4),
        .i_brute_force_mode_pass_again_regions_5            (i_pass_gen_top_pass_again_regions_5),
        .i_brute_force_mode_pass_again_regions_6            (i_pass_gen_top_pass_again_regions_6),
        .i_brute_force_mode_pass_again_regions_7            (i_pass_gen_top_pass_again_regions_7),
        .i_brute_force_mode_pass_again_regions_8            (i_pass_gen_top_pass_again_regions_8),
        .i_brute_force_mode_pass_again_regions_9            (i_pass_gen_top_pass_again_regions_9),
        .i_brute_force_mode_pass_again_regions_10           (i_pass_gen_top_pass_again_regions_10),
        .i_brute_force_mode_pass_again_regions_11           (i_pass_gen_top_pass_again_regions_11),
        .i_brute_force_mode_pass_again_regions_12           (i_pass_gen_top_pass_again_regions_12),
        .i_brute_force_mode_pass_again_regions_13           (i_pass_gen_top_pass_again_regions_13),
        // .i_brute_force_mode_pass_again_regions_14           (i_pass_gen_top_pass_again_regions_14),
        // .i_brute_force_mode_pass_again_regions_15           (i_pass_gen_top_pass_again_regions_15),
        // .i_brute_force_mode_pass_again_regions_16           (i_pass_gen_top_pass_again_regions_16),
        // .i_brute_force_mode_pass_again_regions_17           (i_pass_gen_top_pass_again_regions_17),
        // .i_brute_force_mode_pass_again_regions_18           (i_pass_gen_top_pass_again_regions_18),
        // .i_brute_force_mode_pass_again_regions_19           (i_pass_gen_top_pass_again_regions_19),
        // .i_brute_force_mode_pass_again_regions_20           (i_pass_gen_top_pass_again_regions_20),
        // .i_brute_force_mode_pass_again_regions_21           (i_pass_gen_top_pass_again_regions_21),
        // .i_brute_force_mode_pass_again_regions_22           (i_pass_gen_top_pass_again_regions_22),
        // .i_brute_force_mode_pass_again_regions_23           (i_pass_gen_top_pass_again_regions_23),
        // .i_brute_force_mode_pass_again_regions_24           (i_pass_gen_top_pass_again_regions_24),
        // .i_brute_force_mode_pass_again_regions_25           (i_pass_gen_top_pass_again_regions_25),
        // .i_brute_force_mode_pass_again_regions_26           (i_pass_gen_top_pass_again_regions_26),
        // .i_brute_force_mode_pass_again_regions_27           (i_pass_gen_top_pass_again_regions_27),
        // .i_brute_force_mode_pass_again_regions_28           (i_pass_gen_top_pass_again_regions_28),
        // .i_brute_force_mode_pass_again_regions_29           (i_pass_gen_top_pass_again_regions_29),
        // .i_brute_force_mode_pass_again_regions_30           (i_pass_gen_top_pass_again_regions_30),
        // .i_brute_force_mode_pass_again_regions_31           (i_pass_gen_top_pass_again_regions_31),
        // .i_brute_force_mode_pass_again_regions_32           (i_pass_gen_top_pass_again_regions_32),
        // .i_brute_force_mode_pass_again_regions_33           (i_pass_gen_top_pass_again_regions_33),
        // .i_brute_force_mode_pass_again_regions_34           (i_pass_gen_top_pass_again_regions_34),
        // .i_brute_force_mode_pass_again_regions_35           (i_pass_gen_top_pass_again_regions_35),
        // .i_brute_force_mode_pass_again_regions_36           (i_pass_gen_top_pass_again_regions_36),
        // .i_brute_force_mode_pass_again_regions_37           (i_pass_gen_top_pass_again_regions_37),
        // .i_brute_force_mode_pass_again_regions_38           (i_pass_gen_top_pass_again_regions_38),
//        .i_brute_force_mode_pass_again_regions_39           (i_pass_gen_top_pass_again_regions_39),
//        .i_brute_force_mode_pass_again_regions_40           (i_pass_gen_top_pass_again_regions_40),
//        .i_brute_force_mode_pass_again_regions_41           (i_pass_gen_top_pass_again_regions_41),

        .i_brute_force_mode_length_pass_again_regions_0     (i_pass_gen_top_length_pass_again_regions_0),
        .i_brute_force_mode_length_pass_again_regions_1     (i_pass_gen_top_length_pass_again_regions_1),
        .i_brute_force_mode_length_pass_again_regions_2     (i_pass_gen_top_length_pass_again_regions_2),
        .i_brute_force_mode_length_pass_again_regions_3     (i_pass_gen_top_length_pass_again_regions_3),  
        .i_brute_force_mode_length_pass_again_regions_4     (i_pass_gen_top_length_pass_again_regions_4),
        .i_brute_force_mode_length_pass_again_regions_5     (i_pass_gen_top_length_pass_again_regions_5),
        .i_brute_force_mode_length_pass_again_regions_6     (i_pass_gen_top_length_pass_again_regions_6),
        .i_brute_force_mode_length_pass_again_regions_7     (i_pass_gen_top_length_pass_again_regions_7),  
        .i_brute_force_mode_length_pass_again_regions_8     (i_pass_gen_top_length_pass_again_regions_8),
        .i_brute_force_mode_length_pass_again_regions_9     (i_pass_gen_top_length_pass_again_regions_9),
        .i_brute_force_mode_length_pass_again_regions_10    (i_pass_gen_top_length_pass_again_regions_10),
        .i_brute_force_mode_length_pass_again_regions_11    (i_pass_gen_top_length_pass_again_regions_11),  
        .i_brute_force_mode_length_pass_again_regions_12    (i_pass_gen_top_length_pass_again_regions_12),
        .i_brute_force_mode_length_pass_again_regions_13    (i_pass_gen_top_length_pass_again_regions_13),
        // .i_brute_force_mode_length_pass_again_regions_14    (i_pass_gen_top_length_pass_again_regions_14),
        // .i_brute_force_mode_length_pass_again_regions_15    (i_pass_gen_top_length_pass_again_regions_15),
        // .i_brute_force_mode_length_pass_again_regions_16    (i_pass_gen_top_length_pass_again_regions_16),
        // .i_brute_force_mode_length_pass_again_regions_17    (i_pass_gen_top_length_pass_again_regions_17),  
        // .i_brute_force_mode_length_pass_again_regions_18    (i_pass_gen_top_length_pass_again_regions_18),
        // .i_brute_force_mode_length_pass_again_regions_19    (i_pass_gen_top_length_pass_again_regions_19),
        // .i_brute_force_mode_length_pass_again_regions_20    (i_pass_gen_top_length_pass_again_regions_20),
        // .i_brute_force_mode_length_pass_again_regions_21    (i_pass_gen_top_length_pass_again_regions_21),  
        // .i_brute_force_mode_length_pass_again_regions_22    (i_pass_gen_top_length_pass_again_regions_22),
        // .i_brute_force_mode_length_pass_again_regions_23    (i_pass_gen_top_length_pass_again_regions_23),
        // .i_brute_force_mode_length_pass_again_regions_24    (i_pass_gen_top_length_pass_again_regions_24),
        // .i_brute_force_mode_length_pass_again_regions_25    (i_pass_gen_top_length_pass_again_regions_25),
        // .i_brute_force_mode_length_pass_again_regions_26    (i_pass_gen_top_length_pass_again_regions_26),
        // .i_brute_force_mode_length_pass_again_regions_27    (i_pass_gen_top_length_pass_again_regions_27),  
        // .i_brute_force_mode_length_pass_again_regions_28    (i_pass_gen_top_length_pass_again_regions_28),
        // .i_brute_force_mode_length_pass_again_regions_29    (i_pass_gen_top_length_pass_again_regions_29),
        // .i_brute_force_mode_length_pass_again_regions_30    (i_pass_gen_top_length_pass_again_regions_30),
        // .i_brute_force_mode_length_pass_again_regions_31    (i_pass_gen_top_length_pass_again_regions_31),  
        // .i_brute_force_mode_length_pass_again_regions_32    (i_pass_gen_top_length_pass_again_regions_32),
        // .i_brute_force_mode_length_pass_again_regions_33    (i_pass_gen_top_length_pass_again_regions_33),
        // .i_brute_force_mode_length_pass_again_regions_34    (i_pass_gen_top_length_pass_again_regions_34),
        // .i_brute_force_mode_length_pass_again_regions_35    (i_pass_gen_top_length_pass_again_regions_35),
        // .i_brute_force_mode_length_pass_again_regions_36    (i_pass_gen_top_length_pass_again_regions_36),
        // .i_brute_force_mode_length_pass_again_regions_37    (i_pass_gen_top_length_pass_again_regions_37),  
        // .i_brute_force_mode_length_pass_again_regions_38    (i_pass_gen_top_length_pass_again_regions_38),
//        .i_brute_force_mode_length_pass_again_regions_39    (i_pass_gen_top_length_pass_again_regions_39),
//        .i_brute_force_mode_length_pass_again_regions_40    (i_pass_gen_top_length_pass_again_regions_40),
//        .i_brute_force_mode_length_pass_again_regions_41    (i_pass_gen_top_length_pass_again_regions_41),             
        
        .i_brute_force_mode_length_minimum                  (i_pass_gen_top_length_minimum),
        
        .o_brute_force_mode_pass                            (password_brute_force_gen),
        .o_brute_force_mode_length                          (password_brute_force_length),
        .o_brute_force_mode_pass_valid                      (pass_brute_force_valid),
        .o_brute_force_mode_outside_pass                    (password_outside_brute)
    );
    
//     mask_attack #(
//         .NUMBER_CORE_GEN       (NUMBER_CORE_GEN),
//         .MAX_LENGTH_PASSWORD   (MAX_LENGTH_PASSWORD)   
//     )mask_attack 
//     (   
//         .i_mask_attack_clk                      (i_pass_gen_top_clk),                  
//         .i_mask_attack_rst                      (i_pass_gen_top_rst),                  
//         .i_mask_attack_en                       (mask_en),                       
//         .i_mask_attack_load                     (i_pass_gen_top_load_en),                           
//         .i_mask_attack_fifo_nealy_full          (nearly_fifo_mask),      
//         .i_mask_attack_pass_offset              (i_pass_gen_top_pass_offset), //i_pass_gen_top_pass_offset         
//         .i_mask_attack_bit                      (i_mask_attack_bit),  //i_mask_attack_bit                
//         .i_mask_attack_length_gen               (i_pass_gen_top_length_gen),   //i_pass_gen_top_length_gen              
//         .i_mask_attack_status_check             (check_valid),         
//         .i_mask_attack_count_fifo               (count), 
        
//         .i_mask_attack_pass_set                     (i_mask_attack_pass_set),
//         .i_mask_attack_length_pass_set              (i_mask_attack_length_pass_set),
                                                          
//         .i_mask_attack_pass_again_flag              (i_pass_gen_top_pass_again_flag),      
//         .i_mask_attack_pass_again_regions_0         (i_pass_gen_top_pass_again_regions_0), 
//         .i_mask_attack_pass_again_regions_1         (i_pass_gen_top_pass_again_regions_1),  
//         .i_mask_attack_pass_again_regions_2         (i_pass_gen_top_pass_again_regions_2), 
//         .i_mask_attack_pass_again_regions_3         (i_pass_gen_top_pass_again_regions_3), 
//         .i_mask_attack_pass_again_regions_4         (i_pass_gen_top_pass_again_regions_4),  
//         .i_mask_attack_pass_again_regions_5         (i_pass_gen_top_pass_again_regions_5), 
//         .i_mask_attack_pass_again_regions_6         (i_pass_gen_top_pass_again_regions_6), 
//         .i_mask_attack_pass_again_regions_7         (i_pass_gen_top_pass_again_regions_7),  
//         .i_mask_attack_pass_again_regions_8         (i_pass_gen_top_pass_again_regions_8), 
//         .i_mask_attack_pass_again_regions_9         (i_pass_gen_top_pass_again_regions_9), 
//         .i_mask_attack_pass_again_regions_10        (i_pass_gen_top_pass_again_regions_10),  
//         .i_mask_attack_pass_again_regions_11        (i_pass_gen_top_pass_again_regions_11), 
//         .i_mask_attack_pass_again_regions_12        (i_pass_gen_top_pass_again_regions_12), 
//         .i_mask_attack_pass_again_regions_13        (i_pass_gen_top_pass_again_regions_13),  
//         // .i_mask_attack_pass_again_regions_14        (i_pass_gen_top_pass_again_regions_14), 
//         // .i_mask_attack_pass_again_regions_15        (i_pass_gen_top_pass_again_regions_15), 
//         // .i_mask_attack_pass_again_regions_16        (i_pass_gen_top_pass_again_regions_16),  
//         // .i_mask_attack_pass_again_regions_17        (i_pass_gen_top_pass_again_regions_17), 
//         // .i_mask_attack_pass_again_regions_18        (i_pass_gen_top_pass_again_regions_18), 
//         // .i_mask_attack_pass_again_regions_19        (i_pass_gen_top_pass_again_regions_19),  
//         // .i_mask_attack_pass_again_regions_20        (i_pass_gen_top_pass_again_regions_20), 
//         // .i_mask_attack_pass_again_regions_21        (i_pass_gen_top_pass_again_regions_21), 
//         // .i_mask_attack_pass_again_regions_22        (i_pass_gen_top_pass_again_regions_22),  
//         // .i_mask_attack_pass_again_regions_23        (i_pass_gen_top_pass_again_regions_23), 
//         // .i_mask_attack_pass_again_regions_24        (i_pass_gen_top_pass_again_regions_24), 
//         // .i_mask_attack_pass_again_regions_25        (i_pass_gen_top_pass_again_regions_25),  
//         // .i_mask_attack_pass_again_regions_26        (i_pass_gen_top_pass_again_regions_26), 
//         // .i_mask_attack_pass_again_regions_27        (i_pass_gen_top_pass_again_regions_27), 
//         // .i_mask_attack_pass_again_regions_28        (i_pass_gen_top_pass_again_regions_28),  
//         // .i_mask_attack_pass_again_regions_29        (i_pass_gen_top_pass_again_regions_29), 
//         // .i_mask_attack_pass_again_regions_30        (i_pass_gen_top_pass_again_regions_30), 
//         // .i_mask_attack_pass_again_regions_31        (i_pass_gen_top_pass_again_regions_31),  
//         // .i_mask_attack_pass_again_regions_32        (i_pass_gen_top_pass_again_regions_32), 
//         // .i_mask_attack_pass_again_regions_33        (i_pass_gen_top_pass_again_regions_33), 
//         // .i_mask_attack_pass_again_regions_34        (i_pass_gen_top_pass_again_regions_34), 
//         // .i_mask_attack_pass_again_regions_35        (i_pass_gen_top_pass_again_regions_35),  
//         // .i_mask_attack_pass_again_regions_36        (i_pass_gen_top_pass_again_regions_36), 
//         // .i_mask_attack_pass_again_regions_37        (i_pass_gen_top_pass_again_regions_37), 
//         // .i_mask_attack_pass_again_regions_38        (i_pass_gen_top_pass_again_regions_38),  
// //        .i_mask_attack_pass_again_regions_39        (i_pass_gen_top_pass_again_regions_39), 
// //        .i_mask_attack_pass_again_regions_40        (i_pass_gen_top_pass_again_regions_40), 
// //        .i_mask_attack_pass_again_regions_41        (i_pass_gen_top_pass_again_regions_41),  
                                                          
//         .o_mask_attack_pass                         (password_mask_attack_gen),                 
//         .o_mask_attack_length                       (password_mask_attack_length),               
//         .o_mask_attack_pass_valid                   (pass_mask_attack_valid),           
//         .o_mask_attack_outside_pass                 (password_outside_mask)     
//     );    
        
    dictionary_mode dictionary_mode
    (
        .i_dictionary_mode_clk                      (i_pass_gen_top_clk),
        .i_dictionary_mode_rst                      (i_pass_gen_top_rst),
        .i_dictionary_mode_en                       (dictionary_en),
        .i_dictionary_mode_load                     (i_pass_gen_top_load_en),
        .i_dictionary_mode_fifo_nealy_full          (nearly_fifo_dictionary),    
        .i_dictionary_mode_pass_in                  (i_pass_gen_top_pass_in),
        .i_dictionary_mode_pass_valid               (i_pass_gen_top_pass_valid),
        .i_dictionary_mode_length_gen               (i_pass_gen_top_length_gen),
        .i_dictionary_mode_status_check             (check_valid),
        .i_dictionary_mode_rule                     (i_pass_gen_top_dict_rule),
        .i_dictionary_mode_rule_value               (i_pass_gen_top_dict_rule_value),        
        
        .o_dictionary_mode_respond_valid            (responde_valid),
        .o_dictionary_mode_pass                     (password_dictionary_gen),
        .o_dictionary_mode_length                   (password_dictionary_length),
        .o_dictionary_mode_pass_valid               (pass_dictionary_valid),
        .o_dictionary_export_done                   (dictionary_export_done)
    );
    
   /* Generate: NUMBER_CORE_GEN FIFO password  */
    generate
    genvar i;
    for(i = 0; i < NUMBER_CORE_GEN; i = i +1) begin : fifointeract
        password_fifo
        #(
            .WIDTH          (200),
            .MAX_DEPTH_BITS (10)
         )
        fifo_password
        (
            .din            ({fifo_password_in[i], fifo_length_in[i]}),     // Data in
            .wr_en          (wr_en[i]),   // Write enable
            
            .rd_en          (rd_en[i]),   // Read the next word
            
            .dout           ({fifo_password_out[i], fifo_length_out[i]}),    // Data out
            .full           (),
            .nearly_full    (fifo_nearly_full[i]),
            .prog_full      (),
            .empty          (fifo_empty[i]),
            
            .reset          (fifo_ctrl_rst),
            .clk            (i_pass_gen_top_clk)         
        );
        
        read_pass_gen read_pass_gen
        (
            .i_read_pass_gen_clk            (i_pass_gen_top_clk),
            .i_read_pass_gen_rst            (i_pass_gen_top_rst),
            .i_read_pass_gen_restart        (i_pass_gen_top_start_en),
            .i_read_pass_gen_check_valid    (check_valid),
            .i_read_pass_gen_valid          (valid[i]), 
            .i_read_pass_gen_pause          (i_pass_gen_top_pause),
            .i_read_pass_gen_data           ({fifo_password_out[i], fifo_length_out[i]}),
            .i_read_pass_gen_fifo_empty     (fifo_empty[i]),
            .o_read_pass_gen_fifo_rd_en     (rd_en[i]),
            .o_read_pass_gen_pw             (password_out[i]),
            .o_read_pass_gen_length         (password_length_out[i]),
            .o_read_pass_gen_valid          (password_valid_out[i]),
            .o_read_pass_gen_counter        (counter_pass_analysted[i])       
        );
    end
    endgenerate  
           
    /* Write control*/
    always @ (*)
    begin
        case(i_pass_gen_top_mode)
            2'b00: begin
                password_gen            = password_dictionary_gen;
                password_length         = password_dictionary_length;  
                password_valid          = pass_dictionary_valid;   
                nearly_fifo_dictionary  = fifo_nearly_full_reg; 
            end
            
            2'b01: begin
                password_gen            = password_brute_force_gen;
                password_length         = password_brute_force_length;   
                password_valid          = pass_brute_force_valid; 
                nearly_fifo_brute       = fifo_nearly_full_reg;  
                password_outside        = password_outside_brute;
            end 
            
            2'b10: begin
                password_gen        = password_mask_attack_gen;
                password_length     = password_mask_attack_length;   
                password_valid      = pass_mask_attack_valid; 
                nearly_fifo_mask    = fifo_nearly_full_reg;
                password_outside    = password_outside_mask;        
            end             
        endcase
    end    
     
    always @(posedge i_pass_gen_top_clk or negedge i_pass_gen_top_rst)
    begin
        if(!i_pass_gen_top_rst)
        begin
            count           <= 8'd0;
            //fifo_ctrl_rst   <= 1'b1;
        end
        else
        begin
            fifo_nearly_full_reg = fifo_nearly_full[count];
            if((check_valid == 1'b1) || (i_pass_gen_top_start_en == 1'b0))
            begin
                //fifo_ctrl_rst <= 1'b1;
                wr_en[0]         <= 1'b0;
                wr_en[1]         <= 1'b0;
                wr_en[2]         <= 1'b0;
                wr_en[3]         <= 1'b0; 
                wr_en[4]         <= 1'b0;
                wr_en[5]         <= 1'b0;
                wr_en[6]         <= 1'b0;
                wr_en[7]         <= 1'b0; 
                wr_en[8]         <= 1'b0;
                wr_en[9]         <= 1'b0;
                wr_en[10]        <= 1'b0;
                wr_en[11]        <= 1'b0; 
                wr_en[12]        <= 1'b0;
                wr_en[13]        <= 1'b0;
                // wr_en[14]        <= 1'b0;
                // wr_en[15]        <= 1'b0; 
                // wr_en[16]        <= 1'b0;
                // wr_en[17]        <= 1'b0;
                // wr_en[18]        <= 1'b0;
                // wr_en[19]        <= 1'b0; 
                // wr_en[20]        <= 1'b0;
                // wr_en[21]        <= 1'b0;
                // wr_en[22]        <= 1'b0;
                // wr_en[23]        <= 1'b0; 
                // wr_en[24]        <= 1'b0;
                // wr_en[25]        <= 1'b0; 
                // wr_en[26]        <= 1'b0;
                // wr_en[27]        <= 1'b0;
                // wr_en[28]        <= 1'b0;
                // wr_en[29]        <= 1'b0; 
                // wr_en[30]        <= 1'b0;
                // wr_en[31]        <= 1'b0;
                // wr_en[32]        <= 1'b0;
                // wr_en[33]        <= 1'b0; 
                // wr_en[34]        <= 1'b0;
                // wr_en[35]        <= 1'b0; 
                // wr_en[36]        <= 1'b0;
                // wr_en[37]        <= 1'b0;
                // wr_en[38]        <= 1'b0;
//                wr_en[39]        <= 1'b0; 
//                wr_en[40]        <= 1'b0;
//                wr_en[41]        <= 1'b0;
                count            <= 8'd0;    
            end
            else
            begin
                //fifo_ctrl_rst <= 1'b0;
                wr_en[0]         <= 1'b0;
                wr_en[1]         <= 1'b0;
                wr_en[2]         <= 1'b0;
                wr_en[3]         <= 1'b0;   
                wr_en[4]         <= 1'b0;
                wr_en[5]         <= 1'b0;
                wr_en[6]         <= 1'b0;
                wr_en[7]         <= 1'b0; 
                wr_en[8]         <= 1'b0;
                wr_en[9]         <= 1'b0;
                wr_en[10]        <= 1'b0;
                wr_en[11]        <= 1'b0; 
                wr_en[12]        <= 1'b0;
                wr_en[13]        <= 1'b0;
                // wr_en[14]        <= 1'b0;
                // wr_en[15]        <= 1'b0; 
                // wr_en[16]        <= 1'b0;
                // wr_en[17]        <= 1'b0;
                // wr_en[18]        <= 1'b0;
                // wr_en[19]        <= 1'b0; 
                // wr_en[20]        <= 1'b0;
                // wr_en[21]        <= 1'b0;
                // wr_en[22]        <= 1'b0;
                // wr_en[23]        <= 1'b0; 
                // wr_en[24]        <= 1'b0;
                // wr_en[25]        <= 1'b0; 
                // wr_en[26]        <= 1'b0;
                // wr_en[27]        <= 1'b0;
                // wr_en[28]        <= 1'b0;
                // wr_en[29]        <= 1'b0; 
                // wr_en[30]        <= 1'b0;
                // wr_en[31]        <= 1'b0;
                // wr_en[32]        <= 1'b0;
                // wr_en[33]        <= 1'b0; 
                // wr_en[34]        <= 1'b0;
                // wr_en[35]        <= 1'b0; 
                // wr_en[36]        <= 1'b0;
                // wr_en[37]        <= 1'b0;
                // wr_en[38]        <= 1'b0;
//                wr_en[39]        <= 1'b0; 
//                wr_en[40]        <= 1'b0;
//                wr_en[41]        <= 1'b0;
                if(password_valid == 1'b1 && fifo_nearly_full[count] == 1'b0)
                begin
                    wr_en[count] <= 1'b1;
                    fifo_password_in[count] <= password_gen;
                    fifo_length_in[count]   <= password_length;
                    if(count == NUMBER_CORE_GEN -1)
                    begin
                        count <= 8'd0;
                    end
                    else
                    begin
                        count <= count + 1'b1;
                    end
                end  
                else if(password_outside == 1'b1 && fifo_nearly_full[count] == 1'b0)
                begin
                    if(count == NUMBER_CORE_GEN -1)
                    begin
                        count <= 8'd0;
                    end
                    else
                    begin
                        count <= count + 1'b1;
                    end                    
                end            
            end
        end
    end

    assign fifo_ctrl_rst = (i_pass_gen_top_rst == 1'b1 & ((check_valid == 1'b1) | (i_pass_gen_top_start_en == 1'b0)))? 1'b1 : 1'b0;
    assign o_pass_gen_top_countert_analysted = counter_pass_analysted[0] + counter_pass_analysted [1] + counter_pass_analysted [2] + counter_pass_analysted[3] + counter_pass_analysted[4]
                                                + counter_pass_analysted[5] + counter_pass_analysted [6] + counter_pass_analysted [7] + counter_pass_analysted[8] + counter_pass_analysted[9]
                                                + counter_pass_analysted[10] + counter_pass_analysted [11] + counter_pass_analysted [12] + counter_pass_analysted[13];
                                                //  + counter_pass_analysted[14]
                                                // + counter_pass_analysted[15] + counter_pass_analysted [16] + counter_pass_analysted [17] + counter_pass_analysted[18] + counter_pass_analysted[19]
                                                // + counter_pass_analysted[20] + counter_pass_analysted [21] + counter_pass_analysted [22] + counter_pass_analysted[23] + counter_pass_analysted[24]
                                                // + counter_pass_analysted[25] + counter_pass_analysted [26] + counter_pass_analysted [27] + counter_pass_analysted[28] + counter_pass_analysted[29]
                                                // + counter_pass_analysted[30] + counter_pass_analysted [31] + counter_pass_analysted [32] + counter_pass_analysted[33] + counter_pass_analysted[34]
                                                // + counter_pass_analysted[35] + counter_pass_analysted [36] + counter_pass_analysted [37] + counter_pass_analysted[38];
//                                                 + counter_pass_analysted[39]
//                                                + counter_pass_analysted[40] + counter_pass_analysted [41];
    
    assign o_pass_gen_top_responde_valid = responde_valid;
    
    assign o_pass_gen_top_fifo_empty     = fifo_empty[0];
    assign o_pass_gen_top_fifo_empty_1   = fifo_empty[1];
    assign o_pass_gen_top_fifo_empty_2   = fifo_empty[2];
    assign o_pass_gen_top_fifo_empty_3   = fifo_empty[3];
    assign o_pass_gen_top_fifo_empty_4   = fifo_empty[4];
    assign o_pass_gen_top_fifo_empty_5   = fifo_empty[5];
    assign o_pass_gen_top_fifo_empty_6   = fifo_empty[6];
    assign o_pass_gen_top_fifo_empty_7   = fifo_empty[7];
    assign o_pass_gen_top_fifo_empty_8   = fifo_empty[8];
    assign o_pass_gen_top_fifo_empty_9   = fifo_empty[9];
    assign o_pass_gen_top_fifo_empty_10   = fifo_empty[10];
    assign o_pass_gen_top_fifo_empty_11   = fifo_empty[11];
    assign o_pass_gen_top_fifo_empty_12   = fifo_empty[12];
    assign o_pass_gen_top_fifo_empty_13   = fifo_empty[13];
    // assign o_pass_gen_top_fifo_empty_14   = fifo_empty[14];
    // assign o_pass_gen_top_fifo_empty_15   = fifo_empty[15];
    // assign o_pass_gen_top_fifo_empty_16   = fifo_empty[16];
    // assign o_pass_gen_top_fifo_empty_17   = fifo_empty[17];
    // assign o_pass_gen_top_fifo_empty_18   = fifo_empty[18];
    // assign o_pass_gen_top_fifo_empty_19   = fifo_empty[19];
    // assign o_pass_gen_top_fifo_empty_20   = fifo_empty[20];
    // assign o_pass_gen_top_fifo_empty_21   = fifo_empty[21];
    // assign o_pass_gen_top_fifo_empty_22   = fifo_empty[22];
    // assign o_pass_gen_top_fifo_empty_23   = fifo_empty[23];
    // assign o_pass_gen_top_fifo_empty_24   = fifo_empty[24];
    // assign o_pass_gen_top_fifo_empty_25   = fifo_empty[25];
    // assign o_pass_gen_top_fifo_empty_26   = fifo_empty[26];
    // assign o_pass_gen_top_fifo_empty_27   = fifo_empty[27];
    // assign o_pass_gen_top_fifo_empty_28   = fifo_empty[28];
    // assign o_pass_gen_top_fifo_empty_29   = fifo_empty[29];
    // assign o_pass_gen_top_fifo_empty_30   = fifo_empty[30];
    // assign o_pass_gen_top_fifo_empty_31   = fifo_empty[31];
    // assign o_pass_gen_top_fifo_empty_32   = fifo_empty[32];
    // assign o_pass_gen_top_fifo_empty_33   = fifo_empty[33];
    // assign o_pass_gen_top_fifo_empty_34   = fifo_empty[34];
    // assign o_pass_gen_top_fifo_empty_35   = fifo_empty[35];
    // assign o_pass_gen_top_fifo_empty_36   = fifo_empty[36];
    // assign o_pass_gen_top_fifo_empty_37   = fifo_empty[37];
    // assign o_pass_gen_top_fifo_empty_38   = fifo_empty[38];
//    assign o_pass_gen_top_fifo_empty_39   = fifo_empty[39];
//    assign o_pass_gen_top_fifo_empty_40   = fifo_empty[40];
//    assign o_pass_gen_top_fifo_empty_41   = fifo_empty[41];
    
    assign o_pass_gen_top_length_0 	= {24'd0, password_length_out[0]};
    assign o_pass_gen_top_pass_0 	= password_out[0];
    assign o_pass_gen_top_valid_0	= password_valid_out[0];

    assign o_pass_gen_top_length_1 	= {24'd0, password_length_out[1]};
    assign o_pass_gen_top_pass_1 	= password_out[1];
    assign o_pass_gen_top_valid_1	= password_valid_out[1];
    
    assign o_pass_gen_top_length_2 	= {24'd0, password_length_out[2]};
    assign o_pass_gen_top_pass_2 	= password_out[2];
    assign o_pass_gen_top_valid_2	= password_valid_out[2];
   
    assign o_pass_gen_top_length_3 	= {24'd0, password_length_out[3]};
    assign o_pass_gen_top_pass_3 	= password_out[3];
    assign o_pass_gen_top_valid_3	= password_valid_out[3];
    
    assign o_pass_gen_top_length_4 	= {24'd0, password_length_out[4]};
    assign o_pass_gen_top_pass_4 	= password_out[4];
    assign o_pass_gen_top_valid_4	= password_valid_out[4];

    assign o_pass_gen_top_length_5 	= {24'd0, password_length_out[5]};
    assign o_pass_gen_top_pass_5 	= password_out[5];
    assign o_pass_gen_top_valid_5	= password_valid_out[5];
    
    assign o_pass_gen_top_length_6 	= {24'd0, password_length_out[6]};
    assign o_pass_gen_top_pass_6 	= password_out[6];
    assign o_pass_gen_top_valid_6	= password_valid_out[6];
   
    assign o_pass_gen_top_length_7 	= {24'd0, password_length_out[7]};
    assign o_pass_gen_top_pass_7 	= password_out[7];
    assign o_pass_gen_top_valid_7	= password_valid_out[7];
    
    assign o_pass_gen_top_length_8 	= {24'd0, password_length_out[8]};
    assign o_pass_gen_top_pass_8 	= password_out[8];
    assign o_pass_gen_top_valid_8	= password_valid_out[8];

    assign o_pass_gen_top_length_9 	= {24'd0, password_length_out[9]};
    assign o_pass_gen_top_pass_9 	= password_out[9];
    assign o_pass_gen_top_valid_9	= password_valid_out[9];
    
    assign o_pass_gen_top_length_10 = {24'd0, password_length_out[10]};
    assign o_pass_gen_top_pass_10 	= password_out[10];
    assign o_pass_gen_top_valid_10	= password_valid_out[10];
   
    assign o_pass_gen_top_length_11 = {24'd0, password_length_out[11]};
    assign o_pass_gen_top_pass_11 	= password_out[11];
    assign o_pass_gen_top_valid_11	= password_valid_out[11];
    
    assign o_pass_gen_top_length_12 = {24'd0, password_length_out[12]};
    assign o_pass_gen_top_pass_12 	= password_out[12];
    assign o_pass_gen_top_valid_12	= password_valid_out[12];

    assign o_pass_gen_top_length_13 = {24'd0, password_length_out[13]};
    assign o_pass_gen_top_pass_13 	= password_out[13];
    assign o_pass_gen_top_valid_13	= password_valid_out[13];

    // assign o_pass_gen_top_length_14 = {24'd0, password_length_out[14]};
    // assign o_pass_gen_top_pass_14 	= password_out[14];
    // assign o_pass_gen_top_valid_14	= password_valid_out[14];

    // assign o_pass_gen_top_length_15 = {24'd0, password_length_out[15]};
    // assign o_pass_gen_top_pass_15 	= password_out[15];
    // assign o_pass_gen_top_valid_15	= password_valid_out[15];
    
    // assign o_pass_gen_top_length_16 = {24'd0, password_length_out[16]};
    // assign o_pass_gen_top_pass_16 	= password_out[16];
    // assign o_pass_gen_top_valid_16	= password_valid_out[16];
   
    // assign o_pass_gen_top_length_17 = {24'd0, password_length_out[17]};
    // assign o_pass_gen_top_pass_17 	= password_out[17];
    // assign o_pass_gen_top_valid_17	= password_valid_out[17];
    
    // assign o_pass_gen_top_length_18 = {24'd0, password_length_out[18]};
    // assign o_pass_gen_top_pass_18 	= password_out[18];
    // assign o_pass_gen_top_valid_18	= password_valid_out[18];

    // assign o_pass_gen_top_length_19 = {24'd0, password_length_out[19]};
    // assign o_pass_gen_top_pass_19 	= password_out[19];
    // assign o_pass_gen_top_valid_19	= password_valid_out[19];
    
    // assign o_pass_gen_top_length_20 = {24'd0, password_length_out[20]};
    // assign o_pass_gen_top_pass_20 	= password_out[20];
    // assign o_pass_gen_top_valid_20	= password_valid_out[20];
   
    // assign o_pass_gen_top_length_21 = {24'd0, password_length_out[21]};
    // assign o_pass_gen_top_pass_21 	= password_out[21];
    // assign o_pass_gen_top_valid_21	= password_valid_out[21];
    
    // assign o_pass_gen_top_length_22 = {24'd0, password_length_out[22]};
    // assign o_pass_gen_top_pass_22 	= password_out[22];
    // assign o_pass_gen_top_valid_22	= password_valid_out[22];

    // assign o_pass_gen_top_length_23 = {24'd0, password_length_out[23]};
    // assign o_pass_gen_top_pass_23 	= password_out[23];
    // assign o_pass_gen_top_valid_23	= password_valid_out[23];

    // assign o_pass_gen_top_length_24 = {24'd0, password_length_out[24]};
    // assign o_pass_gen_top_pass_24 	= password_out[24];
    // assign o_pass_gen_top_valid_24	= password_valid_out[24];

    // assign o_pass_gen_top_length_25 = {24'd0, password_length_out[25]};
    // assign o_pass_gen_top_pass_25 	= password_out[25];
    // assign o_pass_gen_top_valid_25	= password_valid_out[25];
    
    // assign o_pass_gen_top_length_26 = {24'd0, password_length_out[26]};
    // assign o_pass_gen_top_pass_26 	= password_out[26];
    // assign o_pass_gen_top_valid_26	= password_valid_out[26];
   
    // assign o_pass_gen_top_length_27 = {24'd0, password_length_out[27]};
    // assign o_pass_gen_top_pass_27 	= password_out[27];
    // assign o_pass_gen_top_valid_27	= password_valid_out[27];
    
    // assign o_pass_gen_top_length_28 = {24'd0, password_length_out[28]};
    // assign o_pass_gen_top_pass_28 	= password_out[28];
    // assign o_pass_gen_top_valid_28	= password_valid_out[28];

    // assign o_pass_gen_top_length_29 = {24'd0, password_length_out[29]};
    // assign o_pass_gen_top_pass_29 	= password_out[29];
    // assign o_pass_gen_top_valid_29	= password_valid_out[29];
    
    // assign o_pass_gen_top_length_30 = {24'd0, password_length_out[30]};
    // assign o_pass_gen_top_pass_30 	= password_out[30];
    // assign o_pass_gen_top_valid_30	= password_valid_out[30];
   
    // assign o_pass_gen_top_length_31 = {24'd0, password_length_out[31]};
    // assign o_pass_gen_top_pass_31 	= password_out[31];
    // assign o_pass_gen_top_valid_31	= password_valid_out[31];
    
    // assign o_pass_gen_top_length_32 = {24'd0, password_length_out[32]};
    // assign o_pass_gen_top_pass_32 	= password_out[32];
    // assign o_pass_gen_top_valid_32	= password_valid_out[32];

    // assign o_pass_gen_top_length_33 = {24'd0, password_length_out[33]};
    // assign o_pass_gen_top_pass_33 	= password_out[33];
    // assign o_pass_gen_top_valid_33	= password_valid_out[33];

    // assign o_pass_gen_top_length_34 = {24'd0, password_length_out[34]};
    // assign o_pass_gen_top_pass_34 	= password_out[34];
    // assign o_pass_gen_top_valid_34	= password_valid_out[34];

    // assign o_pass_gen_top_length_35 = {24'd0, password_length_out[35]};
    // assign o_pass_gen_top_pass_35 	= password_out[35];
    // assign o_pass_gen_top_valid_35	= password_valid_out[35];
    
    // assign o_pass_gen_top_length_36 = {24'd0, password_length_out[36]};
    // assign o_pass_gen_top_pass_36 	= password_out[36];
    // assign o_pass_gen_top_valid_36	= password_valid_out[36];
   
    // assign o_pass_gen_top_length_37 = {24'd0, password_length_out[37]};
    // assign o_pass_gen_top_pass_37 	= password_out[37];
    // assign o_pass_gen_top_valid_37	= password_valid_out[37];
    
    // assign o_pass_gen_top_length_38 = {24'd0, password_length_out[38]};
    // assign o_pass_gen_top_pass_38 	= password_out[38];
    // assign o_pass_gen_top_valid_38	= password_valid_out[38];

//    assign o_pass_gen_top_length_39 = {24'd0, password_length_out[39]};
//    assign o_pass_gen_top_pass_39 	= password_out[39];
//    assign o_pass_gen_top_valid_39	= password_valid_out[39];
    
//    assign o_pass_gen_top_length_40 = {24'd0, password_length_out[40]};
//    assign o_pass_gen_top_pass_40 	= password_out[40];
//    assign o_pass_gen_top_valid_40	= password_valid_out[40];
   
//    assign o_pass_gen_top_length_41 = {24'd0, password_length_out[41]};
//    assign o_pass_gen_top_pass_41 	= password_out[41];
//    assign o_pass_gen_top_valid_41	= password_valid_out[41];
      
endmodule