module part4(D, Clk, Qa, Qb, Qc);
	input D, Clk;
	output Qa, Qb, Qc;
	wire Qa0, Qb0, Qc0;
	D_latch d1(Clk, D, Qa, Qa0);
	pos_flipflop FF1(Clk, D, Qb, Qb0);
	negative_flipflop FF2(Clk, D, Qc, Qc0);
endmodule




	
	

