module pos_flipflop(Clk, D, Qs, Qn);
	input Clk, D;
	output Qs, Qn;
	wire Qm, Q0;
	D_latch master(~Clk, D, Qm, Q0);
	D_latch slave(Clk, Qm, Qs, Qn);
endmodule
