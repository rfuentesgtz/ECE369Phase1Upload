`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - RegisterFile.v
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

	reg [4:0] ReadRegister1_tb;
	reg [4:0] ReadRegister2_tb;
	reg	[4:0] WriteRegister_tb;
	reg [31:0] WriteData_tb;
	reg RegWrite_tb;
	reg Clk_tb;

	wire [31:0] ReadData1_tb;
	wire [31:0] ReadData2_tb;
	//integer i;


	RegisterFile u0(
		.ReadRegister1(ReadRegister1_tb), 
		.ReadRegister2(ReadRegister2_tb), 
		.WriteRegister(WriteRegister_tb), 
		.WriteData(WriteData_tb), 
		.RegWrite(RegWrite_tb), 
		.Clk(Clk_tb), 
		.ReadData1(ReadData1_tb), 
		.ReadData2(ReadData2_tb)
	);

    //Set clock frequency
	always begin
		Clk_tb <= 1'b0;
		#10;
		Clk_tb <= 1'b1;
		#10;
	end
	
	//Begin testing
	integer i;
	initial begin
	   //Initialize registers 8-26
	   RegWrite_tb <= 1;
	   @(posedge Clk_tb);
	   for(i = 8; i <27; i = i + 1) begin
	       WriteRegister_tb <= i;
	       WriteData_tb <= 5 * i + 2;
	       @(posedge Clk_tb);
	       #10;
	   end
	   RegWrite_tb <= 0;
	   @(posedge Clk_tb)
	   //Read registers
	   for(i = 8; i <26; i = i + 1) begin
	       //Ensure registers arent overwritten when RegWrite is 0
	       WriteRegister_tb <= i;
	       WriteData_tb <= 5 * i + 2;
	       ReadRegister1_tb <= i;
	       ReadRegister2_tb <= i + 1;
	       #10;
	   end
	   
	   
	end
	
	
	

endmodule