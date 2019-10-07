module MultiplexerOutput_top(Clock,Reset,Increment,Decrement, Selector,Hex);

	//inputs
	input Clock;
	input Reset;
	input Increment;
	input Decrement;
	input [7:0] Selector;
	
	//outputs
	output reg [0:41] Hex;
	
	//variables
	wire [0:6] Digit1, Digit0;
	wire [0:6] RDigit1, RDigit0;
	wire [3:0] BCD1, BCD0;
	wire [3:0] RoomDigit1, RoomDigit0;
	reg Enable;
	
	
	
	always @(posedge Clock) begin
		if(Reset)
			Enable <= 0;
		else
			Enable <= 1;
	end
	
	
	Clock10ms clock10(.clkin(Clock), .clkout(clkout));
	BCDcount counter(clkout, Reset, Enable, BCD1, BCD0);
	AddRoom addRoom(Selector, Increment, Decrement,RoomDigit1,RoomDigit0);
	SevenSegment seg1(BCD1, Digit1);
	SevenSegment seg0(BCD0, Digit0);
	SevenSegment seg3(RoomDigit1, RDigit1);
	SevenSegment seg2(RoomDigit0, RDigit0);
				
	
	always @(Selector)
		case (Selector) 
	
		0: begin
		Hex[0:6] = Digit0;
		Hex[7:13] = Digit1;
		Hex[14:20] = 7'b0000001;
		Hex[21:27] = 7'b0000001;
		Hex[28:34] = 7'b0000001;
		Hex[35:41] = 7'b0000001;
		end
		
		1: begin
		Hex[0:6] = 7'b0001100;
		Hex[7:13] = 7'b1001111;
		Hex[14:20] = 7'b0100100;
		Hex[21:27] = 7'b0000001;
		Hex[28:34] = 7'b0000001;
		Hex[35:41] = 7'b1001111;
		end

		2: begin
		Hex[0:6] = 7'b1111111;
		Hex[7:13] = 7'b1111111;
		Hex[14:20] = 7'b1111111;
		Hex[21:27] = 7'b1110000;
		Hex[28:34] = 7'b0001000;
		Hex[35:41] = 7'b0100100;
		end
		
		3: begin
		Hex[0:6] = 7'b1111111;
		Hex[7:13] = 7'b1111111;
		Hex[14:20] = 7'b1111111;
		Hex[21:27] = 7'b0110001;
		Hex[28:34] = 7'b1001111;
		Hex[35:41] = 7'b0010010;
		end
		
		4: begin
		Hex[0:6] = 7'b1110001;
		Hex[7:13] = 7'b0011000;
		Hex[14:20] = 7'b0011000;
		Hex[21:27] = 7'b1111111;
		Hex[28:34] = RDigit0;
		Hex[35:41] = RDigit1;
		end
		
		5: begin
		Hex[0:6] = 7'b1110000;
		Hex[7:13] = 7'b0111000;
		Hex[14:20] = 7'b1111111;
		Hex[21:27] = 7'b0000001;
		Hex[28:34] = 7'b0000001;
		Hex[35:41] = 7'b1001111;
		end
		
		6: begin
		Hex[0:6] = 7'b1111111;
		Hex[7:13] = 7'b1111111;
		Hex[14:20] = 7'b1000010;
		Hex[21:27] = 7'b0000001;
		Hex[28:34] = 7'b0000001;
		Hex[35:41] = 7'b0100000;
		end
		
		

		7: begin
		Hex[0:6] = Digit0;
		Hex[7:13] = Digit1;
		Hex[14:20] = 7'b0000001;
		Hex[21:27] = 7'b0000001;
		Hex[28:34] = 7'b0011000;
		Hex[35:41] = 7'b1000001;
		end
		
		20: begin
		Hex[0:6] = 7'b1110001;
		Hex[7:13] = 7'b0011000;
		Hex[14:20] = 7'b0011000;
		Hex[21:27] = 7'b1111111;
		Hex[28:34] = RDigit0;
		Hex[35:41] = RDigit1;
		end
		
		endcase
endmodule
