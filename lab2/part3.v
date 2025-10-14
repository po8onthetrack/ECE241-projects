module part3(SW, LEDR);
	 input [8:0] SW;
	 output [4:0] LEDR;
	 wire a0, a1, a2, a3, b0, b1, b2, b3, cin, c1, c2, c3, s0, s1, s2, s3, cout;
	 
	 assign a0 = SW[0];
	 assign a1 = SW[1];
	 assign a2 = SW[2];
	 assign a3 = SW[3];
	 assign b0 = SW[4];
	 assign b1 = SW[5];
	 assign b2 = SW[6];
	 assign b3 = SW[7];
	 assign cin = SW[8];
	 assign LEDR[0] = s0;
	 assign LEDR[1] = s1;
	 assign LEDR[2] = s2;
	 assign LEDR[3] = s3;
	 assign LEDR[4] = cout;
	 full_adder FA0(.a(a0), .b(b0), .ci(cin), .co(c1), .s(s0));
	 full_adder FA1(.a(a1), .b(b1), .ci(c1), .co(c2), .s(s1));
	 full_adder FA2(.a(a2), .b(b2), .ci(c2), .co(c3), .s(s2));
	 full_adder FA3(.a(a3), .b(b3), .ci(c3), .co(cout), .s(s3));
endmodule

module full_adder(a, b, ci, co, s);
	input a, b, ci;
	output co, s;
	assign co = (ci & a) | (ci & b) | (a & b);
	assign s = ci ^ a ^ b;
endmodule
