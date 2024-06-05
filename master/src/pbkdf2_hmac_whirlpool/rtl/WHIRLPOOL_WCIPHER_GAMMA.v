//======================================================================
//
// Module Name:    WHIRLPOOL_WCIPHER_GAMMA
// Description:    Gamma function of Whirlpool W-Cipher
//
// Language:       Verilog-2001
//
// Module Dependencies:
//    WHIRLPOOL_WCIPHER_SBOX
//
// Developer:  Saied H. Khayat
// URL: https://github.com/saiedhk
// Date:  May 2014
// 
// Copyright Notice: Free use of this library is permitted under the
// guidelines and in accordance with the MIT License (MIT).
// http://opensource.org/licenses/MIT
//
//======================================================================
`timescale 1ns/1ps

//`define DEBUG
`define PRINT_TEST_VECTORS

module WHIRLPOOL_WCIPHER_GAMMA (
     output wire [0:511] o_data,
     input  wire [0:511] i_data
    );

//---------combinational processes----------
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_00 ( .idata(i_data[0   : 7  ]), .odata(o_data[0   : 7  ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_01 ( .idata(i_data[8   : 15 ]), .odata(o_data[8   : 15 ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_02 ( .idata(i_data[16  : 23 ]), .odata(o_data[16  : 23 ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_03 ( .idata(i_data[24  : 31 ]), .odata(o_data[24  : 31 ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_04 ( .idata(i_data[32  : 39 ]), .odata(o_data[32  : 39 ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_05 ( .idata(i_data[40  : 47 ]), .odata(o_data[40  : 47 ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_06 ( .idata(i_data[48  : 55 ]), .odata(o_data[48  : 55 ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_07 ( .idata(i_data[56  : 63 ]), .odata(o_data[56  : 63 ]) );

WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_10 ( .idata(i_data[64  : 71 ]), .odata(o_data[64  : 71 ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_11 ( .idata(i_data[72  : 79 ]), .odata(o_data[72  : 79 ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_12 ( .idata(i_data[80  : 87 ]), .odata(o_data[80  : 87 ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_13 ( .idata(i_data[88  : 95 ]), .odata(o_data[88  : 95 ]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_14 ( .idata(i_data[96  : 103]), .odata(o_data[96  : 103]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_15 ( .idata(i_data[104 : 111]), .odata(o_data[104 : 111]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_16 ( .idata(i_data[112 : 119]), .odata(o_data[112 : 119]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_17 ( .idata(i_data[120 : 127]), .odata(o_data[120 : 127]) );

WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_20 ( .idata(i_data[128 : 135]), .odata(o_data[128 : 135]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_21 ( .idata(i_data[136 : 143]), .odata(o_data[136 : 143]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_22 ( .idata(i_data[144 : 151]), .odata(o_data[144 : 151]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_23 ( .idata(i_data[152 : 159]), .odata(o_data[152 : 159]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_24 ( .idata(i_data[160 : 167]), .odata(o_data[160 : 167]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_25 ( .idata(i_data[168 : 175]), .odata(o_data[168 : 175]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_26 ( .idata(i_data[176 : 183]), .odata(o_data[176 : 183]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_27 ( .idata(i_data[184 : 191]), .odata(o_data[184 : 191]) );

WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_30 ( .idata(i_data[192 : 199]), .odata(o_data[192 : 199]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_31 ( .idata(i_data[200 : 207]), .odata(o_data[200 : 207]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_32 ( .idata(i_data[208 : 215]), .odata(o_data[208 : 215]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_33 ( .idata(i_data[216 : 223]), .odata(o_data[216 : 223]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_34 ( .idata(i_data[224 : 231]), .odata(o_data[224 : 231]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_35 ( .idata(i_data[232 : 239]), .odata(o_data[232 : 239]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_36 ( .idata(i_data[240 : 247]), .odata(o_data[240 : 247]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_37 ( .idata(i_data[248 : 255]), .odata(o_data[248 : 255]) );

WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_40 ( .idata(i_data[256 : 263]), .odata(o_data[256 : 263]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_41 ( .idata(i_data[264 : 271]), .odata(o_data[264 : 271]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_42 ( .idata(i_data[272 : 279]), .odata(o_data[272 : 279]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_43 ( .idata(i_data[280 : 287]), .odata(o_data[280 : 287]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_44 ( .idata(i_data[288 : 295]), .odata(o_data[288 : 295]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_45 ( .idata(i_data[296 : 303]), .odata(o_data[296 : 303]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_46 ( .idata(i_data[304 : 311]), .odata(o_data[304 : 311]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_47 ( .idata(i_data[312 : 319]), .odata(o_data[312 : 319]) );

WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_50 ( .idata(i_data[320 : 327]), .odata(o_data[320 : 327]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_51 ( .idata(i_data[328 : 335]), .odata(o_data[328 : 335]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_52 ( .idata(i_data[336 : 343]), .odata(o_data[336 : 343]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_53 ( .idata(i_data[344 : 351]), .odata(o_data[344 : 351]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_54 ( .idata(i_data[352 : 359]), .odata(o_data[352 : 359]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_55 ( .idata(i_data[360 : 367]), .odata(o_data[360 : 367]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_56 ( .idata(i_data[368 : 375]), .odata(o_data[368 : 375]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_57 ( .idata(i_data[376 : 383]), .odata(o_data[376 : 383]) );

WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_60 ( .idata(i_data[384 : 391]), .odata(o_data[384 : 391]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_61 ( .idata(i_data[392 : 399]), .odata(o_data[392 : 399]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_62 ( .idata(i_data[400 : 407]), .odata(o_data[400 : 407]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_63 ( .idata(i_data[408 : 415]), .odata(o_data[408 : 415]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_64 ( .idata(i_data[416 : 423]), .odata(o_data[416 : 423]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_65 ( .idata(i_data[424 : 431]), .odata(o_data[424 : 431]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_66 ( .idata(i_data[432 : 439]), .odata(o_data[432 : 439]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_67 ( .idata(i_data[440 : 447]), .odata(o_data[440 : 447]) );

WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_70 ( .idata(i_data[448 : 455]), .odata(o_data[448 : 455]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_71 ( .idata(i_data[456 : 463]), .odata(o_data[456 : 463]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_72 ( .idata(i_data[464 : 471]), .odata(o_data[464 : 471]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_73 ( .idata(i_data[472 : 479]), .odata(o_data[472 : 479]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_74 ( .idata(i_data[480 : 487]), .odata(o_data[480 : 487]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_75 ( .idata(i_data[488 : 495]), .odata(o_data[488 : 495]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_76 ( .idata(i_data[496 : 503]), .odata(o_data[496 : 503]) );
WHIRLPOOL_WCIPHER_SBOX whirlpool_sbox_77 ( .idata(i_data[504 : 511]), .odata(o_data[504 : 511]) );


endmodule