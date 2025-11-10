module part1(SW, KEY, LEDR);
    input  [1:0] SW;  
    input  [0:0] KEY; 
    output [9:0] LEDR;

    wire Clk    = ~KEY[0];  
    wire Resetn = SW[0];    
    wire w      = SW[1];   

    wire [8:0] y;  
    wire [8:0] Y;

    assign Y[0] = ~Resetn;  

    assign Y[1] = Resetn & (~w) & (y[0] | y[5] | y[6] | y[7] | y[8]);
    assign Y[2] = Resetn & (~w) & y[1];                          
    assign Y[3] = Resetn & (~w) & y[2];                           
    assign Y[4] = Resetn & (~w) & (y[3] | y[4]);                  
    assign Y[5] = Resetn & w & (y[0] | y[1] | y[2] | y[3] | y[4]);    
    assign Y[6] = Resetn & w & y[5];                                 
    assign Y[7] = Resetn & w & y[6];                             
    assign Y[8] = Resetn & w & (y[7] | y[8]);                      

    mff f0(Clk, Y[0], y[0]);
    mff f1(Clk, Y[1], y[1]);
    mff f2(Clk, Y[2], y[2]);
    mff f3(Clk, Y[3], y[3]);
    mff f4(Clk, Y[4], y[4]);
    mff f5(Clk, Y[5], y[5]);
    mff f6(Clk, Y[6], y[6]);
    mff f7(Clk, Y[7], y[7]);
    mff f8(Clk, Y[8], y[8]);

    assign LEDR[8:0] = y;         
    assign LEDR[9] = y[4] | y[8]; 
endmodule

module mff(Clk, D, Q);

    input Clk; 
    input D;    
    output reg Q;

    always @(posedge Clk) begin
        Q <= D; 
    end
endmodule
