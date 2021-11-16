`timescale 1ns / 1ps

module LoadByte(MemAdr, MemData, Out_lb);
    input [31:0] MemData;
    input [1:0]  MemAdr; 
    //MemAdr represents the 2 least significant bits of the computed address, offset + base
    //MemAdr's value corresponds to the byte (1,2,3, or 4) in memory word 
    //which will be replaced with the LS  byte of RegData, RegData[7:0]
    output reg [31:0] Out_lb;
    
     always @ (*) begin
        case (MemAdr)
            2'd0: begin //far right
                Out_lb = {{24{MemData[7]}},  MemData[7:0]}; end
            2'd1: begin //middle right
                Out_lb = {{24{MemData[15]}}, MemData[15:8]}; end
            2'd2: begin //middle left
                Out_lb = {{24{MemData[23]}}, MemData[23:16]}; end
            2'd3: begin //far left
                Out_lb = {{24{MemData[31]}}, MemData[31:24]}; end
         endcase 
     end
endmodule