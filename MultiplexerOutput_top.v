module MultiplexerOutput_top(Clock,Reset,Increment, Selector,Hex, DayOnes, DayTens, MonthOnes);

	//inputs
	input Clock;
	input Reset;
	input Increment;
	input [7:0] Selector;
	
	//outputs
	output reg [0:41] Hex;
	
	//variables
	wire [0:6] TimeDigit9,TimeDigit8, TimeDigit7, TimeDigit6, TimeDigit5, TimeDigit4,TimeDigit3, TimeDigit2,TimeDigit1;
	wire [0:6] PDigit1, PDigit0,RDigit1,RDigit0,TDigit1,TDigit0, DayLed2, DayLed1, DayLed0;
	wire [3:0] BCD1, BCD0;
	wire [3:0]  RoomDigit1, RoomDigit0, TempDigit1, TempDigit0;
	wire [3:0] PersonDigit1, PersonDigit0;
	wire running;
	
	//wag timer code
	wire [3:0] SecondOnesBCD, SecondTensBCD, MinuteOnesBCD, MinuteTensBCD, HourOnesBCD, HourTensBCD, DayOnesBCD, DayTensBCD, MonthBCD;
	wire [6:0] BCDayCombine, BCDHourCombine, BCDMinuteCombine;
	wire [6:0] SecondOnes, SecondTens, MinuteOnes, MinuteTens, HourOnes, HourTens;
	output wire [3:0] DayOnes, MonthOnes;
	output wire [1:0] DayTens;

	reg Enable;
	
	always @(posedge Clock) begin
		if(Reset)
			Enable <= 0;
		else
			Enable <= 1;
	end
	
	//runs in the background
	Clock10ms clock10(.clkin(Clock), .clkout(clkout), .Selector(Selector));
	ClockCount c1(clkout, Reset, Enable, SecondOnesBCD, SecondTensBCD, MinuteOnesBCD, MinuteTensBCD, HourOnesBCD, HourTensBCD, DayOnesBCD, DayTensBCD, MonthBCD, BCDayCombine, BCDHourCombine, BCDMinuteCombine);
	//BCDcount counter(clkout, Reset, Enable, BCD1, BCD0, BCDCombine);

	AddRemovePerson addRemovePerson(Selector, Increment, PersonDigit1, PersonDigit0);
	AddRemoveArea addRemoveArea(Selector, Increment, RoomDigit1, RoomDigit0);
	
	
	OptimumTemperature optimumTemp(Selector, PersonDigit1, PersonDigit0,TempDigit1, TempDigit0);
	
	
	
	
	SevenSegment segtime1(SecondOnesBCD, TimeDigit1);
	SevenSegment segtime2(SecondTensBCD, TimeDigit2);
	SevenSegment segtime3(MinuteOnesBCD, TimeDigit3);
	SevenSegment segtime4(MinuteTensBCD, TimeDigit4);
	SevenSegment segtime5(HourOnesBCD, TimeDigit5);
	SevenSegment segtime6(HourTensBCD, TimeDigit6);
	SevenSegment segtime7(DayOnesBCD, TimeDigit7);
	SevenSegment segtime8(DayTensBCD, TimeDigit8);
	SevenSegment segtime9(MonthBCD, TimeDigit9);
	
	
	
	
	
	
	
	//Person count output
	SevenSegment seg3(PersonDigit1, PDigit1);
	SevenSegment seg2(PersonDigit0, PDigit0);
	
	//Area output
	SevenSegment seg5(RoomDigit1, RDigit1);
	SevenSegment seg4(RoomDigit0, RDigit0);
	
	//Temperature output
	SevenSegment seg7(TempDigit1, TDigit1);
	SevenSegment seg6(TempDigit0, TDigit0);
	
	
	
	SevenSegmentDays segdays(BCDayCombine, DayLed2,DayLed1,DayLed0);
				
	
	always @(Selector)
		case (Selector) 
	
		0: begin
		Hex[0:6] = TimeDigit1;
		Hex[7:13] = TimeDigit2;
		Hex[14:20] = TimeDigit3;
		Hex[21:27] = TimeDigit4;
		Hex[28:34] = TimeDigit5;
		Hex[35:41] = TimeDigit6;
		end
		
		1: begin
		Hex[0:6] = 7'b0001100;
		Hex[7:13] = 7'b1001111;
		Hex[14:20] = TimeDigit7;
		Hex[21:27] = TimeDigit8;
		Hex[28:34] = TimeDigit9;
		Hex[35:41] = 7'b0000001;
		end

		2: begin
		Hex[0:6] = TimeDigit7;
		Hex[7:13] = TimeDigit8;
		Hex[14:20] = 7'b1111111;
		Hex[21:27] = DayLed0;
		Hex[28:34] = DayLed1;
		Hex[35:41] = DayLed2;
		end
		
		6: begin
		
		
		
		//Scheduler for MW
		if(BCDayCombine % 7 == 0 || BCDayCombine % 7 == 2) begin
			
			if(BCDHourCombine == 7) begin
				if(BCDMinuteCombine > 39 && BCDMinuteCombine < 59) begin
						Hex[0:6] = 7'b1111111;
						Hex[7:13] = 7'b1111111;
						Hex[14:20] = 7'b0110001;
						Hex[21:27] = 7'b1111110;
						Hex[28:34] = 7'b0000001;
						Hex[35:41] = 7'b0010010;
				end
			end
			else if(BCDHourCombine == 8) begin
				Hex[0:6] = 7'b1111111;
				Hex[7:13] = 7'b1111111;
				Hex[14:20] = 7'b0110001;
				Hex[21:27] = 7'b1111110;
				Hex[28:34] = 7'b0000001;
				Hex[35:41] = 7'b0010010;
			end
			else if(BCDHourCombine == 9) begin
				if(BCDMinuteCombine > 1 && BCDMinuteCombine < 10) begin
					//1st subject end
						Hex[0:6] = 7'b1111111;
						Hex[7:13] = 7'b1111111;
						Hex[14:20] = 7'b0110001;
						Hex[21:27] = 7'b1111110;
						Hex[28:34] = 7'b0000001;
						Hex[35:41] = 7'b0010010;
				end
				else if(BCDMinuteCombine > 19 && BCDMinuteCombine < 59) begin
						//2nd subject start
						Hex[0:6] = 7'b1111111;
						Hex[7:13] = 7'b1111111;
						Hex[14:20] = 7'b0110001;
						Hex[21:27] = 7'b1111110;
						Hex[28:34] = 7'b0000000;
						Hex[35:41] = 7'b0010010;
				end
				else begin
				//catch no subject must be off
					Hex[0:6] = 7'b1111111;
					Hex[7:13] = 7'b1111111;
					Hex[14:20] = 7'b1111111;
					Hex[21:27] = 7'b0111000;
					Hex[28:34] = 7'b0111000;
					Hex[35:41] = 7'b0000001;
		
				end
			end
			else if(BCDHourCombine == 10) begin
			//end of 2nd subject
				if(BCDMinuteCombine > 1 && BCDMinuteCombine < 50) begin
					Hex[0:6] = 7'b1111111;
					Hex[7:13] = 7'b1111111;
					Hex[14:20] = 7'b0110001;
					Hex[21:27] = 7'b1111110;
					Hex[28:34] = 7'b0000000;
					Hex[35:41] = 7'b0010010;
				end
			end
		
			else begin
			//catch no subject must be off
					Hex[0:6] = 7'b1111111;
					Hex[7:13] = 7'b1111111;
					Hex[14:20] = 7'b1111111;
					Hex[21:27] = 7'b0111000;
					Hex[28:34] = 7'b0111000;
					Hex[35:41] = 7'b0000001;

			end
		
		end
		
		//Scheduler for TTh
		else if(BCDayCombine % 7 == 1 || BCDayCombine % 7 == 3) begin
			if(BCDHourCombine == 7) begin
				if(BCDMinuteCombine > 39 && BCDMinuteCombine < 59) begin
						Hex[0:6] = 7'b1111111;
						Hex[7:13] = 7'b1111111;
						Hex[14:20] = 7'b0110001;
						Hex[21:27] = 7'b1111110;
						Hex[28:34] = 7'b0000001;
						Hex[35:41] = 7'b0010010;
				end
			end
			else if(BCDHourCombine == 8) begin
				Hex[0:6] = 7'b1111111;
				Hex[7:13] = 7'b1111111;
				Hex[14:20] = 7'b0110001;
				Hex[21:27] = 7'b1111110;
				Hex[28:34] = 7'b0000001;
				Hex[35:41] = 7'b0010010;
			end
			else if(BCDHourCombine == 9) begin
				if(BCDMinuteCombine > 1 && BCDMinuteCombine < 10) begin
					//1st subject end
						Hex[0:6] = 7'b1111111;
						Hex[7:13] = 7'b1111111;
						Hex[14:20] = 7'b0110001;
						Hex[21:27] = 7'b1111110;
						Hex[28:34] = 7'b0000001;
						Hex[35:41] = 7'b0010010;
				end
				else if(BCDMinuteCombine > 19 && BCDMinuteCombine < 59) begin
						//2nd subject start
						Hex[0:6] = 7'b1111111;
						Hex[7:13] = 7'b1111111;
						Hex[14:20] = 7'b0110001;
						Hex[21:27] = 7'b1111110;
						Hex[28:34] = 7'b0000000;
						Hex[35:41] = 7'b0010010;
				end
				else begin
				//catch no subject must be off
					Hex[0:6] = 7'b1111111;
					Hex[7:13] = 7'b1111111;
					Hex[14:20] = 7'b1111111;
					Hex[21:27] = 7'b0111000;
					Hex[28:34] = 7'b0111000;
					Hex[35:41] = 7'b0000001;
		
				end
			end
			else if(BCDHourCombine == 10) begin
			//end of 2nd subject
				if(BCDMinuteCombine > 1 && BCDMinuteCombine < 50) begin
					Hex[0:6] = 7'b1111111;
					Hex[7:13] = 7'b1111111;
					Hex[14:20] = 7'b0110001;
					Hex[21:27] = 7'b1111110;
					Hex[28:34] = 7'b0000000;
					Hex[35:41] = 7'b0010010;
				end
			end
		end
		//Scheduler for Friday
		else if(BCDayCombine % 7 == 4) begin
			if(BCDHourCombine > 8 && BCDHourCombine < 13) begin
				Hex[0:6] = 7'b1111111;
				Hex[7:13] = 7'b1111111;
				Hex[14:20] = 7'b0110001;
				Hex[21:27] = 7'b1111110;
				Hex[28:34] = 7'b0000001;
				Hex[35:41] = 7'b0010010;
			end
			else if(BCDHourCombine > 12 && BCDHourCombine < 17) begin
				Hex[0:6] = 7'b1111111;
				Hex[7:13] = 7'b1111111;
				Hex[14:20] = 7'b0110001;
				Hex[21:27] = 7'b1111110;
				Hex[28:34] = 7'b0000000;
				Hex[35:41] = 7'b0010010;
			end
			else begin
				//catch no subject must be off
					Hex[0:6] = 7'b1111111;
					Hex[7:13] = 7'b1111111;
					Hex[14:20] = 7'b1111111;
					Hex[21:27] = 7'b0111000;
					Hex[28:34] = 7'b0111000;
					Hex[35:41] = 7'b0000001;
			end
			
		end
					
		else if(PersonDigit1 == 0 && PersonDigit0 == 0) begin
		Hex[0:6] = 7'b1111111;
		Hex[7:13] = 7'b1111111;
		Hex[14:20] = 7'b1111111;
		Hex[21:27] = 7'b0111000;
		Hex[28:34] = 7'b0111000;
		Hex[35:41] = 7'b0000001;
		end
		
		else if (BCDayCombine % 7 == 5 || BCDayCombine % 7 == 5)begin
		Hex[0:6] = 7'b1111111;
		Hex[7:13] = 7'b1111111;
		Hex[14:20] = 7'b0110001;
		Hex[21:27] = 7'b1111110;
		Hex[28:34] = TDigit0;
		Hex[35:41] = TDigit1;
		end
		
		
		end
		
		4: begin
		Hex[0:6] = 7'b1110001;
		Hex[7:13] = 7'b0011000;
		Hex[14:20] = 7'b0011000;
		Hex[21:27] = 7'b1111111;
		Hex[28:34] = PDigit0;
		Hex[35:41] = PDigit1;
		end
		
		5: begin
		Hex[0:6] = 7'b1110000;
		Hex[7:13] = 7'b0111000;
		Hex[14:20] = 7'b1111111;
		Hex[21:27] = 7'b1111111;
		Hex[28:34] = RDigit0;
		Hex[35:41] = RDigit1;
		end
		
		3: begin
		Hex[0:6] = 7'b1111111;
		Hex[7:13] = 7'b1111111;
		Hex[14:20] = 7'b1000010;
		Hex[21:27] = 7'b0000001;
		Hex[28:34] = 7'b0000001;
		Hex[35:41] = 7'b0100000;
		end
		
		

		7: begin
		Hex[0:6] = TimeDigit1;
		Hex[7:13] = TimeDigit2;
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
		Hex[28:34] = PDigit0;
		Hex[35:41] = PDigit1;
		end
		
		
		21: begin
		Hex[0:6] = 7'b1110000;
		Hex[7:13] = 7'b0111000;
		Hex[14:20] = 7'b1111111;
		Hex[21:27] = 7'b1111111;
		Hex[28:34] = RDigit0;
		Hex[35:41] = RDigit1;
		end
		
		
		
		
		default: begin
		Hex[0:6] = TimeDigit1;
		Hex[7:13] = TimeDigit2;
		Hex[14:20] = TimeDigit3;
		Hex[21:27] = TimeDigit4;
		Hex[28:34] = TimeDigit5;
		Hex[35:41] = TimeDigit6;
		end
		
		
		
		endcase
endmodule
