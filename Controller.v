`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: begin 
// Engineer: begin 
// 
// Create Date: begin 10/24/2021 02: begin35: begin27 PM
// Design Name: begin 
// Module Name: begin Controller
// Project Name: begin 
// Target Devices: begin 
// Tool Versions: begin 
// Description: begin 
// 
// Dependencies: begin 
// 
// Revision: begin
// Revision 0.01 - File Created
// Additional Comments: begin
// 
//////////////////////////////////////////////////////////////////////////////////


module Controller(opcode, funct, i16,
RegDst,	link, jrSrc, 
jump, branch, MemRead, 
MemtoReg, MemWrite, ALUsrc1, 
ALUsrc2, RegWrite,	
HiWrite, LoWrite, HiSrc,
LoSrc,	ZeroSrc, Move,	
MoveSrc, bytes2load, bytes2store,
i9,
ComparatorInputSelect, ComparatorOutputSelect, //Added for phase 1
ZeroExtend //To choose between ZeroExtend and Signextend
);
    //Inputs
    input [5:0] opcode, funct;
    input i16;
    input i9;
    output reg link, jrSrc, 
    jump, branch, MemRead, 
    MemtoReg, MemWrite, ALUsrc1, 
    ALUsrc2, RegWrite,	
    HiWrite, LoWrite, HiSrc,
    LoSrc,	ZeroSrc, Move,	
    MoveSrc;
    output reg [1:0] RegDst, bytes2load, bytes2store;
    //Phase 1
    output reg ComparatorInputSelect;
    output reg [1:0] ComparatorOutputSelect;
    output reg ZeroExtend;
    
    always @(*)begin
    case (opcode)
        //R type instructions
        0: begin
        case (funct)
            
            6'd36: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd37: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd39: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd38: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd0: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b1; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd2: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b1; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd4: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd6: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd42: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd43: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd3: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b1; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd7: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd32: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd33: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd34: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd11: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b1;	
            MoveSrc<=1'b1; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd17: begin 
            RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b1; LoWrite <= 1'b0; HiSrc <= 1'b0;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd19: begin 
            RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b0; LoWrite <= 1'b1; HiSrc <= 1'bX;
            LoSrc <= 1'b0;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd16: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd18: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd10: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b1;	
            MoveSrc<=1'b0; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd24: begin 
            RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b1; LoWrite <= 1'b1; HiSrc <= 1'b1;
            LoSrc <= 1'b1;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd25: begin 
            RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b1; LoWrite <= 1'b1; HiSrc <= 1'b1;
            LoSrc <= 1'b1;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd8: begin 
            RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b1; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd6: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
        
            6'd2: begin 
            RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b1; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bx;
            LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
            ZeroExtend <= 0;
            end
            
            default: begin
            RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'b0;
            LoSrc <= 1'b0;	ZeroSrc <= 1'b0; Move<= 1'b0;	
            MoveSrc<=1'b0; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'b0; ComparatorOutputSelect <= 1'b0;
            ZeroExtend <= 0;
            end
  
        endcase
        end
        
        //Most of I and J type instructions
        6'd12: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 1;
        end
        
        6'd13: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd14: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd10: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd11: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd15: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd43: begin 
        RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'bX; MemWrite<= 1'b1; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b0;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd41: begin 
        RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'bx; MemWrite<= 1'b1; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b0;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd2;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd40: begin 
        RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'bx; MemWrite<= 1'b1; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b0;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd1;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd35: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b1; 
        MemtoReg<= 1'b1; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd33: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b1; 
        MemtoReg<= 1'b1; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd2; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd32: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b1; 
        MemtoReg<= 1'b1; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd1; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd1: begin
            if(i16 == 1)begin
            RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b1; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'b1; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 0; ComparatorOutputSelect <= 0;
            ZeroExtend <= 0;
            end 
            else begin
            RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b1; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
            LoSrc <= 1'bX;	ZeroSrc <= 1'b0; Move<= 1'b0;	
            MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 0; ComparatorOutputSelect <= 0;
            ZeroExtend <= 0;
            end
        end
        
        6'd7: begin 
        RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b1; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'b0; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 0; ComparatorOutputSelect <= 2'd2;
        ZeroExtend <= 0;
        end
        
        6'd4: begin 
        RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b1; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'b0; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1; ComparatorOutputSelect <= 2'd1;
        ZeroExtend <= 0;
        end
        
        6'd5: begin 
        RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b1; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'b1; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1; ComparatorOutputSelect <= 2'd1;
        ZeroExtend <= 0;
        end
        
        6'd6: begin 
        RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b1; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'b1; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 0; ComparatorOutputSelect <= 2'd2;
        ZeroExtend <= 0;
        end
        
        6'd9: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd2: begin 
        RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b1; branch <= 1'b0; MemRead <=1'bX; 
        MemtoReg<= 1'bX; MemWrite<= 1'b0; ALUsrc1 <= 1'bX; 
        ALUsrc2 <= 1'bX; RegWrite <=1'b0;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bx; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd3: begin 
        RegDst <= 2'd2;	link <= 1'd1; jrSrc <= 1'b0; 
        jump <= 1'b1; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd8: begin 
        RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
        jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
        MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
        ALUsrc2 <= 1'b1; RegWrite <=1'b1;	
        HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
        LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
        MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
        ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
        ZeroExtend <= 0;
        end
        
        6'd28: begin
            case(funct)
                6'd2: begin 
                RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
                jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
                MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
                ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
                HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
                LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
                MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
                ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
                ZeroExtend <= 0;
                end
            
                6'd0: begin 
                RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
                jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
                MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
                ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
                HiWrite <= 1'b1; LoWrite <= 1'b1; HiSrc <= 1'b1;
                LoSrc <= 1'b1;	ZeroSrc <= 1'bX; Move<= 1'b0;	
                MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
                ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
                ZeroExtend <= 0;
                end
            
                6'd4: begin 
                RegDst <= 2'dX;	link <= 1'd0; jrSrc <= 1'b0; 
                jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
                MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
                ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
                HiWrite <= 1'b1; LoWrite <= 1'b1; HiSrc <= 1'b1;
                LoSrc <= 1'b1;	ZeroSrc <= 1'bX; Move<= 1'b0;	
                MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
                ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
                ZeroExtend <= 0;
            end
            
            default: begin
            RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'b0;
            LoSrc <= 1'b0;	ZeroSrc <= 1'b0; Move<= 1'b0;	
            MoveSrc<=1'b0; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'b0; ComparatorOutputSelect <= 1'b0;
            ZeroExtend <= 0;
            end
            
            endcase
        
        
        end
        
        //SEH and SEB
        6'b011111: begin
            case(i9)
                1'b1: begin 
                RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
                jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
                MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
                ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
                HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
                LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
                MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
                ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
                ZeroExtend <= 0;
                end
            
                1'b0: begin 
                RegDst <= 2'd1;	link <= 1'd0; jrSrc <= 1'b0; 
                jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
                MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
                ALUsrc2 <= 1'b0; RegWrite <=1'b1;	
                HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'bX;
                LoSrc <= 1'bX;	ZeroSrc <= 1'bX; Move<= 1'b0;	
                MoveSrc<=1'bX; bytes2load <= 2'd0; bytes2store<= 2'd0;
                ComparatorInputSelect <= 1'bX; ComparatorOutputSelect <= 1'bX;
                ZeroExtend <= 0;
                end
            
                default: begin
                RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
                jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
                MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
                ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
                HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'b0;
                LoSrc <= 1'b0;	ZeroSrc <= 1'b0; Move<= 1'b0;	
                MoveSrc<=1'b0; bytes2load <= 2'd0; bytes2store<= 2'd0;
                ComparatorInputSelect <= 1'b0; ComparatorOutputSelect <= 1'b0;
                ZeroExtend <= 0;
                end
            
            endcase
        
        
        end
        
        default: begin
            RegDst <= 2'd0;	link <= 1'd0; jrSrc <= 1'b0; 
            jump <= 1'b0; branch <= 1'b0; MemRead <=1'b0; 
            MemtoReg<= 1'b0; MemWrite<= 1'b0; ALUsrc1 <= 1'b0; 
            ALUsrc2 <= 1'b0; RegWrite <=1'b0;	
            HiWrite <= 1'b0; LoWrite <= 1'b0; HiSrc <= 1'b0;
            LoSrc <= 1'b0;	ZeroSrc <= 1'b0; Move<= 1'b0;	
            MoveSrc<=1'b0; bytes2load <= 2'd0; bytes2store<= 2'd0;
            ComparatorInputSelect <= 1'b0; ComparatorOutputSelect <= 1'b0;
            ZeroExtend <= 0;
        end
        
    endcase 
    
    end
    
endmodule
