module part2 (SW,KEY, HEX3, HEX2, HEX1, HEX0);
	input [1:0] SW;
	input [0:0] KEY;
	output [6:0] HEX3, HEX2, HEX1, HEX0; 
	wire Clk = KEY[0];
   wire Clear = SW[0];
   wire Enable = SW[1];
	reg [15:0] Q;
	always @(posedge Clk, negedge Clear)
		begin
			if(Clear == 1'b0)
			 Q <= 1'b0;
			else if(Enable == 1'b1)
			Q <= Q + 16'b0000000000000001;
		end
	hex_decoder h0(Q[3:0], HEX0);
	hex_decoder h1(Q[7:4], HEX1);
	hex_decoder h2(Q[11:8], HEX2);
	hex_decoder h3(Q[15:12], HEX3);
endmodule

	
	
		
	
	