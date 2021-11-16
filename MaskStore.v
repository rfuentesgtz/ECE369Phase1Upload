`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2021 02:31:02 PM
// Design Name: 
// Module Name: MaskStore
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MaskStore(MemAdr, MemData, RegData , Bytes2Store, out);
    input [1:0] MemAdr;
    input [31:0] MemData, RegData;
    input [1:0] Bytes2Store;
    output reg [31:0] out;
    wire [31:0] Out_sh, Out_sb;
    StoreByte sb(MemAdr, MemData, RegData, Out_sb);
    StoreHalf sh(MemAdr[1], MemData, RegData, Out_sh);
    always @(*)  begin
        case (Bytes2Store) 
            2'd2: begin out = Out_sh;end
            2'd1: begin out = Out_sb;end
            default: begin out = RegData; end
        endcase
    end
    
endmodule