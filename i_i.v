`timescale 1ns / 1ps

//naming conventions
//Instr_p is the producer EX, Instr_c is the consumer  
module i_i(
    RegDst_EX, RegDst_MEM, RegDst_WB, 
    Rs_DEC, Rt_DEC,
    RegWrite_EX, RegWrite_MEM, RegWrite_WB,
    stall_IDEX, stall_EXMEM, stall_MEMWB, //outputs
    IFID_write, PC_write, IF_flush);
    
    input [4:0] RegDst_EX, RegDst_MEM, RegDst_WB, Rs_DEC, Rt_DEC;
    input  RegWrite_EX, RegWrite_MEM, RegWrite_WB;
    output reg stall_IDEX, stall_EXMEM, stall_MEMWB,  IFID_write, PC_write, IF_flush;
    
    initial begin
        PC_write <= 1; IFID_write <= 1; IF_flush <= 0;
        stall_IDEX <=0; stall_EXMEM <= 0; stall_MEMWB <= 0;
    end
    //stall = 0 means do not stall
    always @ (*) begin
        //Instr_p is in EX, Instr_c is in DEC 
        if (((RegDst_EX == Rs_DEC ) || (RegDst_EX == Rt_DEC)) && RegWrite_EX == 1 && RegDst_EX != 0) begin 
            PC_write <= 0; IFID_write <= 0; IF_flush <= 0;
            stall_IDEX <=1;
        end 
        //Instr_p is in MEM, Instr_c is in DEC 
        else if (((RegDst_MEM == Rs_DEC ) || (RegDst_MEM == Rt_DEC)) && RegWrite_MEM == 1 && RegDst_MEM != 0) begin 
            PC_write <= 0; IFID_write <= 0; IF_flush <= 0;
            stall_IDEX <=1;
        end 
        //Instr_p is in WB, Instr_c is in DEC 
        else if (((RegDst_WB == Rs_DEC ) || (RegDst_WB == Rt_DEC)) && RegWrite_WB == 1 && RegDst_WB != 0) begin 
            PC_write <= 0; IFID_write <= 0; IF_flush <= 0;
            stall_IDEX <=1;
        end
        //no dependency 
        else begin 
            PC_write <= 1; IFID_write <= 1; IF_flush <= 0;
            stall_IDEX <=0;
        end
    end 
endmodule
