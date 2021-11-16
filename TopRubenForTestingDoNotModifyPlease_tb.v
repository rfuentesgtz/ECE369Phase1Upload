module TopRubenForTestingDoNotModifyPlease_tb();
    reg Clk, Rst;
    wire[6:0] out7;
    wire[7:0] en_out;
    
    TopRubenForTestingDoNotModifyPlease RubenTest(Clk, Rst, out7, en_out);
    
    initial begin
    Clk <= 0;
    Rst <= 1;
    @(posedge Clk);
    #50 Rst <= 0;
    end
    
    always begin
        Clk <= 0;
        #200;
        Clk <= 1;
        #200;
    end
endmodule
