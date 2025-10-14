module D_latch (Clk, D, Qa, Qb);
	input Clk, D;
	output Qa, Qb;
	wire R_g, S_g;
	assign R_g = ~(~D & Clk);
	assign S_g = ~(D & Clk);
	assign Qa = ~(S_g & Qb);
	assign Qb = ~(R_g & Qa);
endmodule

