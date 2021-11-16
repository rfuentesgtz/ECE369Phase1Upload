`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 08:53:20 AM
// Design Name: 
// Module Name: EX_MEM_Reg
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


module EXMEM_Reg(
    //Stage 4 Requirements (not used in subsequent stages)
    bytes2LoadIn, bytes2StoreIn,
    MemReadIn, MemWriteIn,
    bytes2LoadOut, bytes2StoreOut,
    MemReadOut, MemWriteOut,
    MemWriteDataIn,MemWriteDataOut,
    //Stage 4 + 5 (used in both)
    ALUResultIn,
    ALUResultOut,
    //Stage 5 Requirements that we need to carry through
    MemToRegIn, RegWriteIn,
    ALU64ResultIn,HiSrcIn,LoSrcIn,LinkIn,RegDstIn, PC4In,
    MemToRegOut, RegWriteOut,
    ALU64ResultOut,HiSrcOut,LoSrcOut,LinkOut,RegDstOut, PC4Out,
    HiWriteIn, LoWriteIn,
    HiWriteOut, LoWriteOut,
    //Clock
    Clk, 
    stall_EXMEM
    );
    //Inputs & Outputs & MemoryDeclarations
    
    //STAGE 4
    //Inputs
    input[1:0] bytes2LoadIn, bytes2StoreIn;
    input MemReadIn, MemWriteIn, stall_EXMEM;
    input[31:0] MemWriteDataIn;
    //Ouputs
    output reg[1:0] bytes2LoadOut, bytes2StoreOut;
    output reg MemReadOut, MemWriteOut;
    output reg[31:0] MemWriteDataOut;
    //Memory
    reg[1:0] bytes2Load, bytes2Store;
    reg MemRead, MemWrite;
    reg[31:0] MemWriteData;
    
    //STAGE 4 + 5
    input[31:0] ALUResultIn;
    output reg[31:0] ALUResultOut;
    reg[31:0] ALUResult;
    
    //STAGE 5
    //Inputs
    input[31:0] PC4In;
    input[63:0] ALU64ResultIn;
    input MemToRegIn,RegWriteIn,HiSrcIn,LoSrcIn,LinkIn;
    input [4:0] RegDstIn;
    input Clk;
    input HiWriteIn, LoWriteIn;
    //Outputs
    output reg[31:0] PC4Out;
    output reg [63:0] ALU64ResultOut;
    output reg MemToRegOut,RegWriteOut,HiSrcOut,LoSrcOut,LinkOut;
    output reg [4:0] RegDstOut;
    output reg HiWriteOut, LoWriteOut;
    //Memory declarations
    reg[31:0] LoadData, PC4;
    reg[63:0] ALU64Result;
    reg MemToReg,RegWrite,HiSrc,LoSrc,Link;
    reg [4:0] RegDst;
    reg HiWrite, LoWrite;
    
    //Initial state with noops
    initial begin
    //STAGE 4
    bytes2Load <= 0; //Comes from stage 2, goes through 3
    bytes2Store <= 0; //Comes from stage 2, goes through 3
    MemRead <= 0; //Comes from stage 2, goes through 3
    MemWrite <= 0; //Comes from stage 2, goes through 3
    MemWriteData <= 0;
    //STAGE 4 + 5
    ALUResult <= 0; //Comes from stage 3, goes thru 4
    //STAGE 5
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
    
    
    //Write declarations
    always @(posedge Clk) begin
        if (stall_EXMEM == 0) begin 
            //STAGE 4
            bytes2Load <= bytes2LoadIn; //Comes from stage 2, goes through 3
            bytes2Store <= bytes2StoreIn; //Comes from stage 2, goes through 3
            MemRead <= MemReadIn; //Comes from stage 2, goes through 3
            MemWrite <= MemWriteIn; //Comes from stage 2, goes through 3
            MemWriteData <= MemWriteDataIn;
            //STAGE 4 + 5
            ALUResult <= ALUResultIn; //Comes from stage 3, goes thru 4
            //STAGE 5
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
        //STAGE 4
            bytes2Load <= 0; //Comes from stage 2, goes through 3
            bytes2Store <= 0; //Comes from stage 2, goes through 3
            MemRead <= 0; //Comes from stage 2, goes through 3
            MemWrite <= 0; //Comes from stage 2, goes through 3
            MemWriteData <= 0;
            //STAGE 4 + 5
            ALUResult <= 0; //Comes from stage 3, goes thru 4
            //STAGE 5
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
    //Read declarations
    always @(*) begin
    //STAGE 4
    bytes2LoadOut <= bytes2Load; //Used when loading from memory
    bytes2StoreOut <= bytes2Store; //Used when storing to memory
    MemReadOut <= MemRead; //Used when reading memory
    MemWriteOut <= MemWrite; //Used when writing/storing to memory
    MemWriteDataOut <= MemWriteData;
    //STAGE 4 + 5
    ALUResultOut <= ALUResult; //Used when accessing memory address and for storing ALU Result into register
    //STAGE 5
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
