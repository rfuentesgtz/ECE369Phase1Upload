`timescale 1ns / 1ps

module Mux32bits_2x1(signal, A, B, Out);
    input signal;
    input [31:0] A, B;
    output reg [31:0] Out;
    
    always @(*)
    begin
        case(signal)
            1'd0: begin Out <= A; end
            1'd1: begin Out <= B; end
            default: begin Out <= 32'b0; end //error 
        endcase
    end
endmodule
