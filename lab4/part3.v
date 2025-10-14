module part3 (KEY, CLOCK_50, HEX0);
	input [0:0] KEY;
	input CLOCK_50;
	output [6:0] HEX0;
	wire resetn = KEY[0];
	reg [25:0] Q;
	reg [3:0] D;
	reg enable;
	// larger counter
	always @(posedge CLOCK_50, negedge resetn)
		begin
			if(resetn == 1'b0)
				begin
					Q <= 26'b0;
					enable <= 1'b0;
				end
			else if(Q == 26'd50000000)
				begin
					Q <= 26'b0;
					enable <= 1'b1;
				end
			else
				begin
					enable <= 1'b0;
					Q <= Q + 26'b1;
				end
		end
	
	//small counter
	always @(posedge CLOCK_50, negedge resetn)
		begin 
			if(resetn == 1'b0)
				D <= 4'b0000;
			else if(enable == 1'b1)
				begin
					if(D == 4'd9)
						D <= 4'b0000;
					else
						D <= D + 4'b0001;
				end
		end
	
	hex_decoder h0(D, HEX0); 
endmodule
