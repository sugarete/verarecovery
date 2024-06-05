
//======================================================================
//
// Module Name:    WHIRLPOOL_WCIPHER_THETA
// Description:    Theta function of Whirlpool W-Cipher
//
// Language:       Verilog-2001
//
// Module Dependencies:  none
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

module WHIRLPOOL_WCIPHER_THETA (
    output wire [0:511] o_data,
     input wire [0:511] i_data
    );

localparam REDPOLY = 8'h1D;    // reduction polynomial (in hex representation)

//---------functions----------   
function automatic [7:0] TIMES_2 ( input [7:0] X );
    TIMES_2[7:0] = ( X[7] ) ? ({X[6:0], 1'b0} ^ REDPOLY) : {X[6:0], 1'b0};
endfunction

function automatic [7:0] TIMES_4 ( input [7:0] X );
begin
    TIMES_4[7:0] = TIMES_2( TIMES_2 (X[7:0]) );
end
endfunction

function automatic [7:0] TIMES_8 ( input [7:0] X );
begin
    TIMES_8[7:0] = TIMES_2( TIMES_2 ( TIMES_2 (X[7:0]) ) );
end
endfunction

function automatic [7:0] TIMES_5 ( input [7:0] X );
begin
    TIMES_5[7:0] = TIMES_4( X[7:0] ) ^ X;
end
endfunction

function automatic [7:0] TIMES_9 ( input [7:0] X );
begin
    TIMES_9[7:0] = TIMES_8( X[7:0] ) ^ X;
end
endfunction

function automatic [7:0] XORALL ( input [7:0] X0, X1, X2, X3, X4, X5, X6, X7 );
begin
    XORALL[7:0] = ( ( (X0 ^ X1) ^ (X2 ^ X3) ) ^ ( (X4 ^ X5) ^ (X6 ^ X7) ) );
end
endfunction

//---------combinational processes----------

// ROW 0
assign o_data[0   : 7  ] = XORALL( i_data[0   : 7  ] , TIMES_9(i_data[8   : 15 ]) , TIMES_2(i_data[16  : 23 ]) , TIMES_5(i_data[24  : 31 ]) , TIMES_8(i_data[32  : 39 ] ) , i_data[40  : 47 ]  , TIMES_4(i_data[48  : 55 ]) , i_data[56  : 63 ] );
assign o_data[8   : 15 ] = XORALL( i_data[0   : 7  ] , i_data[8   : 15 ] , TIMES_9(i_data[16  : 23 ]) , TIMES_2(i_data[24  : 31 ]) , TIMES_5(i_data[32  : 39 ] ) , TIMES_8(i_data[40  : 47 ] ) , i_data[48  : 55 ] , TIMES_4(i_data[56  : 63 ]) );
assign o_data[16  : 23 ] = XORALL( TIMES_4(i_data[0   : 7  ]) , i_data[8   : 15 ] , i_data[16  : 23 ] , TIMES_9(i_data[24  : 31 ]) , TIMES_2(i_data[32  : 39 ] ) , TIMES_5(i_data[40  : 47 ] ) , TIMES_8(i_data[48  : 55 ]) , i_data[56  : 63 ] );
assign o_data[24  : 31 ] = XORALL( i_data[0   : 7  ] , TIMES_4(i_data[8   : 15 ]) , i_data[16  : 23 ] , i_data[24  : 31 ] , TIMES_9(i_data[32  : 39 ] ) , TIMES_2(i_data[40  : 47 ] ) , TIMES_5(i_data[48  : 55 ]) , TIMES_8(i_data[56  : 63 ]) );
assign o_data[32  : 39 ] = XORALL( TIMES_8(i_data[0   : 7  ]) , i_data[8   : 15 ] , TIMES_4(i_data[16  : 23 ]) , i_data[24  : 31 ] , i_data[32  : 39 ]  , TIMES_9(i_data[40  : 47 ] ) , TIMES_2(i_data[48  : 55 ]) , TIMES_5(i_data[56  : 63 ]) );
assign o_data[40  : 47 ] = XORALL( TIMES_5(i_data[0   : 7  ]) , TIMES_8(i_data[8   : 15 ]) , i_data[16  : 23 ] , TIMES_4(i_data[24  : 31 ]) , i_data[32  : 39 ]  , i_data[40  : 47 ]  , TIMES_9(i_data[48  : 55 ]) , TIMES_2(i_data[56  : 63 ]) );
assign o_data[48  : 55 ] = XORALL( TIMES_2(i_data[0   : 7  ]) , TIMES_5(i_data[8   : 15 ]) , TIMES_8(i_data[16  : 23 ]) , i_data[24  : 31 ] , TIMES_4(i_data[32  : 39 ] ) , i_data[40  : 47 ]  , i_data[48  : 55 ] , TIMES_9(i_data[56  : 63 ]) );
assign o_data[56  : 63 ] = XORALL( TIMES_9(i_data[0   : 7  ]) , TIMES_2(i_data[8   : 15 ]) , TIMES_5(i_data[16  : 23 ]) , TIMES_8(i_data[24  : 31 ]) , i_data[32  : 39 ]  , TIMES_4(i_data[40  : 47 ] ) , i_data[48  : 55 ] , i_data[56  : 63 ] );

// ROW 1
assign o_data[64  : 71 ] = XORALL( i_data[64  : 71 ] , TIMES_9(i_data[72  : 79 ] ) , TIMES_2(i_data[80  : 87 ] ) , TIMES_5(i_data[88  : 95 ]) , TIMES_8( i_data[96  : 103] ) , i_data[104 : 111]  , TIMES_4(i_data[112 : 119] ) , i_data[120 : 127] );
assign o_data[72  : 79 ] = XORALL( i_data[64  : 71 ] , i_data[72  : 79 ]  , TIMES_9(i_data[80  : 87 ] ) , TIMES_2(i_data[88  : 95 ]) , TIMES_5( i_data[96  : 103] ) , TIMES_8(i_data[104 : 111] ) , i_data[112 : 119]  , TIMES_4(i_data[120 : 127]) );
assign o_data[80  : 87 ] = XORALL( TIMES_4(i_data[64  : 71 ]) , i_data[72  : 79 ]  , i_data[80  : 87 ]  , TIMES_9(i_data[88  : 95 ]) , TIMES_2( i_data[96  : 103] ) , TIMES_5(i_data[104 : 111] ) , TIMES_8(i_data[112 : 119] ) , i_data[120 : 127] );
assign o_data[88  : 95 ] = XORALL( i_data[64  : 71 ] , TIMES_4(i_data[72  : 79 ] ) , i_data[80  : 87 ]  , i_data[88  : 95 ] , TIMES_9( i_data[96  : 103] ) , TIMES_2(i_data[104 : 111] ) , TIMES_5(i_data[112 : 119] ) , TIMES_8(i_data[120 : 127]) );
assign o_data[96  : 103] = XORALL( TIMES_8(i_data[64  : 71 ]) , i_data[72  : 79 ]  , TIMES_4(i_data[80  : 87 ] ) , i_data[88  : 95 ] ,  i_data[96  : 103]  , TIMES_9(i_data[104 : 111] ) , TIMES_2(i_data[112 : 119] ) , TIMES_5(i_data[120 : 127]) );
assign o_data[104 : 111] = XORALL( TIMES_5(i_data[64  : 71 ]) , TIMES_8(i_data[72  : 79 ] ) , i_data[80  : 87 ]  , TIMES_4(i_data[88  : 95 ]) ,  i_data[96  : 103]  , i_data[104 : 111]  , TIMES_9(i_data[112 : 119] ) , TIMES_2(i_data[120 : 127]) );
assign o_data[112 : 119] = XORALL( TIMES_2(i_data[64  : 71 ]) , TIMES_5(i_data[72  : 79 ] ) , TIMES_8(i_data[80  : 87 ] ) , i_data[88  : 95 ] , TIMES_4( i_data[96  : 103] ) , i_data[104 : 111]  , i_data[112 : 119]  , TIMES_9(i_data[120 : 127]) );
assign o_data[120 : 127] = XORALL( TIMES_9(i_data[64  : 71 ]) , TIMES_2(i_data[72  : 79 ] ) , TIMES_5(i_data[80  : 87 ] ) , TIMES_8(i_data[88  : 95 ]) ,  i_data[96  : 103]  , TIMES_4(i_data[104 : 111] ) , i_data[112 : 119]  , i_data[120 : 127] );

// ROW 2
assign o_data[128 : 135] = XORALL( i_data[128 : 135] , TIMES_9(i_data[136 : 143]) , TIMES_2(i_data[144 : 151]) , TIMES_5(i_data[152 : 159]) , TIMES_8(i_data[160 : 167]) , i_data[168 : 175] , TIMES_4(i_data[176 : 183] ) , i_data[184 : 191] );
assign o_data[136 : 143] = XORALL( i_data[128 : 135] , i_data[136 : 143] , TIMES_9(i_data[144 : 151]) , TIMES_2(i_data[152 : 159]) , TIMES_5(i_data[160 : 167]) , TIMES_8(i_data[168 : 175]) , i_data[176 : 183]  , TIMES_4(i_data[184 : 191]) );
assign o_data[144 : 151] = XORALL( TIMES_4(i_data[128 : 135]) , i_data[136 : 143] , i_data[144 : 151] , TIMES_9(i_data[152 : 159]) , TIMES_2(i_data[160 : 167]) , TIMES_5(i_data[168 : 175]) , TIMES_8(i_data[176 : 183] ) , i_data[184 : 191] );
assign o_data[152 : 159] = XORALL( i_data[128 : 135] , TIMES_4(i_data[136 : 143]) , i_data[144 : 151] , i_data[152 : 159] , TIMES_9(i_data[160 : 167]) , TIMES_2(i_data[168 : 175]) , TIMES_5(i_data[176 : 183] ) , TIMES_8(i_data[184 : 191]) );
assign o_data[160 : 167] = XORALL( TIMES_8(i_data[128 : 135]) , i_data[136 : 143] , TIMES_4(i_data[144 : 151]) , i_data[152 : 159] , i_data[160 : 167] , TIMES_9(i_data[168 : 175]) , TIMES_2(i_data[176 : 183] ) , TIMES_5(i_data[184 : 191]) );
assign o_data[168 : 175] = XORALL( TIMES_5(i_data[128 : 135]) , TIMES_8(i_data[136 : 143]) , i_data[144 : 151] , TIMES_4(i_data[152 : 159]) , i_data[160 : 167] , i_data[168 : 175] , TIMES_9(i_data[176 : 183] ) , TIMES_2(i_data[184 : 191]) );
assign o_data[176 : 183] = XORALL( TIMES_2(i_data[128 : 135]) , TIMES_5(i_data[136 : 143]) , TIMES_8(i_data[144 : 151]) , i_data[152 : 159] , TIMES_4(i_data[160 : 167]) , i_data[168 : 175] , i_data[176 : 183]  , TIMES_9(i_data[184 : 191]) );
assign o_data[184 : 191] = XORALL( TIMES_9(i_data[128 : 135]) , TIMES_2(i_data[136 : 143]) , TIMES_5(i_data[144 : 151]) , TIMES_8(i_data[152 : 159]) , i_data[160 : 167] , TIMES_4(i_data[168 : 175]) , i_data[176 : 183]  , i_data[184 : 191] );

// ROW 3
assign o_data[192 : 199] = XORALL( i_data[192 : 199] , TIMES_9(i_data[200 : 207] ) , TIMES_2(i_data[208 : 215]) , TIMES_5(i_data[216 : 223]) , TIMES_8(i_data[224 : 231]) , i_data[232 : 239] , TIMES_4(i_data[240 : 247]) , i_data[248 : 255] );
assign o_data[200 : 207] = XORALL( i_data[192 : 199] , i_data[200 : 207]  , TIMES_9(i_data[208 : 215]) , TIMES_2(i_data[216 : 223]) , TIMES_5(i_data[224 : 231]) , TIMES_8(i_data[232 : 239]) , i_data[240 : 247] , TIMES_4(i_data[248 : 255]) );
assign o_data[208 : 215] = XORALL( TIMES_4(i_data[192 : 199]) , i_data[200 : 207]  , i_data[208 : 215] , TIMES_9(i_data[216 : 223]) , TIMES_2(i_data[224 : 231]) , TIMES_5(i_data[232 : 239]) , TIMES_8(i_data[240 : 247]) , i_data[248 : 255] );
assign o_data[216 : 223] = XORALL( i_data[192 : 199] , TIMES_4(i_data[200 : 207] ) , i_data[208 : 215] , i_data[216 : 223] , TIMES_9(i_data[224 : 231]) , TIMES_2(i_data[232 : 239]) , TIMES_5(i_data[240 : 247]) , TIMES_8(i_data[248 : 255]) );
assign o_data[224 : 231] = XORALL( TIMES_8(i_data[192 : 199]) , i_data[200 : 207]  , TIMES_4(i_data[208 : 215]) , i_data[216 : 223] , i_data[224 : 231] , TIMES_9(i_data[232 : 239]) , TIMES_2(i_data[240 : 247]) , TIMES_5(i_data[248 : 255]) );
assign o_data[232 : 239] = XORALL( TIMES_5(i_data[192 : 199]) , TIMES_8(i_data[200 : 207] ) , i_data[208 : 215] , TIMES_4(i_data[216 : 223]) , i_data[224 : 231] , i_data[232 : 239] , TIMES_9(i_data[240 : 247]) , TIMES_2(i_data[248 : 255]) );
assign o_data[240 : 247] = XORALL( TIMES_2(i_data[192 : 199]) , TIMES_5(i_data[200 : 207] ) , TIMES_8(i_data[208 : 215]) , i_data[216 : 223] , TIMES_4(i_data[224 : 231]) , i_data[232 : 239] , i_data[240 : 247] , TIMES_9(i_data[248 : 255]) );
assign o_data[248 : 255] = XORALL( TIMES_9(i_data[192 : 199]) , TIMES_2(i_data[200 : 207] ) , TIMES_5(i_data[208 : 215]) , TIMES_8(i_data[216 : 223]) , i_data[224 : 231] , TIMES_4(i_data[232 : 239]) , i_data[240 : 247] , i_data[248 : 255] );

// ROW 4
assign o_data[256 : 263] = XORALL( i_data[256 : 263] , TIMES_9(i_data[264 : 271]) , TIMES_2(i_data[272 : 279] ) , TIMES_5(i_data[280 : 287]) , TIMES_8(i_data[288 : 295]) , i_data[296 : 303] , TIMES_4(i_data[304 : 311]) , i_data[312 : 319] );
assign o_data[264 : 271] = XORALL( i_data[256 : 263] , i_data[264 : 271] , TIMES_9(i_data[272 : 279] ) , TIMES_2(i_data[280 : 287]) , TIMES_5(i_data[288 : 295]) , TIMES_8(i_data[296 : 303]) , i_data[304 : 311] , TIMES_4(i_data[312 : 319]) );
assign o_data[272 : 279] = XORALL( TIMES_4(i_data[256 : 263]) , i_data[264 : 271] , i_data[272 : 279]  , TIMES_9(i_data[280 : 287]) , TIMES_2(i_data[288 : 295]) , TIMES_5(i_data[296 : 303]) , TIMES_8(i_data[304 : 311]) , i_data[312 : 319] );
assign o_data[280 : 287] = XORALL( i_data[256 : 263] , TIMES_4(i_data[264 : 271]) , i_data[272 : 279]  , i_data[280 : 287] , TIMES_9(i_data[288 : 295]) , TIMES_2(i_data[296 : 303]) , TIMES_5(i_data[304 : 311]) , TIMES_8(i_data[312 : 319]) );
assign o_data[288 : 295] = XORALL( TIMES_8(i_data[256 : 263]) , i_data[264 : 271] , TIMES_4(i_data[272 : 279] ) , i_data[280 : 287] , i_data[288 : 295] , TIMES_9(i_data[296 : 303]) , TIMES_2(i_data[304 : 311]) , TIMES_5(i_data[312 : 319]) );
assign o_data[296 : 303] = XORALL( TIMES_5(i_data[256 : 263]) , TIMES_8(i_data[264 : 271]) , i_data[272 : 279]  , TIMES_4(i_data[280 : 287]) , i_data[288 : 295] , i_data[296 : 303] , TIMES_9(i_data[304 : 311]) , TIMES_2(i_data[312 : 319]) );
assign o_data[304 : 311] = XORALL( TIMES_2(i_data[256 : 263]) , TIMES_5(i_data[264 : 271]) , TIMES_8(i_data[272 : 279] ) , i_data[280 : 287] , TIMES_4(i_data[288 : 295]) , i_data[296 : 303] , i_data[304 : 311] , TIMES_9(i_data[312 : 319]) );
assign o_data[312 : 319] = XORALL( TIMES_9(i_data[256 : 263]) , TIMES_2(i_data[264 : 271]) , TIMES_5(i_data[272 : 279] ) , TIMES_8(i_data[280 : 287]) , i_data[288 : 295] , TIMES_4(i_data[296 : 303]) , i_data[304 : 311] , i_data[312 : 319] );

// ROW 5
assign o_data[320 : 327] = XORALL( i_data[320 : 327] , TIMES_9(i_data[328 : 335]) , TIMES_2(i_data[336 : 343]) , TIMES_5(i_data[344 : 351]) , TIMES_8( i_data[352 : 359]) , i_data[360 : 367] , TIMES_4(i_data[368 : 375]) , i_data[376 : 383] );
assign o_data[328 : 335] = XORALL( i_data[320 : 327] , i_data[328 : 335] , TIMES_9(i_data[336 : 343]) , TIMES_2(i_data[344 : 351]) , TIMES_5( i_data[352 : 359]) , TIMES_8(i_data[360 : 367]) , i_data[368 : 375] , TIMES_4(i_data[376 : 383]) );
assign o_data[336 : 343] = XORALL( TIMES_4(i_data[320 : 327]) , i_data[328 : 335] , i_data[336 : 343] , TIMES_9(i_data[344 : 351]) , TIMES_2( i_data[352 : 359]) , TIMES_5(i_data[360 : 367]) , TIMES_8(i_data[368 : 375]) , i_data[376 : 383] );
assign o_data[344 : 351] = XORALL( i_data[320 : 327] , TIMES_4(i_data[328 : 335]) , i_data[336 : 343] , i_data[344 : 351] , TIMES_9( i_data[352 : 359]) , TIMES_2(i_data[360 : 367]) , TIMES_5(i_data[368 : 375]) , TIMES_8(i_data[376 : 383]) );
assign o_data[352 : 359] = XORALL( TIMES_8(i_data[320 : 327]) , i_data[328 : 335] , TIMES_4(i_data[336 : 343]) , i_data[344 : 351] ,  i_data[352 : 359] , TIMES_9(i_data[360 : 367]) , TIMES_2(i_data[368 : 375]) , TIMES_5(i_data[376 : 383]) );
assign o_data[360 : 367] = XORALL( TIMES_5(i_data[320 : 327]) , TIMES_8(i_data[328 : 335]) , i_data[336 : 343] , TIMES_4(i_data[344 : 351]) ,  i_data[352 : 359] , i_data[360 : 367] , TIMES_9(i_data[368 : 375]) , TIMES_2(i_data[376 : 383]) );
assign o_data[368 : 375] = XORALL( TIMES_2(i_data[320 : 327]) , TIMES_5(i_data[328 : 335]) , TIMES_8(i_data[336 : 343]) , i_data[344 : 351] , TIMES_4( i_data[352 : 359]) , i_data[360 : 367] , i_data[368 : 375] , TIMES_9(i_data[376 : 383]) );
assign o_data[376 : 383] = XORALL( TIMES_9(i_data[320 : 327]) , TIMES_2(i_data[328 : 335]) , TIMES_5(i_data[336 : 343]) , TIMES_8(i_data[344 : 351]) ,  i_data[352 : 359] , TIMES_4(i_data[360 : 367]) , i_data[368 : 375] , i_data[376 : 383] );

// ROW 6
assign o_data[384 : 391] = XORALL( i_data[384 : 391] , TIMES_9(i_data[392 : 399]) , TIMES_2(i_data[400 : 407]) , TIMES_5(i_data[408 : 415]) , TIMES_8(i_data[416 : 423]) , i_data[424 : 431] , TIMES_4(i_data[432 : 439]) , i_data[440 : 447] );
assign o_data[392 : 399] = XORALL( i_data[384 : 391] , i_data[392 : 399] , TIMES_9(i_data[400 : 407]) , TIMES_2(i_data[408 : 415]) , TIMES_5(i_data[416 : 423]) , TIMES_8(i_data[424 : 431]) , i_data[432 : 439] , TIMES_4(i_data[440 : 447]) );
assign o_data[400 : 407] = XORALL( TIMES_4(i_data[384 : 391]) , i_data[392 : 399] , i_data[400 : 407] , TIMES_9(i_data[408 : 415]) , TIMES_2(i_data[416 : 423]) , TIMES_5(i_data[424 : 431]) , TIMES_8(i_data[432 : 439]) , i_data[440 : 447] );
assign o_data[408 : 415] = XORALL( i_data[384 : 391] , TIMES_4(i_data[392 : 399]) , i_data[400 : 407] , i_data[408 : 415] , TIMES_9(i_data[416 : 423]) , TIMES_2(i_data[424 : 431]) , TIMES_5(i_data[432 : 439]) , TIMES_8(i_data[440 : 447]) );
assign o_data[416 : 423] = XORALL( TIMES_8(i_data[384 : 391]) , i_data[392 : 399] , TIMES_4(i_data[400 : 407]) , i_data[408 : 415] , i_data[416 : 423] , TIMES_9(i_data[424 : 431]) , TIMES_2(i_data[432 : 439]) , TIMES_5(i_data[440 : 447]) );
assign o_data[424 : 431] = XORALL( TIMES_5(i_data[384 : 391]) , TIMES_8(i_data[392 : 399]) , i_data[400 : 407] , TIMES_4(i_data[408 : 415]) , i_data[416 : 423] , i_data[424 : 431] , TIMES_9(i_data[432 : 439]) , TIMES_2(i_data[440 : 447]) );
assign o_data[432 : 439] = XORALL( TIMES_2(i_data[384 : 391]) , TIMES_5(i_data[392 : 399]) , TIMES_8(i_data[400 : 407]) , i_data[408 : 415] , TIMES_4(i_data[416 : 423]) , i_data[424 : 431] , i_data[432 : 439] , TIMES_9(i_data[440 : 447]) );
assign o_data[440 : 447] = XORALL( TIMES_9(i_data[384 : 391]) , TIMES_2(i_data[392 : 399]) , TIMES_5(i_data[400 : 407]) , TIMES_8(i_data[408 : 415]) , i_data[416 : 423] , TIMES_4(i_data[424 : 431]) , i_data[432 : 439] , i_data[440 : 447] );

// ROW 7
assign o_data[448 : 455] = XORALL( i_data[448 : 455] , TIMES_9(i_data[456 : 463]) , TIMES_2(i_data[464 : 471]) , TIMES_5(i_data[472 : 479]) , TIMES_8(i_data[480 : 487]) , i_data[488 : 495] , TIMES_4(i_data[496 : 503]) , i_data[504 : 511] );
assign o_data[456 : 463] = XORALL( i_data[448 : 455] , i_data[456 : 463] , TIMES_9(i_data[464 : 471]) , TIMES_2(i_data[472 : 479]) , TIMES_5(i_data[480 : 487]) , TIMES_8(i_data[488 : 495]) , i_data[496 : 503] , TIMES_4(i_data[504 : 511]) );
assign o_data[464 : 471] = XORALL( TIMES_4(i_data[448 : 455]) , i_data[456 : 463] , i_data[464 : 471] , TIMES_9(i_data[472 : 479]) , TIMES_2(i_data[480 : 487]) , TIMES_5(i_data[488 : 495]) , TIMES_8(i_data[496 : 503]) , i_data[504 : 511] );
assign o_data[472 : 479] = XORALL( i_data[448 : 455] , TIMES_4(i_data[456 : 463]) , i_data[464 : 471] , i_data[472 : 479] , TIMES_9(i_data[480 : 487]) , TIMES_2(i_data[488 : 495]) , TIMES_5(i_data[496 : 503]) , TIMES_8(i_data[504 : 511]) );
assign o_data[480 : 487] = XORALL( TIMES_8(i_data[448 : 455]) , i_data[456 : 463] , TIMES_4(i_data[464 : 471]) , i_data[472 : 479] , i_data[480 : 487] , TIMES_9(i_data[488 : 495]) , TIMES_2(i_data[496 : 503]) , TIMES_5(i_data[504 : 511]) );
assign o_data[488 : 495] = XORALL( TIMES_5(i_data[448 : 455]) , TIMES_8(i_data[456 : 463]) , i_data[464 : 471] , TIMES_4(i_data[472 : 479]) , i_data[480 : 487] , i_data[488 : 495] , TIMES_9(i_data[496 : 503]) , TIMES_2(i_data[504 : 511]) );
assign o_data[496 : 503] = XORALL( TIMES_2(i_data[448 : 455]) , TIMES_5(i_data[456 : 463]) , TIMES_8(i_data[464 : 471]) , i_data[472 : 479] , TIMES_4(i_data[480 : 487]) , i_data[488 : 495] , i_data[496 : 503] , TIMES_9(i_data[504 : 511]) );
assign o_data[504 : 511] = XORALL( TIMES_9(i_data[448 : 455]) , TIMES_2(i_data[456 : 463]) , TIMES_5(i_data[464 : 471]) , TIMES_8(i_data[472 : 479]) , i_data[480 : 487] , TIMES_4(i_data[488 : 495]) , i_data[496 : 503] , i_data[504 : 511] );


endmodule