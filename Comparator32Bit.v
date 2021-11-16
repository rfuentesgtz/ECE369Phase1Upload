`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2021 11:16:27 AM
// Design Name: 
// Module Name: Comparator32Bit
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


module Comparator32Bit(A,B,AltB,AeqB,AgtB);
    
    input [31:0] A,B;
    output reg AltB,AeqB,AgtB;
    
    always @(*) begin
        if (A > B) begin
            AltB <= 0;
            AeqB <= 0;
            AgtB <= 1;
        end
        
        else if (A == B) begin
            AltB <= 0;
            AeqB <= 1;
            AgtB <= 0;
        end
        else if (A < B) begin
            AltB <= 1;
            AeqB <= 0;
            AgtB <= 0;
        end
        else begin
            AltB <= 0;
            AeqB <= 0;
            AgtB <= 0;
        end
    end
endmodule
