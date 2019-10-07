module OptimumTemperature(Selector, PersonTens, PersonOnes, TempTens, TempOnes);

	//inputs
	input [7:0] Selector;
	input [3:0] PersonTens, PersonOnes;
	
	//outputs
	output reg [3:0] TempTens, TempOnes;

	//variables
	reg [6:0] TotalPersons;
	
		always @(Selector == 3) begin
		TotalPersons <= PersonTens * 10 + PersonOnes;
		if(TotalPersons < 15 ) begin
		TempTens <= 4'b0010;
		TempOnes <= 4'b0110;
		end
		if(TotalPersons < 25 && TotalPersons > 14) begin
		TempTens <= 4'b0010;
		TempOnes <= 4'b0100;
		end
		
		if(TotalPersons < 35 && TotalPersons > 24) begin
		TempTens <= 4'b0010;
		TempOnes <= 4'b0010;
		end

		if(TotalPersons < 45 && TotalPersons > 34) begin
		TempTens <= 4'b0010;
		TempOnes <= 4'b0100;
		end
		
		end
endmodule
