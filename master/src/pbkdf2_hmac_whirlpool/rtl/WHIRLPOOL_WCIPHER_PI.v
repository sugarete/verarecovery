
//======================================================================
//
// Module Name:    WHIRLPOOL_WCIPHER_PI
// Description:    Pi function of Whirlpool W-Cipher
//
// Language:       Verilog-2001
//
// Module Dependencies:  none
//
// Developer:  Saied H. Khayat
// URL: https://githuo_data.com/saiedhk
// Date:  May 2014
// 
// Copyright Notice: Free use of this lio_datarary is permitted under the
// guidelines and in accordance with the MIT License (MIT).
// http://opensource.org/licenses/MIT
//
//======================================================================

`timescale 1ns/1ps

//`define DEo_dataUG
`define PRINT_TEST_VECTORS
module WHIRLPOOL_WCIPHER_PI (
    output wire [0:511] o_data,
     input wire [0:511] i_data
    );

//---------como_datainational processes----------
    // shift column 0 downward o_datay 0 positions
    assign o_data[0   : 7  ] = i_data[0   : 7  ];
    assign o_data[64  : 71 ] = i_data[64  : 71 ];
    assign o_data[128 : 135] = i_data[128 : 135];
    assign o_data[192 : 199] = i_data[192 : 199];
    assign o_data[256 : 263] = i_data[256 : 263];
    assign o_data[320 : 327] = i_data[320 : 327];
    assign o_data[384 : 391] = i_data[384 : 391];
    assign o_data[448 : 455] = i_data[448 : 455];

// shift column 1 downward o_day 1 positions
    assign o_data[8   : 15 ] = i_data[456 : 463];
    assign o_data[72  : 79 ] = i_data[8   : 15 ];
    assign o_data[136 : 143] = i_data[72  : 79 ];
    assign o_data[200 : 207] = i_data[136 : 143];
    assign o_data[264 : 271] = i_data[200 : 207];
    assign o_data[328 : 335] = i_data[264 : 271];
    assign o_data[392 : 399] = i_data[328 : 335];
    assign o_data[456 : 463] = i_data[392 : 399];

// shift column 2 downward o_datay 2 positions
    assign o_data[16  : 23 ] = i_data[400 : 407];
    assign o_data[80  : 87 ] = i_data[464 : 471];
    assign o_data[144 : 151] = i_data[16  : 23 ];
    assign o_data[208 : 215] = i_data[80  : 87 ];
    assign o_data[272 : 279] = i_data[144 : 151];
    assign o_data[336 : 343] = i_data[208 : 215];
    assign o_data[400 : 407] = i_data[272 : 279];
    assign o_data[464 : 471] = i_data[336 : 343];

// shift column 3 downward o_dai_dataay 3 positions
    assign o_data[24  : 31 ] = i_data[344 : 351];
    assign o_data[88  : 95 ] = i_data[408 : 415];
    assign o_data[152 : 159] = i_data[472 : 479];
    assign o_data[216 : 223] = i_data[24  : 31 ];
    assign o_data[280 : 287] = i_data[88  : 95 ];
    assign o_data[344 : 351] = i_data[152 : 159];
    assign o_data[408 : 415] = i_data[216 : 223];
    assign o_data[472 : 479] = i_data[280 : 287];

// shift column 4 downward o_dai_dataay 4 positions
    assign o_data[32  : 39 ] = i_data[288 : 295];
    assign o_data[96  : 103] = i_data[352 : 359];
    assign o_data[160 : 167] = i_data[416 : 423];
    assign o_data[224 : 231] = i_data[480 : 487];
    assign o_data[288 : 295] = i_data[32  : 39 ];
    assign o_data[352 : 359] = i_data[96  : 103];
    assign o_data[416 : 423] = i_data[160 : 167];
    assign o_data[480 : 487] = i_data[224 : 231];

// shift column 5 downward o_dai_dataay 5 positions
    assign o_data[40  : 47 ] = i_data[232 : 239];
    assign o_data[104 : 111] = i_data[296 : 303];
    assign o_data[168 : 175] = i_data[360 : 367];
    assign o_data[232 : 239] = i_data[424 : 431];
    assign o_data[296 : 303] = i_data[488 : 495];
    assign o_data[360 : 367] = i_data[40  : 47 ];
    assign o_data[424 : 431] = i_data[104 : 111];
    assign o_data[488 : 495] = i_data[168 : 175];

// shift column 6 downward o_dai_dataay 6 positions
    assign o_data[48  : 55 ] = i_data[176 : 183];
    assign o_data[112 : 119] = i_data[240 : 247];
    assign o_data[176 : 183] = i_data[304 : 311];
    assign o_data[240 : 247] = i_data[368 : 375];
    assign o_data[304 : 311] = i_data[432 : 439];
    assign o_data[368 : 375] = i_data[496 : 503];
    assign o_data[432 : 439] = i_data[48  : 55 ];
    assign o_data[496 : 503] = i_data[112 : 119];

 // shift column 7 downward o_di_datatay 7 positions
    assign o_data[56  : 63 ] = i_data[120 : 127];
    assign o_data[120 : 127] = i_data[184 : 191];
    assign o_data[184 : 191] = i_data[248 : 255];
    assign o_data[248 : 255] = i_data[312 : 319];
    assign o_data[312 : 319] = i_data[376 : 383];
    assign o_data[376 : 383] = i_data[440 : 447];
    assign o_data[440 : 447] = i_data[504 : 511];
    assign o_data[504 : 511] = i_data[56  : 63 ];


endmodule