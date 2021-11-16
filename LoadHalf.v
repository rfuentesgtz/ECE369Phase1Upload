`timescale 1ns / 1ps

module LoadHalf(MemAdr, MemData, Out_lh);
    input [31:0]MemData;
    input MemAdr; //this will tell us whether to store to LS or MS halfword of memory
    output reg [31:0] Out_lh;
    
    always @ (*) begin
       case (MemAdr)
           1'b0: begin //write MemData[15:0] to register
               Out_lh = {{16{MemData[15]}}, MemData[15:0]}; end
           1'b1: begin //write MemData[31:16] to register
               Out_lh = { {16{MemData[31]}}, MemData[31:16]}; end
        endcase
    end
endmodule