module SevenSegmentDays(bcd, leds2,leds1,leds0);
	input [3:0] bcd;
	output reg [0:6] leds2, leds1, leds0;
	
	always @(bcd)
		case (bcd) // abcdefg
			0: begin //mon
			leds0 = 7'b1101010;
			leds1 = 7'b1100010;
			leds2 = 7'b0001001;
			end
			
			1: begin //tue
			leds0 = 7'b0110000;
			leds1 = 7'b1000001;
			leds2 = 7'b1110000;
			end
			
			2: begin //wed
			leds0 = 7'b1000010;
			leds1 = 7'b0110000;
			leds2 = 7'b1100011;
			end
			
			3: begin //thu
			leds0 = 7'b1100011;
			leds1 = 7'b1101000;
			leds2 = 7'b1110000;
			end
			
			4: begin //fri
			leds0 = 7'b1111011;
			leds1 = 7'b1111010;
			leds2 = 7'b0111000;
			end
			
			5: begin //sat
			leds0 = 7'b1110000;
			leds1 = 7'b0001000;
			leds2 = 7'b0100100;
			end
			
			6: begin //sun
			leds0 = 7'b0001001;
			leds1 = 7'b1000001;
			leds2 = 7'b0100100;
			end
			
			
			default: begin
			leds0 = 7'b1111111;
			leds1 = 7'b1111111;
			leds2 = 7'b1111111;
			end
		endcase
endmodule