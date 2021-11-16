`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 12:15:35 PM
// Design Name: 
// Module Name: FE_DEC_Reg
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


module FEDEC_Reg(
    InstructionIn,PC4In,
    InstructionOut,PC4Out,
    Clk, IFID_write, IF_flush
    );
    input Clk, IFID_write, IF_flush;
    input [31:0] InstructionIn, PC4In;
    output reg [31:0] InstructionOut, PC4Out;
    //Memory Allocation
    reg [31:0] Instruction, PC4;
    //
    initial begin
        Instruction <= 0;
        PC4 <= 0;
    end
    //Write operations: only update at posedge 
    always @(posedge Clk) begin
        if (IFID_write == 1) begin 
            Instruction <= InstructionIn;
            PC4 <= PC4In; 
        end
        //flush
        else if (IF_flush == 1) begin
            Instruction <= 32'b0;
            PC4 <= 32'b0; //tentative
        end
    end
    //Read operations : read any time, output un-updated value at any time
    always @(*) begin
        InstructionOut <= Instruction;
        PC4Out <= PC4;
    end
endmodule
