`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 08:24:21 AM
// Design Name: 
// Module Name: TwoShift32Bit
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


module TwoShift32Bit(inputVal, outputVal);
    input[31:0] inputVal;
    output reg [31:0] outputVal;
    
    always@(*) outputVal <= inputVal << 2;
endmodule
