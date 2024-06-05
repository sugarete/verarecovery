//======================================================================
//
// Module Name:    WHIRLPOOL_WCIPHER_ROUND
// Description:    Top-level Round function of Whirlpool W-Cipher
//
// Language:       Verilog-2001
//
// Module Dependencies:
//    WHIRLPOOL_WCIPHER_PI
//    WHIRLPOOL_WCIPHER_MU
//    WHIRLPOOL_WCIPHER_THETA
//    WHIRLPOOL_WCIPHER_MU_INVERSE
//    WHIRLPOOL_WCIPHER_GAMMA
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

module WHIRLPOOL_WCIPHER_ROUND (
    output wire [0:511] odata,
    input wire  [0:511] idata
    //input [0:511] subkey
);

wire [0:511] out_sub_byte;
wire [0:511] out_shif_colum;

//---------wires, registers----------
// Sub-byte operation (Gamma Function)
WHIRLPOOL_WCIPHER_GAMMA whirlpool_wcipher_gamma 
(
    // outputs
    .o_data(out_sub_byte),
    // inputs
    .i_data(idata)
);

// ShiftColumn operation (Pi Function)
WHIRLPOOL_WCIPHER_PI whirlpool_wcipher_pi 
(
    // outputs
    .o_data(out_shif_colum),
    // inputs
    .i_data(out_sub_byte)
);

// MixRow operation (Theta Function)
WHIRLPOOL_WCIPHER_THETA whirlpool_wcipher_theta 
(
    // outputs
    .o_data(odata),
    // inputs
    .i_data(out_shif_colum)
);

endmodule