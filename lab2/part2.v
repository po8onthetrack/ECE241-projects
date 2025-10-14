module part2 (SW, HEX1, HEX0);
	input [3:0] SW;
	output [6:0] HEX1, HEX0;
	wire v3, v2, v1, v0, a3,a2,a1,a0,z;
	wire [3:0] d1;
	assign v3 = SW[3];
	assign v2 = SW[2];
	assign v1 = SW[1];
	assign v0 = SW[0];
	//comparator;
	assign z = (v3 & v2) | (v1 & v3);
	// circuit A
	assign a3 = 1'b0;
	assign a2 = v2 & v1;
	assign a1 = v3 & ~v1;
	assign a0 = v0 & v3;
	// HEX1
	assign d1 = (z) ? 4'b0001 : 4'b0000;
	hex_decoder Hex1 (d1, HEX1);
	//HEX0
	wire [3:0] d0;
	assign d0[3] = (~z & v3) | (z & a3);
	assign d0[2] = (~z & v2) | (z & a2);
	assign d0[1] = (~z & v1) | (z & a1);
	assign d0[0] = (~z & v0) | (z & a0);
	hex_decoder Hex0 (d0, HEX0);
endmodule
	

	
	
	
	
	