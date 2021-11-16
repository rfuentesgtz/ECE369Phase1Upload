`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2021 04:12:03 PM
// Design Name: 
// Module Name: ZeroXOR
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


module ZeroXOR(moveInput, XORZero);
    input [31:0] moveInput;
    output reg XORZero;
    
    always @(*) XORZero <= moveInput ^ 32'b0;
endmodule
