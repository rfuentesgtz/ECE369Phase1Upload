`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 08:21:26 AM
// Design Name: 
// Module Name: TwoShift28Bit
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


module TwoShift28Bit(inputVal, outputVal);
    input[27:0] inputVal;
    output reg [27:0] outputVal;
    
    always@(*) outputVal <= inputVal << 2;
endmodule
