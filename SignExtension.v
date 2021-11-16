`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////
module SignExtension(in, out, ZeroExtend);

    /* A 16-Bit input word */
    input [15:0] in;
    
    /* A 32-Bit output word */
    output [31:0] out;
    
    //A control signal to either zero extend or sign extend
    input ZeroExtend;
    
    /* Fill in the implementation here ... */
    reg[31:0] out;
    wire[15:0] in;
    
    always @(in)
    begin
        if(ZeroExtend == 0) begin
            out[31:0] <= { {16{in[15]}}, in[15:0]};
        end
        else out[31:0] <= { 16'b0, in[15:0]};
    end

endmodule