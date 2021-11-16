`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Rahel Gerson

//////////////////////////////////////////////////////////////////////////////////


module StoreByte(MemAdr, MemData, RegData, Out_sb);
    input [31:0] MemData, RegData;
    input [1:0]  MemAdr; 
    //MemAdr represents the 2 least significant bits of the computed address, offset + base
    //MemAdr's value corresponds to the byte (1,2,3, or 4) in memory word 
    //which will be replaced with the LS  byte of RegData, RegData[7:0]
 
    output reg [31:0] Out_sb;
    
     always @ (*) begin
        case (MemAdr)
            2'd0: begin //write to MS byte of memory word
                Out_sb = {MemData[31:8],  RegData[7:0]}; end
            2'd1: begin
                Out_sb = {MemData[31:16], RegData[7:0], MemData[7:0]}; end
            2'd2: begin
                 Out_sb = {MemData[31:24], RegData[7:0], MemData[15:0]};end
            2'd3: begin//write to MS byte of memory  word
                Out_sb = {RegData[7:0], MemData[23:0]};end
         endcase
        
     end
endmodule
