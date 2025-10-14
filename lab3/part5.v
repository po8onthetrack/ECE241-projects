module part5(SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);	
	input [7:0] SW;
	input [1:0] KEY;
	output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	output [9:0] LEDR;
	wire [7:0] A, B, S;
	wire Co;
	storeA regA(KEY[1], KEY[0], SW, A);
	assign B = SW;
	assign LEDR[0] = Co;
	carryadder_8bit sumAB(A,B,Co,S);
	hex_decoder A1(A[3:0], HEX2);
	hex_decoder A2(A[7:4], HEX3);
	hex_decoder B1(B[3:0], HEX0);
	hex_decoder B2(B[7:4], HEX1);
	hex_decoder S1(S[3:0], HEX4);
	hex_decoder S2(S[7:4], HEX5);
endmodule


module hex_decoder(S, HEX); 
	input [3:0] S; 
	output reg [6:0] HEX;
    always @(S)
	 begin
        case(S)
            4'h0: HEX = 7'b1000000;
            4'h1: HEX = 7'b1111001;
            4'h2: HEX = 7'b0100100;
            4'h3: HEX = 7'b0110000;
            4'h4: HEX = 7'b0011001;
            4'h5: HEX = 7'b0010010;
            4'h6: HEX = 7'b0000010;
            4'h7: HEX = 7'b1111000;
            4'h8: HEX = 7'b0000000;
            4'h9: HEX = 7'b0010000;
            4'hA: HEX = 7'b0001000; // A
            4'hB: HEX = 7'b0000011; // b
            4'hC: HEX = 7'b1000110; // C
            4'hD: HEX = 7'b0100001; // d
            4'hE: HEX = 7'b0000110; // E
            4'hF: HEX = 7'b0001110; // F
        endcase
    end
endmodule

module carryadder_8bit(A, B, Co, S);
	 input [7:0] A, B;
	 output [7:0] S;
	 output Co;
	 wire [6:0] carry;
    full_adder FA0(A[0], B[0], 1'b0, carry[0], S[0]);
    full_adder FA1(A[1], B[1], carry[0], carry[1], S[1]);
    full_adder FA2(A[2], B[2], carry[1], carry[2], S[2]);
    full_adder FA3(A[3], B[3], carry[2], carry[3], S[3]);
    full_adder FA4(A[4], B[4], carry[3], carry[4], S[4]);
    full_adder FA5(A[5], B[5], carry[4], carry[5], S[5]);
    full_adder FA6(A[6], B[6], carry[5], carry[6], S[6]);
    full_adder FA7(A[7], B[7], carry[6], Co, S[7]);
endmodule


module storeA(Clk,Reset, D, Q);
	input [7:0] D;
	input Clk, Reset;
	output reg [7:0] Q;
	always@(posedge Clk or negedge Reset)
	begin
		if(!Reset)
			Q <= 8'b0;
		else
			Q <= D;
	end
endmodule

 
 