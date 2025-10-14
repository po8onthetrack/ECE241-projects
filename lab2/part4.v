module part4(SW, LEDR, HEX0, HEX1, HEX3, HEX5);
	input [8:0] SW;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX3, HEX5;
	wire [3:0] X, Y;
	wire Cin, C1, C2, C3, Cout, S0, S1, S2, S3;
	assign X = SW[3:0];
	assign Y = SW[7:4];
	assign Cin = SW[8];
	//check if X or Y is greater than 9
	assign LEDR[9] = ((X[3] & X[2]) | (X[1] & X[3]))| ((Y[3] & Y[2]) | (Y[1] & Y[3]));
	hex_decoder hex5(.S(SW[3:0]), .HEX(HEX5));
	hex_decoder hex3(.S(SW[7:4]), .HEX(HEX3));
	//implement the 4 bit ripple-carry adder
	 full_adder FA0(.a(X[0]), .b(Y[0]), .ci(Cin), .co(C1), .s(S0));
	 full_adder FA1(.a(X[1]), .b(Y[1]), .ci(C1), .co(C2), .s(S1));
	 full_adder FA2(.a(X[2]), .b(Y[2]), .ci(C2), .co(C3), .s(S2));
	 full_adder FA3(.a(X[3]), .b(Y[3]), .ci(C3), .co(Cout), .s(S3));
	//code from part2
	wire a3,a2,a1,a0,D3,D2,D1,D0,z;
	wire [6:0] d1;
	//comparator;
	assign z = (S3 & S2) | (S1 & S3);
	// circuit A
	assign a3 = 1'b0;
	assign a2 = S2 & S1;
	assign a1 = S3 & ~S1;
	assign a0 = S0 & S3;
	//circuit D when carryout is 1
	assign D3 = S1;
	assign D2 = ~S1;
	assign D1 = ~S1;
	assign D0 = S0;
	// HEX1
	assign d1 = (Cout | z) ? 7'b0000110 : 7'b0111111;
	assign HEX1 = ~d1;
	//HEX0
	wire [3:0] d0;
	assign d0[3] = Cout ? D3  : ((~z & S3) | (z & a3));
	assign d0[2] = Cout ? D2  : ((~z & S2) | (z & a2));
	assign d0[1] = Cout ? D1  : ((~z & S1) | (z & a1));
	assign d0[0] = Cout ? D0  : ((~z & S0) | (z & a0));
	hex_decoder Hex0 (.S(d0), .HEX(HEX0) );
endmodule

	