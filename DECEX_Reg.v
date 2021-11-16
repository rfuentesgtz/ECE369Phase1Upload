`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2021 09:24:29 AM
// Design Name: 
// Module Name: DEC_EX_Reg
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


module DECEX_Reg(
    //Stage 3 Requirements (not used in subsequent stages)
    ShamtIn,ReadData1In,ReadData2In,ImmediateIn,JAddressIn,
    HiLoIn,
    ALUSrc1In, ALUSrc2In,MoveSrcIn,ZeroSrcIn,JrSrcIn,
    MoveIn,BranchIn,
    ALUOpIn, JumpIn,
    ShamtOut,ReadData1Out,ReadData2Out,ImmediateOut,JAddressOut,
    HiLoOut,
    ALUSrc1Out, ALUSrc2Out,MoveSrcOut,ZeroSrcOut,JrSrcOut,
    MoveOut,BranchOut,
    ALUOpOut,JumpOut,
    //Stage 3 + 5
    PC4In,
    PC4Out,
    RegWriteIn,
    RegWriteOut,
    //Stage 4 Requirements (not used in subsequent stages)
    bytes2LoadIn, bytes2StoreIn,
    MemReadIn, MemWriteIn,
    bytes2LoadOut, bytes2StoreOut,
    MemReadOut, MemWriteOut,
    //Stage 5 Requirements that we need to carry through
    MemToRegIn,
    HiSrcIn,LoSrcIn,LinkIn,RegDstIn,
    MemToRegOut,
    HiSrcOut,LoSrcOut,LinkOut,RegDstOut,
    HiWriteIn, LoWriteIn,
    HiWriteOut, LoWriteOut,
    //Clock
    Clk, DECEX_stall
    );
    //Inputs & Outputs & MemoryDeclarations
    
    //STAGE 3
    //inputs
    input[31:0] ShamtIn,ReadData1In,ReadData2In,ImmediateIn,JAddressIn;
    input [63:0] HiLoIn;
    input ALUSrc1In, ALUSrc2In,MoveSrcIn,ZeroSrcIn,JrSrcIn, JumpIn, DECEX_stall;
    input MoveIn,BranchIn;
    input [4:0] ALUOpIn;
    //outputs
    output reg [31:0] ShamtOut,ReadData1Out,ReadData2Out,ImmediateOut,JAddressOut;
    output reg [63:0] HiLoOut;
    output reg ALUSrc1Out, ALUSrc2Out,MoveSrcOut,ZeroSrcOut,JrSrcOut, JumpOut;
    output reg MoveOut,BranchOut;
    output reg [4:0] ALUOpOut;
    //Memory declarations
    reg [31:0] Shamt,ReadData1,ReadData2,Immediate,JAddress;
    reg [63:0] HiLo;
    reg ALUSrc1, ALUSrc2,MoveSrc,ZeroSrc,JrSrc, Jump;
    reg Move,Branch;
    reg [4:0] ALUOp;
    
    //STAGE 3 + 5
    input[31:0] PC4In;
    input RegWriteIn;
    output reg[31:0] PC4Out;
    output reg RegWriteOut;
    reg [31:0] PC4;
    reg RegWrite;
    
    //STAGE 4
    //Inputs
    input[1:0] bytes2LoadIn, bytes2StoreIn;
    input MemReadIn, MemWriteIn;
    //Ouputs
    output reg[1:0] bytes2LoadOut, bytes2StoreOut;
    output reg MemReadOut, MemWriteOut;
    //Memory
    reg[1:0] bytes2Load, bytes2Store;
    reg MemRead, MemWrite;
    
    //STAGE 5
    //Inputs
    input MemToRegIn,HiSrcIn,LoSrcIn,LinkIn;
    input [4:0] RegDstIn;
    input Clk;
    input HiWriteIn, LoWriteIn;
    //Outputs
    output reg MemToRegOut,HiSrcOut,LoSrcOut,LinkOut;
    output reg [4:0] RegDstOut;
    output reg HiWriteOut, LoWriteOut;
    //Memory declarations
    reg MemToReg,HiSrc,LoSrc,Link;
    reg [4:0] RegDst;
    reg HiWrite, LoWrite;
    
    //Initial state with NOOps
    initial begin
        Shamt <= 0; //Comes from stage 2
        ReadData1 <= 0; //Comes from stage 2
        ReadData2 <= 0; //Comes from stage 2
        Immediate <= 0; //Comes from stage 2
        JAddress <= 0; //Comes from stage 2
        HiLo <= 0; //Comes from stage 2
        ALUSrc1 <= 0; //Comes from stage 2
        ALUSrc2 <= 0; //Comes from stage 2
        MoveSrc <= 0; //Comes from stage 2
        ZeroSrc <= 0; //Comes from stage 2
        JrSrc <= 0; //Comes from stage 2
        Move <= 0; //Comes from stage 2
        Branch <= 0; //Comes from stage 2
        Jump <= 0;
        ALUOp <= 0; //Comes from stage 2
        //STAGE 3 + 5
        PC4 <= 0; //Comes from stage 1
        RegWrite <= 0; //Comes from stage 2
        //STAGE 4
        bytes2Load <= 0; //Comes from stage 2, goes through 3
        bytes2Store <= 0; //Comes from stage 2, goes through 3
        MemRead <= 0; //Comes from stage 2, goes through 3
        MemWrite <= 0; //Comes from stage 2, goes through 3
        //STAGE 5
        MemToReg <= 0; //Comes from stage 2, goes thru 3 and 4
        HiSrc <= 0; //Comes from stage 2, goes thru 3 and 4
        LoSrc <= 0; //Comes from stage 2, goes thru 3 and 4
        Link <= 0; //Comes from stage 2, goes thru 3 and 4
        RegDst <= 0; //Comes from stage 2, goes thru 3 and 4
        HiWrite <= 0;
        LoWrite <= 0;
    
    end
    
    
    //Write declarations
    always @(posedge Clk) begin
        if (DECEX_stall == 0) begin
            Shamt <= ShamtIn; //Comes from stage 2
            ReadData1 <= ReadData1In; //Comes from stage 2
            ReadData2 <= ReadData2In; //Comes from stage 2
            Immediate <= ImmediateIn; //Comes from stage 2
            JAddress <= JAddressIn; //Comes from stage 2
            HiLo <= HiLoIn; //Comes from stage 2
            ALUSrc1 <= ALUSrc1In; //Comes from stage 2
            ALUSrc2 <= ALUSrc2In; //Comes from stage 2
            MoveSrc <= MoveSrcIn; //Comes from stage 2
            ZeroSrc <= ZeroSrcIn; //Comes from stage 2
            JrSrc <= JrSrcIn; //Comes from stage 2
            Move <= MoveIn; //Comes from stage 2
            Branch <= BranchIn; //Comes from stage 2
            Jump <= JumpIn;
            ALUOp <= ALUOpIn; //Comes from stage 2
            //STAGE 3 + 5
            PC4 <= PC4In; //Comes from stage 1
            RegWrite <= RegWriteIn; //Comes from stage 2
            //STAGE 4
            bytes2Load <= bytes2LoadIn; //Comes from stage 2, goes through 3
            bytes2Store <= bytes2StoreIn; //Comes from stage 2, goes through 3
            MemRead <= MemReadIn; //Comes from stage 2, goes through 3
            MemWrite <= MemWriteIn; //Comes from stage 2, goes through 3
            //STAGE 5
            MemToReg <= MemToRegIn; //Comes from stage 2, goes thru 3 and 4
            HiSrc <= HiSrcIn; //Comes from stage 2, goes thru 3 and 4
            LoSrc <= LoSrcIn; //Comes from stage 2, goes thru 3 and 4
            Link <= LinkIn; //Comes from stage 2, goes thru 3 and 4
            RegDst <= RegDstIn; //Comes from stage 2, goes thru 3 and 4
            HiWrite <= HiWriteIn;
            LoWrite <= LoWriteIn;
         end
        else begin 
           Shamt <= 0; //Comes from stage 2
            ReadData1 <= 0; //Comes from stage 2
            ReadData2 <= 0; //Comes from stage 2
            Immediate <= 0; //Comes from stage 2
            JAddress <= 0; //Comes from stage 2
            HiLo <= 0; //Comes from stage 2
            ALUSrc1 <= 0; //Comes from stage 2
            ALUSrc2 <= 0; //Comes from stage 2
            MoveSrc <= 0; //Comes from stage 2
            ZeroSrc <= 0; //Comes from stage 2
            JrSrc <= 0; //Comes from stage 2
            Move <= 0; //Comes from stage 2
            Branch <= 0; //Comes from stage 2
            Jump <= 0;
            ALUOp <= 0; //Comes from stage 2
            //STAGE 3 + 5
            PC4 <= 0; //Comes from stage 1
            RegWrite <= 0; //Comes from stage 2
            //STAGE 4
            bytes2Load <= 0; //Comes from stage 2, goes through 3
            bytes2Store <= 0; //Comes from stage 2, goes through 3
            MemRead <= 0; //Comes from stage 2, goes through 3
            MemWrite <= 0; //Comes from stage 2, goes through 3
            //STAGE 5
            MemToReg <= 0; //Comes from stage 2, goes thru 3 and 4
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
        ShamtOut <= Shamt; //Used as possible ALU input A
        ReadData1Out <= ReadData1; //Used as possible ALU input A
        ReadData2Out <= ReadData2; //Used as possible ALU input B
        ImmediateOut <= Immediate; //Used as possible ALU input B as well as relative branch operation
        JAddressOut <= JAddress; //Used as a possible jump address for PC + 4
        HiLoOut <= HiLo; //ALU Input, concatenated values from hi lo
        ALUSrc1Out <= ALUSrc1; //Chooses ALU Input A
        ALUSrc2Out <= ALUSrc2; //Chooses ALU Input B
        MoveSrcOut <= MoveSrc; //Chooses a src for the move xor operation
        ZeroSrcOut <= ZeroSrc; //Used when choosing a source for brancg operations
        JrSrcOut <= JrSrc; //Chooses whether to store regular value or $rs into PC
        MoveOut <= Move; //Activates move operations
        BranchOut <= Branch; //Activates branch operations
        JumpOut <= Jump;
        ALUOpOut <= ALUOp; //Input ALU operation
        //STAGE 3 + 5
        PC4Out <= PC4; //Computes new Pc Address AND may be used for jal
        RegWriteOut <= RegWrite; //Used to compute a new RegWrite to get the true signal
        //STAGE 4
        bytes2LoadOut <= bytes2Load; //Used when loading from memory
        bytes2StoreOut <= bytes2Store; //Used when storing to memory
        MemReadOut <= MemRead; //Used when reading memory
        MemWriteOut <= MemWrite; //Used when writing/storing to memory
        //STAGE 5
        MemToRegOut <= MemToReg; //Chooses between ALUResult and LoadData
        HiSrcOut <= HiSrc; //Chooses source for Hi input between ALU64Result and ALUResult
        LoSrcOut <= LoSrc; //Chooses source for lo input between ALU64Result and ALUResult
        LinkOut <= Link; //Chooses write data between ALU64Result and PC + 4
        RegDstOut <= RegDst; //Chooses register to store results in
        HiWriteOut <= HiWrite;
        LoWriteOut <= LoWrite;
    end
  
endmodule
