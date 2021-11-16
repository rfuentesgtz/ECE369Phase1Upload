`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2021 01:04:32 PM
// Design Name: 
// Module Name: Test1
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


module Test1();
    reg Clk, Rst;
    wire[6:0] out7;
    wire[7:0] en_out;
    
    Top1 TestTop1(Clk, Rst, out7, en_out);
    
    initial begin
    Clk <= 0;
    Rst <= 1;
    @(posedge Clk);
    #50 Rst <= 0;
    end
    
    always begin
        Clk <= 0;
        #200;
        Clk <= 1;
        #200;
    end
endmodule
