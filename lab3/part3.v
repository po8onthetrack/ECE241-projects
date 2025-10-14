module part3(SW, LEDR);
	 input [1:0] SW;
	 output [9:0] LEDR;
	 wire D, Clk, Qs, Qn;
	 assign Clk = SW[0] ;
	 assign D = SW[1];
	 pos_flipflop p3(Clk, D, Qs, Qn);
	 assign LEDR[0] = Qs;
endmodule

