`timescale 1ns / 1ps

module MaskLoad(MemAdr, MemData, Bytes2Load, out);
    input [1:0] MemAdr;
    input [31:0] MemData;
    input [1:0] Bytes2Load;
    output reg [31:0] out;
    wire [31:0] Out_lh, Out_lb;
    LoadByte lb(MemAdr, MemData, Out_lb);
    LoadHalf lh(MemAdr[1], MemData, Out_lh);
    always @(*)  begin
        case (Bytes2Load) 
            2'd2: begin out = Out_lh; end //lh
            2'd1: begin out = Out_lb; end //lb
            default: begin out = MemData; end //lw
        endcase
    end
    
endmodule