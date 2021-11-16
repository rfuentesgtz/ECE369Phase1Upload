`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, HiLo, ALUResult, Zero, ALU64Result);

	input [4:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    // inputs
	input [63:0] HiLo;      // Concatenated Hi and Lo registers used in MADD and 

	output reg [31:0] ALUResult;	// answer
	output Zero;	    // Zero=1 if ALUResult == 0
	integer i;
	output reg[63:0] ALU64Result;

    /* Please fill in the implementation here... */
    assign Zero = (ALUResult==0); //zero is true if ALUResult is zero
    always @(ALUControl, A, B) begin
        i <= B;
        case ($unsigned(ALUControl))
            0: ALUResult <= A & B; //and
            1: ALUResult <= A | B; //or
            2: ALUResult <= A + B; //add
            3: ALUResult <= A ^ B; //xor FIXME
            4: ALUResult <= B << A; //sll FIXME
            5: ALUResult <= B >> A; //srl FIXME
            6: ALUResult <= A - B; //subtract
            7: ALUResult <= ~(A | B); //nor
            8: ALUResult <= (B << A) | (B >> 32-A); //rotate left FIXME
            9: ALUResult <= (B >> A) | (B << 32-A); //rotate right FIXME
            10: ALUResult <= (B >>> A); //Shift right arithmetic
            11: ALUResult <= A > B ? 1 : 0; //sgt
            12: ALUResult <= A < B ? 1 : 0; //slt
            13: ALUResult <= B & 32'b00000000000000001111111111111111;
            14: ALUResult <= B & 32'b00000000000000000000000011111111;
            15: ALUResult <= $unsigned(A) < $unsigned(B) ? 1 : 0; //slt unsigned
            16: ALUResult <= A; //Move A elsewhere
            17: ALUResult <= B << 16; //Load upper immediate
            18: ALUResult <= A < 0 ? 1 : 0;
            19: ALUResult <= {{24{B[7]}},  B[7:0]}; // SEB
            20: ALUResult <= {{16{B[15]}},  B[15:0]}; // SEH
            //16: ALUResult <= -1; //error ?FIXME?
            26: ALU64Result <= $unsigned(A) * $unsigned(B); //Unsigned Mult MULTU
            27: ALUResult <= HiLo[31:0]; //Move from Lo
            28: ALUResult <= HiLo[63:32]; //Move from Hi
            29: begin //MSUB
                ALU64Result = A * B; //multiply
                ALU64Result = HiLo - ALU64Result; //Test because can mess up
                end
            30: begin //MADD
                ALU64Result = A * B; //multiply
                ALU64Result = HiLo + ALU64Result; //Test because can mess up
                end
            31: begin
                ALU64Result = $signed(A) * $signed(B); //multiply
                ALUResult = ALU64Result[31:0]; //multiply 
                end
            default: ALUResult <= 0;
        endcase
    end

endmodule
