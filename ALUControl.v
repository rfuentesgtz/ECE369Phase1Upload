`timescale 1ns / 1ps

module ALUControl(Opcode, funct, I21,I6, I16, ALUOp, I9);
    input [5:0] Opcode;
    input [5:0] funct; 
    input I21, I6, I16, I9;                                     
    output reg [4:0] ALUOp;
    always @(*) begin
    //first check for the special cases
    if (Opcode == 6'd28)begin //MADD and MSUB are r-type, but their opcode isn't zero
        case (funct) 
            5'd0: ALUOp <= 30; //MADD
            5'd2: ALUOp <= 31; //mul
            5'd4: ALUOp <= 29; //MSUB
        endcase
     end
        
     else if (Opcode == 6'b0) begin //it's a rotate or shift
        if (funct == 6'd6) begin
             case (I6)
                1'b0: ALUOp <= 5'd5; //srlv
                1'b1: ALUOp <= 5'd9; //rotrv
             endcase
          end
         else if (funct == 6'd2)begin
            case (I21) 
                1'b0:   ALUOp <= 5'd5; //srl 
                1'b1:   ALUOp <= 5'd9; //rotr
            endcase
         end
             //END SPECIAL CASES where OP <= 0 
             else begin
            case(funct)
                6'd36: ALUOp <= 5'd0;
                6'd37: ALUOp <= 5'd1 ; //or 
                6'd39: ALUOp <= 5'd7 ; //nor 
                6'd38: ALUOp <= 5'd3; //xor 
                6'd0: ALUOp <= 5'd4; //sll 
                6'd2: ALUOp <= 5'd5; //srl 
                6'd4: ALUOp <= 5'd4; //sllv 
                 
                6'd42: ALUOp <= 5'd12 ; //slt 
                6'd43: ALUOp <= 5'd15; //sltu 
                6'd3: ALUOp <= 5'd10 ; //sra 
                6'd7: ALUOp <= 5'd10; //srav 
                6'd32: ALUOp <= 5'd2; //add 
                6'd33: ALUOp <= 5'd2; //addu 
                6'd34: ALUOp <= 5'd6; //sub 
                6'd11: ALUOp <= 5'd16 ; //movn 
                6'd17: ALUOp <= 5'd2; //mthi 
                6'd19: ALUOp <= 5'd2; //mtlo 
                6'd16: ALUOp <= 5'd28 ; //mfhi 
                6'd18: ALUOp <= 5'd27; //mflo 
                6'd10: ALUOp <= 5'd16 ; //movz 
                6'd24: ALUOp <= 5'd31; //multu 
                6'd25: ALUOp <= 5'd26; //multu 
                //6'd8: ALUOp <= 5'dX; //jr  
            endcase
        end //END  CASES WHERE OP <=<= 0 
     end  //END ALL R-TYPE CASES
         
     //BEGIN ALL I-TYPE CASES
     //check special cases first: BGEZ, BLTZ
     else if (Opcode == 6'd1) begin //it's either BGEZ or BLTZ
        case(I16)
            1'b0:  ALUOp <= 5'd12; //BLTZ
            1'b1:  ALUOp <= 5'd18; //BGEZ
        endcase
     end // end special case
     
     //SEB and SEH
     else if (Opcode == 6'b011111) begin
        case(I9)
        1'b0:  ALUOp <= 5'd19; //BLTZ
        1'b1:  ALUOp <= 5'd20; //BGEZ
        default: ALUOp <= 0;
        
        endcase
     end
     
     //BEGIN STANDARD ITYPE CASES 
     else begin
         case (Opcode) 
             //FIXME:seh, seb
             //6'd31:  ALUOp <= ???
             //6'd31:  ALUOp <= ???
             
            //J-TYPE INSTRUCTIONS
             6'd2: ALUOp <= 5'd2; // add corresponds to jump
             6'd3: ALUOp <= 5'd2; // add corresponds to jal
            
            // I-TYPE INSTRUCTIONS
            6'd12: ALUOp <= 5'd0 ; //andi 
            6'd13: ALUOp <= 5'd1 ; //ori 
            6'd14: ALUOp <= 5'd3 ; //xori 
            6'd10: ALUOp <= 5'd12 ; //slti 
            6'd11: ALUOp <= 5'd15 ; //sltiu 
            6'd15: ALUOp <= 5'd17 ; //lui 
            6'd43: ALUOp <= 5'd2 ; //sw 
            6'd41: ALUOp <= 5'd2 ; //sh 
            6'd40: ALUOp <= 5'd2 ; //sb 
            6'd35: ALUOp <= 5'd2 ; //lw 
            6'd33: ALUOp <= 5'd2 ; //lh 
            6'd32: ALUOp <= 5'd2 ; //lb 
            6'd1: ALUOp <= 5'd18 ; //bgez 
            6'd7: ALUOp <= 5'd11 ; //bgtz 
            6'd4: ALUOp <= 5'd6 ; //beq 
            6'd5: ALUOp <= 5'd6 ; //bne 
            6'd6: ALUOp <= 5'd11 ; //blez 
            6'd1: ALUOp <= 5'd12 ; //bltz 
            6'd9: ALUOp <= 5'd2 ; //addiu 
            6'd8: ALUOp <= 5'd2 ; //addi 
         endcase
    end  //END ALL J-TYPE AND I-TYPE INSTRUCTIONS
end //always
endmodule