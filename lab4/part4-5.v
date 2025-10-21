module part4 (KEY, CLOCK_50, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
    input [0:0] KEY;
    input CLOCK_50;
    output [6:0] HEX5;
	 output [6:0] HEX4;
	 output [6:0] HEX3;
	 output [6:0] HEX2;
	 output [6:0] HEX1;
	 output [6:0] HEX0;
    wire resetn = KEY[0];
    reg [25:0] Q;
    reg [2:0] D;        // 3-bit counter
    reg enable;

    // Large counter (1 Hz enable pulse)
    always @(posedge CLOCK_50, negedge resetn)
        begin
            if (resetn == 1'b0)
                begin
                    Q <= 26'b0;
                    enable <= 1'b0;
                end
            else if (Q == 26'd50000000)
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

    // 3-bit counter (counts 0–7)
    always @(posedge CLOCK_50, negedge resetn)
        begin
            if (resetn == 1'b0)
                D <= 3'b000;
            else if (enable == 1'b1)
                begin
                    if (D == 3'b101)
                        D <= 3'b000;
                    else
                        D <= D + 3'b001;
                end
        end
	hex5_mux6to1 h5(D, HEX5);
	hex4_mux6to1 h4(D, HEX4);
	hex3_mux6to1 h3(D, HEX3);
	hex2_mux6to1 h2(D, HEX2);
	hex1_mux6to1 h1(D, HEX1);
	hex0_mux6to1 h0(D, HEX0);
	
endmodule


 module hex5_mux6to1 (sel, hex5); 
    input [2:0] sel;   
    output reg [6:0]hex5;
    always @(sel) 
		begin
        if (sel == 3'b000)
            hex5 = 7'b1111111;
        else if (sel == 3'b001)
            hex5 = 7'b1111111;
        else if (sel == 3'b010)
            hex5 = 7'b1111111;
        else if (sel == 3'b011)
            hex5 = 7'b0100001;
        else if (sel == 3'b100)
            hex5 = 7'b0000110;
        else if (sel == 3'b101)
            hex5 = 7'b1111001;
		  else 
				hex5 = 7'b1111111;
    end
endmodule

 module hex4_mux6to1 (sel, hex4);  
    input [2:0] sel;   
    output reg [6:0]hex4;
    always @(sel) 
		begin
        if (sel == 3'b000)
            hex4 = 7'b1111111;
        else if (sel == 3'b001)
            hex4 = 7'b1111111;
        else if (sel == 3'b010)
            hex4 = 7'b0100001;
        else if (sel == 3'b011)
            hex4 = 7'b0000110;
        else if (sel == 3'b100)
            hex4 = 7'b1111001;
        else if (sel == 3'b101)
            hex4 = 7'b1111111;
			else 
				hex4 = 7'b1111111;
    end
endmodule


 module hex3_mux6to1 (sel, hex3);  
    input [2:0] sel;   
    output reg [6:0]hex3;
    always @(sel) 
		begin
        if (sel == 3'b000)
            hex3 = 7'b1111111;
        else if (sel == 3'b001)
            hex3 = 7'b0100001;
        else if (sel == 3'b010)
            hex3 = 7'b0000110;
        else if (sel == 3'b011)
            hex3 = 7'b1111001;
        else if (sel == 3'b100)
            hex3 = 7'b1111111;
        else if (sel == 3'b101)
            hex3 = 7'b1111111;
		   else 
				hex3 = 7'b1111111;
    end
endmodule


 module hex2_mux6to1 (sel, hex2);  
    input [2:0] sel;   
    output reg [6:0]hex2;
    always @(sel) 
		begin
        if (sel == 3'b000)
            hex2 = 7'b0100001; 
        else if (sel == 3'b001)
            hex2 = 7'b0000110; 
        else if (sel == 3'b010)
            hex2 = 7'b1111001; 
        else if (sel == 3'b011)
            hex2 = 7'b1111111; 
        else if (sel == 3'b100)
            hex2 = 7'b1111111; 
        else if (sel == 3'b101)
            hex2 = 7'b1111111; 
		   else 
				hex2 = 7'b1111111;
    end
endmodule


 module hex1_mux6to1 (sel, hex1); 
    input [2:0] sel;   
    output reg [6:0]hex1;
    always @(sel) 
		begin
        if (sel == 3'b000)
            hex1 = 7'b0000110;
        else if (sel == 3'b001)
            hex1 = 7'b1111001;
        else if (sel == 3'b010)
            hex1 = 7'b1111111;
        else if (sel == 3'b011)
            hex1 = 7'b1111111;
        else if (sel == 3'b100)
            hex1 = 7'b1111111;
        else if (sel == 3'b101)
            hex1 = 7'b0100001;
		  else 
				hex1 = 7'b1111111;
    end
endmodule


 module hex0_mux6to1 (sel, hex0);  
    input [2:0] sel;   
    output reg [6:0]hex0;
    always @(sel) 
		begin
        if (sel == 3'b000)
            hex0 = 7'b1111001;
        else if (sel == 3'b001)
            hex0 = 7'b1111111;
        else if (sel == 3'b010)
            hex0 = 7'b1111111;
        else if (sel == 3'b011)
            hex0 = 7'b1111111;
        else if (sel == 3'b100)
            hex0 = 7'b0100001;
        else if (sel == 3'b101)
            hex0 = 7'b0000110;
		  else 
				hex0 = 7'b1111111;
    end
endmodule


