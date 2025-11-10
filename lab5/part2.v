module part2 (SW, KEY, LEDR);

	input [1:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
	
	wire Clock = KEY[0];
	wire Resetn = SW[0];
	wire w = SW[1];
	
	
	reg [3:0] y_Q, Y_D; // y_Q = current state, Y_D = next state
	
	reg z;
	
	parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100,
	F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000;
	
	always @(w, y_Q)
		begin: state_table
			case (y_Q)
			A: if (!w) Y_D = B;
				else Y_D = F;
				// 0 path
			B: if(!w) Y_D = C;
				else Y_D = F;
			C: if (~w) Y_D = D; 
				else Y_D = F;
			D: if (~w) Y_D = E; 
				else Y_D = F;
			E: if (~w) Y_D = E; 
				else Y_D = F;
				// 1 path
			F: if ( w) Y_D = G; 
				else Y_D = B;
			G: if ( w) Y_D = H; 
				else Y_D = B;
			H: if ( w) Y_D = I; 	
				else Y_D = B;
			I: if ( w) Y_D = I; 
				else Y_D = B; 
			default: Y_D = 4'bxxxx;
		endcase
	end 
	
	always @(posedge Clock , negedge Resetn)
	begin: state_FFs
		if(Resetn == 0)
			y_Q <= 4'b0;
		else
			y_Q <= Y_D;
	end // state_FFS
	
	always@(y_Q)
	 begin: out_put
		if( y_Q == E || y_Q == I)
			z = 1'b1;
		else
			z = 1'b0;
	end
	
	
	assign LEDR[9] = z;
	assign LEDR[3:0] = y_Q;
	
endmodule
