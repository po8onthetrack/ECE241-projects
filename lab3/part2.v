module part2(SW, LEDR);
	input [1:0] SW;
	output [9:0] LEDR;
	wire Qb;
	D_latch D0(SW[1], SW[0], LEDR[0], Qb);
endmodule 	

