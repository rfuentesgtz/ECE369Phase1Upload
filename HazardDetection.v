`timescale 1ns / 1ps

module HazardDetection(
    //dependency Inputs
    RegDst_EX, RegDst_MEM, RegDst_WB, 
    Rs_DEC, Rt_DEC,
    RegWrite_EX, RegWrite_MEM, RegWrite_WB,
    //Branch and jump/jr inputs
    BranchAND, Jump, JumpRegister,
    //Outputs
    stall_IDEX, stall_EXMEM, stall_MEMWB,
    IFID_write, PC_write, IF_flush);
    
    input [4:0] RegDst_EX, RegDst_MEM, RegDst_WB, Rs_DEC, Rt_DEC;
    input  RegWrite_EX, RegWrite_MEM, RegWrite_WB;
    input BranchAND, Jump, JumpRegister;
    output reg stall_IDEX, stall_EXMEM, stall_MEMWB,  IFID_write, PC_write, IF_flush;
    
    initial begin
        PC_write <= 1; IFID_write <= 1; IF_flush <= 0;
        stall_IDEX <=0; stall_EXMEM <= 0; stall_MEMWB <= 0;
    end
    //stall = 0 means do not stall
    always @ (*) begin
        //FIRST CHECK FOR DEPENDENCIES
        //DEPENDENCIES MUST BE SOLVED BEFORE DOING JUMPS OR BRANCHES
        //Instr_p is in EX, Instr_c is in DEC 
        if (((RegDst_EX == Rs_DEC ) || (RegDst_EX == Rt_DEC)) && RegWrite_EX == 1 && RegDst_EX != 0) begin 
            PC_write <= 0; IFID_write <= 0; IF_flush <= 0;
            stall_IDEX <=1; stall_EXMEM <= 0; stall_MEMWB <= 0;
        end 
        //Instr_p is in MEM, Instr_c is in DEC 
        else if (((RegDst_MEM == Rs_DEC ) || (RegDst_MEM == Rt_DEC)) && RegWrite_MEM == 1 && RegDst_MEM != 0) begin 
            PC_write <= 0; IFID_write <= 0; IF_flush <= 0;
            stall_IDEX <=1; stall_EXMEM <= 0; stall_MEMWB <= 0; //still need to see if prev stages' stalls should remain 1. 
        end 
        //Instr_p is in WB, Instr_c is in DEC 
        else if (((RegDst_WB == Rs_DEC ) || (RegDst_WB == Rt_DEC)) && RegWrite_WB == 1 && RegDst_WB != 0) begin 
            PC_write <= 0; IFID_write <= 0; IF_flush <= 0;
            stall_IDEX <=1; stall_EXMEM <= 0; stall_MEMWB <= 0; 
        end
        //BRANCH/JUMP flushing, in theory to execute this, no dependencies must occur above
        //We always assume branch is not taken
         else if (BranchAND == 1 || Jump == 1 || JumpRegister == 1) begin 
            PC_write <= 1; IFID_write <= 0; IF_flush <= 1;
            stall_IDEX <=0; stall_EXMEM <= 0; stall_MEMWB <= 0; 
            end
        //no dependency nor branches/jumps
        else begin 
            PC_write <= 1; IFID_write <= 1; IF_flush <= 0;
            stall_IDEX <=0; stall_EXMEM <= 0; stall_MEMWB <= 0;
        end
    end     
   
endmodule
