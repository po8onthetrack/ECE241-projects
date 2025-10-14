module part1(SW, LEDR, HEX1, HEX0);
    input [7:0] SW;
    output [7:0] LEDR;
    output [6:0] HEX1, HEX0;

    assign LEDR = SW;
	 
	 hex_decoder hex0( SW[3:0], HEX0 );
	 hex_decoder hex1( SW[7:4], HEX1 );
endmodule

   
	 
	 

module hex_decoder (S, HEX);
	input [3:0] S;
	output [6:0] HEX;
	wire [6:0] hex;
	wire s3, s2, s1, s0;
	assign {s3, s2, s1, s0} = S;
	
	assign hex[0] = s1 | s3 | (s0 & s2) | (~s0 & ~s2);
	assign hex[1] = ~s2 | (s1 & s0) | (~s1 & ~s0);
	assign hex[2] = ~s1 | s2 | s0;
	assign hex[3] = s3 | (~s0 & ~s2) | (s1 & ~s0) | (s1 & ~s2) | (~s1 & s0 & s2);
	assign hex[4] = (~s0 & ~s2) | (s1 & ~s0);
	assign hex[5] = s3 | (~s1 & ~s0) | (~s1 & s2) | (~s0 & s2);
	assign hex[6] = s3 | (~s1 & s2) | (s1 & ~s0) | (s1 & ~s2);
	assign HEX = ~{hex[6], hex[5], hex[4], hex[3], hex[2], hex[1], hex[0]}; 
endmodule

	
  
    
  