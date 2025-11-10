module part3 (
    input  [2:0] SW,
    input  [1:0] KEY,
    input        CLOCK_50,
    output reg [9:0] LEDR
);

    wire resetn = KEY[0];   

 
    reg [10:0] pattern;
    reg [3:0]  length;
    always @(*) begin
        case (SW)
            3'b000: begin pattern = 11'b11101;          length = 5;  end // A
            3'b001: begin pattern = 11'b101010111;      length = 9;  end // B
            3'b010: begin pattern = 11'b10111010111;    length = 11; end // C
            3'b011: begin pattern = 11'b1010111;        length = 7;  end // D
            3'b100: begin pattern = 11'b1;              length = 1;  end // E
            3'b101: begin pattern = 11'b101110101;      length = 9;  end // F
            3'b110: begin pattern = 11'b101110111;      length = 9;  end // G
            3'b111: begin pattern = 11'b1010101;        length = 7;  end // H
            default:begin pattern = 11'b0;              length = 0;  end
        endcase
    end

    // 0.5-second counter
    reg [25:0] Q;
    reg enable;
    always @(posedge CLOCK_50 or negedge resetn) begin
        if (!resetn) begin
            Q <= 26'b0;
            enable <= 1'b0;
        end
        else if (Q == 26'd24999999) begin
            Q <= 26'b0;
            enable <= 1'b1;  
        end
        else begin
            Q <= Q + 1'b1;
            enable <= 1'b0;
        end
    end

    // FSM state definitions
    parameter [1:0]
        Sidle    = 2'b00,
        Sload    = 2'b01,
        Sdisplay = 2'b10;

    reg [1:0] state, next_state;
    reg [10:0] shift_reg;
    reg [3:0]  remain_length;

    // Next-state logic
    always @(*) begin
        case (state)
            Sidle:    if (KEY[1] == 0) 
									next_state = Sload; 
                      else next_state = Sidle;

            Sload:    next_state = Sdisplay;

            Sdisplay: if (remain_length == 0) next_state = Sidle;
                      else next_state = Sdisplay;

            default:  next_state = Sidle;
        endcase
    end

    // update state
    always @(posedge CLOCK_50 or negedge resetn) begin
        if (!resetn)
            state <= Sidle;
        else
            state <= next_state;
    end

    // Output logic and actions
    always @(posedge CLOCK_50 or negedge resetn) begin
        if (!resetn) begin
            shift_reg <= 11'b0;
            remain_length <= 4'b0;
            LEDR <= 10'b0;
        end
        else begin
            case (state)
                Sidle: begin
                    LEDR[9] <= 0; // LED off
                end

                Sload: begin
                    shift_reg <= pattern;
                    remain_length <= length;
                    LEDR[9] <= 0;
                end

                Sdisplay: begin
                    LEDR[9] <= shift_reg[0]; // show current bit
                    if (enable) begin
                        shift_reg <= {1'b0, shift_reg[10:1]};
                        if (remain_length > 0)
                            remain_length <= remain_length - 1;
                    end
                end
            endcase
        end
    end

endmodule
