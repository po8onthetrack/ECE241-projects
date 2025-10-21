module part1(SW, KEY, HEX1, HEX0);
    input [1:0] SW;
    input [0:0] KEY;
    output [6:0] HEX1, HEX0;

    wire Clk = KEY[0];
    wire Clear = SW[0];
    wire Enable = SW[1];

    wire [7:0] Q;        // Flip-flop outputs
    wire [7:0] T;        // T inputs for flip-flops
	 
   assign T[0] = Enable;
	assign T[1] = Enable & Q[0];
	assign T[2] = Enable & Q[1] & Q[0];
	assign T[3] = Enable & Q[2] & Q[1] & Q[0];
	assign T[4] = Enable & Q[3] & Q[2] & Q[1] & Q[0];
	assign T[5] = Enable & Q[4] & Q[3] & Q[2] & Q[1] & Q[0];
	assign T[6] = Enable & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0];
	assign T[7] = Enable & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0];


    mTFF tff7(Clk, Clear, T[7], Q[7]);
    mTFF tff6(Clk, Clear, T[6], Q[6]);
    mTFF tff5(Clk, Clear, T[5], Q[5]);
    mTFF tff4(Clk, Clear, T[4], Q[4]);
    mTFF tff3(Clk, Clear, T[3], Q[3]);
    mTFF tff2(Clk, Clear, T[2], Q[2]);
    mTFF tff1(Clk, Clear, T[1], Q[1]);
    mTFF tff0(Clk, Clear, T[0], Q[0]);
    hex_decoder h0(Q[3:0], HEX0);
    hex_decoder h1(Q[7:4], HEX1);
endmodule




module mTFF(Clk, Clear, T, Q);
	input Clk, Clear, T;
	output reg Q;
	always @(posedge Clk)
	 begin
		if(Clear == 1'b0)
			Q <= 1'b0;
		else if(T == 1'b1)
			Q <= ~Q;
		end
endmodule
