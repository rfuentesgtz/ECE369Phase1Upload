`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2021 10:23:02 AM
// Design Name: 
// Module Name: OR1bit
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


module OR1bit(A,B,Out

    );
    input A,B;
    output reg Out;
    
    always @(*) Out <= A || B;
endmodule
