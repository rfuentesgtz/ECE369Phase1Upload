`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 1
// Module - pc_register.v
// Description - 32-Bit program counter (PC) register.
//
// INPUTS:-
// Address: 32-Bit address input port.
// Reset: 1-Bit input control signal.
// Clk: 1-Bit input clock signal.
//
// OUTPUTS:-
// PCResult: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design a program counter register that holds the current address of the 
// instruction memory.  This module should be updated at the positive edge of 
// the clock. The contents of a register default to unknown values or 'X' upon 
// instantiation in your module. Hence, please add a synchronous 'Reset' 
// signal to your PC register to enable global reset of your datapath to point 
// to the first instruction in your instruction memory (i.e., the first address 
// location, 0x00000000H).
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter(Address, PCResult, Reset, Clk, PCWrite);

	input [31:0] Address;
	input Reset, Clk, PCWrite;
    output reg [31:0] PCResult;
    
	initial begin
	   PCResult <= 0;
	end

    //remember to use NONblocking statements, since this is SEQUENTIAL LOGIC
    //SEQUENTIAL b/c a state is stored and updated according to a clock!!!
    //update only at posedge 
   
    
    always @(posedge Clk, posedge Reset)begin
        if (Reset == 1)begin  
            PCResult <= 32'd0;
        end
        else if (PCWrite == 1) begin //only update if PCwrite 
            PCResult <= Address;
        end         
        
    end
  
endmodule
