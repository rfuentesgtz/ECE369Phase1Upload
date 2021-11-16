`timescale 1ns / 1ps

module Mux1bit_2x1(signal, A, B, Out);
    input A, B, signal;
    output reg Out;
    
    always @(*)
    begin
        case(signal)
            1'd0: begin Out <= A; end
            1'd1: begin Out <= B; end
            default: begin Out <= 1'b0; end //error 
        endcase
    end
endmodule
