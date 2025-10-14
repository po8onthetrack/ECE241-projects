module part3(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	assign LEDR[9:2] = 8'b0;
	wire [1:0]s,u,v,w,display;
	assign u = SW[5:4];
	assign v = SW[3:2];
	assign w = SW[1:0];
	assign s = SW[9:8];
	assign LEDR[1:0] = display;
	//function: (((∼s0 & u )| (s0 & v)) & ~s1 )|(s1 & w)
	assign display[0] = (((~s[0] & u[0]) | (s[0] & v[0])) & ~s[1]) | (s[1] & w[0]);
	assign display[1] = (((~s[0] & u[1]) | (s[0] & v[1])) & ~s[1]) | (s[1] & w[1]);
endmodule
