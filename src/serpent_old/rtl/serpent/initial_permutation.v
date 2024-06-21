module initial_permutation (
    input wire [127:0] i_data,
    output wire [127:0] o_data
);

//---------wires, registers----------
// assign o_data = {
//     i_data[0], i_data[32], i_data[64], i_data[96], 
//     i_data[1], i_data[33], i_data[65], i_data[97], 
//     i_data[2], i_data[34], i_data[66], i_data[98], 
//     i_data[3], i_data[35], i_data[67], i_data[99], 
//     i_data[4], i_data[36], i_data[68], i_data[100], 
//     i_data[5], i_data[37], i_data[69], i_data[101], 
//     i_data[6], i_data[38], i_data[70], i_data[102], 
//     i_data[7], i_data[39], i_data[71], i_data[103], 
//     i_data[8], i_data[40], i_data[72], i_data[104], 
//     i_data[9], i_data[41], i_data[73], i_data[105], 
//     i_data[10], i_data[42], i_data[74], i_data[106], 
//     i_data[11], i_data[43], i_data[75], i_data[107], 
//     i_data[12], i_data[44], i_data[76], i_data[108], 
//     i_data[13], i_data[45], i_data[77], i_data[109], 
//     i_data[14], i_data[46], i_data[78], i_data[110], 
//     i_data[15], i_data[47], i_data[79], i_data[111], 
//     i_data[16], i_data[48], i_data[80], i_data[112], 
//     i_data[17], i_data[49], i_data[81], i_data[113], 
//     i_data[18], i_data[50], i_data[82], i_data[114], 
//     i_data[19], i_data[51], i_data[83], i_data[115], 
//     i_data[20], i_data[52], i_data[84], i_data[116], 
//     i_data[21], i_data[53], i_data[85], i_data[117], 
//     i_data[22], i_data[54], i_data[86], i_data[118], 
//     i_data[23], i_data[55], i_data[87], i_data[119], 
//     i_data[24], i_data[56], i_data[88], i_data[120], 
//     i_data[25], i_data[57], i_data[89], i_data[121], 
//     i_data[26], i_data[58], i_data[90], i_data[122], 
//     i_data[27], i_data[59], i_data[91], i_data[123], 
//     i_data[28], i_data[60], i_data[92], i_data[124], 
//     i_data[29], i_data[61], i_data[93], i_data[125], 
//     i_data[30], i_data[62], i_data[94], i_data[126], 
//     i_data[31], i_data[63], i_data[95], i_data[127]
// };


assign o_data = {
    i_data[127], i_data[95], i_data[63], i_data[31],
    i_data[126], i_data[94], i_data[62], i_data[30],
    i_data[125], i_data[93], i_data[61], i_data[29],
    i_data[124], i_data[92], i_data[60], i_data[28],
    i_data[123], i_data[91], i_data[59], i_data[27],
    i_data[122], i_data[90], i_data[58], i_data[26],
    i_data[121], i_data[89], i_data[57], i_data[25],
    i_data[120], i_data[88], i_data[56], i_data[24],
    i_data[119], i_data[87], i_data[55], i_data[23],
    i_data[118], i_data[86], i_data[54], i_data[22],
    i_data[117], i_data[85], i_data[53], i_data[21],
    i_data[116], i_data[84], i_data[52], i_data[20],
    i_data[115], i_data[83], i_data[51], i_data[19],
    i_data[114], i_data[82], i_data[50], i_data[18],
    i_data[113], i_data[81], i_data[49], i_data[17],
    i_data[112], i_data[80], i_data[48], i_data[16],
    i_data[111], i_data[79], i_data[47], i_data[15],
    i_data[110], i_data[78], i_data[46], i_data[14],
    i_data[109], i_data[77], i_data[45], i_data[13],
    i_data[108], i_data[76], i_data[44], i_data[12],
    i_data[107], i_data[75], i_data[43], i_data[11],
    i_data[106], i_data[74], i_data[42], i_data[10],
    i_data[105], i_data[73], i_data[41], i_data[9],
    i_data[104], i_data[72], i_data[40], i_data[8],
    i_data[103], i_data[71], i_data[39], i_data[7],
    i_data[102], i_data[70], i_data[38], i_data[6],
    i_data[101], i_data[69], i_data[37], i_data[5],
    i_data[100], i_data[68], i_data[36], i_data[4],
    i_data[99], i_data[67], i_data[35], i_data[3],
    i_data[98], i_data[66], i_data[34], i_data[2],
    i_data[97], i_data[65], i_data[33], i_data[1],
    i_data[96], i_data[64], i_data[32], i_data[0]
};


endmodule
