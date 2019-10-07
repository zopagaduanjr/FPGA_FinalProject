module SevenSegment(bcd, leds);
	input [3:0] bcd;
	output reg [0:6] leds;
	
	always @(bcd)
		case (bcd) // abcdefg
			0: leds = 7'b0000001;
			1: leds = 7'b1001111;
			2: leds = 7'b0010010;
			3: leds = 7'b0000110;
			4: leds = 7'b1001100;
			5: leds = 7'b0100100;
			6: leds = 7'b0100000;
			7: leds = 7'b0001111;
			8: leds = 7'b0000000;
			9: leds = 7'b0001100;
		endcase
endmodule