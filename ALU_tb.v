`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 

	reg [3:0] ALUControl;   // control bits for ALU operation
	reg [31:0] A, B;	        // inputs

	wire [31:0] ALUResult;	// answer
	wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
        .ALUControl(ALUControl), 
        .A(A), 
        .B(B), 
        .ALUResult(ALUResult), 
        .Zero(Zero)
    );

	initial begin
	//Setting up two numbers
	A <= 716;
	B <= 26;
	
	//Test0: AND
	ALUControl <= 0;
	#20;
	
	//Test1: OR
	ALUControl <= 1;
	#20;
	
	//Test2: ADD
	ALUControl <= 2;
	#20;
	
	//Test3: XOR
	ALUControl <= 3;
	#20;
	
	//Test4: SLL
	ALUControl <= 4;
	#20;
	
	//Test5: SRL
	ALUControl <= 5;
	#20;
	
	//Test6: SUBTRACT
	ALUControl <= 6;
	#20;
	
	//Test7: SLT
	ALUControl <= 7;
	#20;
	A <= 15;
	#20
	
	//Test8: ROTATE LEFT
	ALUControl <= 8;
	#20;
	A <= 32'b11011101011010101101010110011010;
	#20;
	
	//Test9: ROTATE RIGHT
	ALUControl <= 9;
	#20;
	
	//Test12: NOR
	A <= 19;
	ALUControl <= 12;
	#20;
	
	//Test14: ERROR
	ALUControl <= 14;
	#20;
	
	//Test15: MULTIPLY
	ALUControl <= 15;
    
	
	end

endmodule