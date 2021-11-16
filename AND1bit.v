`timescale 1ns / 1ps

module AND1bit(A, B, Out);
    input A, B;
    output reg Out;

    always @(*)
    begin
        if(A == 0 && B == 0)
            Out <= 0;
        else if(A == 0 && B == 1)
            Out <= 0;
        else if(A == 1 && B == 0)
            Out <= 0;
        else if(A == 1 && B == 1)
            Out <= 1;
        else
            Out <= 0; //error
    end
endmodule

