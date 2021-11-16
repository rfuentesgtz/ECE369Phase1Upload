`timescale 1ns / 1ps


module HazardDetectionRahel(
    RegDst_EX, RegDst_MEM, RegDst_WB, 
    Rs_DEC, Rt_DEC,
    MemRead_EX, MemRead_MEM, MemRead_WB,  
    //RegWrite_DEC, RegWrite_EX, RegWrite_WB,   
    Op, jump, branch,  
    stall_IDEX, stall_EXMEM, stall_MEMWB, //outputs
    IFID_Write, PCWrite, IF_Flush 
    );
    
    input MemRead_EX, MemRead_MEM, MemRead_WB; 
    //RegWrite_DEC, RegWrite_EX, RegWrite_WB;
    input [4:0] RegDst_EX, RegDst_MEM, RegDst_WB, Rs_DEC, Rt_DEC;
    
    
    input [5:0] Op;
    input  jump, branch;
    output reg stall_IDEX, stall_EXMEM, stall_MEMWB; // 1 to stall/insert zeros
    output reg IFID_Write, PCWrite, IF_Flush; // 1 means to do the action implied 
    initial begin
        PCWrite <= 1; IFID_Write <= 1; PCWrite <= 1; IF_Flush <= 0;
        stall_IDEX <=0; stall_EXMEM <= 0; stall_MEMWB <= 0;
    end 
    
   always @(*) begin
        if (jump == 1 && MemRead_EX == 1 &&  RegDst_EX == Rt_DEC) begin
            stall_IDEX = 1;
            stall_EXMEM = 0;
            stall_MEMWB = 0;
            IFID_Write = 0; PCWrite = 0; IF_Flush = 0;
        end
        
        else if (jump == 1 && MemRead_MEM == 1 &&  RegDst_MEM == Rt_DEC) begin 
            stall_IDEX = 1; // DO WE ZERO THIS OUT?
            stall_EXMEM = 1;
            stall_MEMWB = 0;
            IFID_Write = 0; PCWrite = 0; IF_Flush = 0;
        end
        
        else if (jump == 1 && MemRead_WB == 1 &&  RegDst_WB == (Rt_DEC || Rs_DEC)) begin 
            stall_IDEX = 1; // DO WE ZERO THIS OUT?
            stall_EXMEM = 1; // DO WE ZERO THIS OUT?
            stall_MEMWB = 1; 
            IFID_Write = 0; PCWrite = 0; IF_Flush = 0;
        end
    end //always
endmodule
