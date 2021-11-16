`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rahel Gerson

//////////////////////////////////////////////////////////////////////////////////


module StoreHalf(MemAdr, MemData, RegData, Out_sh);
    input [31:0]MemData, RegData;
    input MemAdr; //this will tell us whether to store to LS or MS halfword of memory
    output reg [31:0] Out_sh;
    
     always @ (*) begin
        case (MemAdr)
            1'b1: begin //write reg[15:0] to MS halfword
                Out_sh = { RegData[15:0], MemData[15:0]}; end
            1'b0: begin //write reg[15:0] to LS halfword
               Out_sh = { MemData[31:16], RegData[15:0]}; end
         endcase
//        temp1 <= MemMask & MemData;
//        temp2 <= RegData & RegMask;
//        Out <= temp2 | temp1;
        //$display("Out %32b" , Out); 
     end
endmodule
