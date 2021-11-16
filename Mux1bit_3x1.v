`timescale 1ns / 1ps

module Mux1bit_3x1(signal, A, B, C, Out);
    input A, B, C;
    input [1:0] signal;
    output reg Out;
    
    always @(*)
    begin
        case(signal)
            2'd0: begin Out <= A; end
            2'd1: begin Out <= B; end
            2'd2: begin Out <= C; end
            default: begin Out <= 5'b0; end //error 
        endcase
    end
endmodule
