`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 08:26:06 AM
// Design Name: 
// Module Name: Mem_WB_Reg
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


module MEMWB_Reg(
    MemToRegIn, LoadDataIn, ALUResultIn, RegWriteIn,
    ALU64ResultIn,HiSrcIn,LoSrcIn,LinkIn,RegDstIn, PC4In,
    MemToRegOut, LoadDataOut, ALUResultOut, RegWriteOut,
    ALU64ResultOut,HiSrcOut,LoSrcOut,LinkOut,RegDstOut, PC4Out,
    HiWriteIn, LoWriteIn,
    HiWriteOut,LoWriteOut,
    //Clock
    Clk, stall_MEMWB
    );
    //Inputs
    input[31:0] LoadDataIn,ALUResultIn, PC4In;
    input[63:0] ALU64ResultIn;
    input MemToRegIn,RegWriteIn,HiSrcIn,LoSrcIn,LinkIn, stall_MEMWB;
    input [4:0] RegDstIn;
    input Clk;
    input HiWriteIn, LoWriteIn;
    //Outputs
    output reg[31:0] LoadDataOut,ALUResultOut, PC4Out;
    output reg [63:0] ALU64ResultOut;
    output reg MemToRegOut,RegWriteOut,HiSrcOut,LoSrcOut,LinkOut;
    output reg [4:0] RegDstOut;
    output reg HiWriteOut, LoWriteOut;
    //Memory declarations
    reg[31:0] LoadData, ALUResult, PC4;
    reg[63:0] ALU64Result;
    reg MemToReg,RegWrite,HiSrc,LoSrc,Link;
    reg [4:0] RegDst;
    reg HiWrite, LoWrite;
    
    //Initial state with noops
    initial begin
    LoadData <= 0; //Comes from stage 4
    ALUResult <= 0; //Comes from stage 3, goes thru 4
    PC4 <= 0; //Comes from stage 2, goes thru 3 and 4
    ALU64Result <= 0; //Comes from stage 3, goes thru 4
    MemToReg <= 0; //Comes from stage 2, goes thru 3 and 4
    RegWrite <= 0; //Comes from stage 2, goes thru 3 and 4
    HiSrc <= 0; //Comes from stage 2, goes thru 3 and 4
    LoSrc <= 0; //Comes from stage 2, goes thru 3 and 4
    Link <= 0; //Comes from stage 2, goes thru 3 and 4
    RegDst <= 0; //Comes from stage 2, goes thru 3 and 4
    HiWrite <= 0;
    LoWrite <= 0;
    
    end
    //Write declarations: we will UPDATE at posedge, and output any time
    always @(posedge Clk) begin 
        if (stall_MEMWB == 0) begin 
            LoadData <= LoadDataIn; //Comes from stage 4
            ALUResult <= ALUResultIn; //Comes from stage 3, goes thru 4
            PC4 <= PC4In; //Comes from stage 2, goes thru 3 and 4
            ALU64Result <= ALU64ResultIn; //Comes from stage 3, goes thru 4
            MemToReg <= MemToRegIn; //Comes from stage 2, goes thru 3 and 4
            RegWrite <= RegWriteIn; //Comes from stage 2, goes thru 3 and 4
            HiSrc <= HiSrcIn; //Comes from stage 2, goes thru 3 and 4
            LoSrc <= LoSrcIn; //Comes from stage 2, goes thru 3 and 4
            Link <= LinkIn; //Comes from stage 2, goes thru 3 and 4
            RegDst <= RegDstIn; //Comes from stage 2, goes thru 3 and 4
            HiWrite <= HiWriteIn;
            LoWrite <= LoWriteIn;
        end
        else begin
            LoadData <= 0; //Comes from stage 4
            ALUResult <= 0; //Comes from stage 3, goes thru 4
            PC4 <= 0; //Comes from stage 2, goes thru 3 and 4
            ALU64Result <= 0; //Comes from stage 3, goes thru 4
            MemToReg <= 0; //Comes from stage 2, goes thru 3 and 4
            RegWrite <= 0; //Comes from stage 2, goes thru 3 and 4
            HiSrc <= 0; //Comes from stage 2, goes thru 3 and 4
            LoSrc <= 0; //Comes from stage 2, goes thru 3 and 4
            Link <= 0; //Comes from stage 2, goes thru 3 and 4
            RegDst <= 0; //Comes from stage 2, goes thru 3 and 4
            HiWrite <= 0;
            LoWrite <= 0;
        end
    end 
    //Read declarations: we will OUTPUT whenever, but only update at posedge
    always @(*) begin
    LoadDataOut <= LoadData; //Used when loading
    ALUResultOut <= ALUResult; //Used when storing ALU Result into register
    PC4Out <= PC4; //Goes as possible input to $Ra
    ALU64ResultOut <= ALU64Result; //Used for special HiLo operations
    MemToRegOut <= MemToReg; //Chooses between ALUResult and LoadData
    RegWriteOut <= RegWrite; //Control signal for writing to register
    HiSrcOut <= HiSrc; //Chooses source for Hi input between ALU64Result and ALUResult
    LoSrcOut <= LoSrc; //Chooses source for lo input between ALU64Result and ALUResult
    LinkOut <= Link; //Chooses write data between ALU64Result and PC + 4
    RegDstOut <= RegDst; //Chooses register to store results in
    HiWriteOut <= HiWrite;
    LoWriteOut <= LoWrite;
    end
endmodule
