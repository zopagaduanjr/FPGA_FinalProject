module ClockCount(clock, reset, Enable, secbcd0, secbcd1, minbcd0, minbcd1, hourbcd0, hourbcd1, daybcd0, daybcd1, monthbcd, BCDCombine);
	input clock, reset, Enable;
	output reg [3:0] secbcd0, secbcd1, minbcd0, minbcd1, hourbcd0, hourbcd1, daybcd0, daybcd1, monthbcd;
	output reg [6:0] BCDCombine;
	always @(posedge clock)
	begin
		if (reset) begin
			secbcd0 <= 0;
			secbcd1 <= 0;
			minbcd0 <= 0;
			minbcd1 <= 0;
			hourbcd0 <= 0;
			hourbcd1 <= 0;
			daybcd0 <= 0;
			daybcd1 <= 0;
			monthbcd <= 0;
		end
		
		else if (Enable)
		
			if (secbcd0 == 4'b1001)
			begin
				secbcd0 <= 0;
				
				if (secbcd1 == 4'b0101)
				begin
					secbcd1 <= 0;
					minbcd0 <= minbcd0 + 1;
					
					if (minbcd0 == 4'b1001)
					begin
						minbcd0 <= 0;
						
						if (minbcd1 == 4'b0101)
						begin
							minbcd1 <= 0;
							hourbcd0 <= hourbcd0 + 1;
							
							if (hourbcd1 < 4'b0010)
							begin
								if (hourbcd0 == 4'b1001)
								begin
									hourbcd0 <= 0;
									hourbcd1 <= hourbcd1 + 1;
								end
								
								else
									hourbcd0 <= hourbcd0 + 1;
							end
							
							else if (hourbcd1 == 4'b0010)
							begin
							
								if (hourbcd0 == 4'b0100)
								begin
									hourbcd0 <= 0;
									hourbcd1 <= 0;
									daybcd0 <= daybcd0 + 1;
									
									if (daybcd0 == 4'b1001)
									begin
										daybcd0 <= 0;
										
										if (daybcd1 == 4'b0011)
										begin
											daybcd1 <= 0;
											monthbcd <= monthbcd + 1;
											
											if (monthbcd == 4'b0100)
												monthbcd <= 0;
										end
										
										else
											daybcd1 <= daybcd1 + 1;
										
									end
									
									else if (daybcd0 == 4'b0000 && daybcd1 == 4'b0011 )
									begin
										daybcd0 <= 0;
										daybcd1 <= 0;
										monthbcd <= monthbcd + 1;
										if (monthbcd == 4'b0100)
											monthbcd <= 0;
									end
//									
//									else if (daybcd0 == 4'b0001 && daybcd1 == 4'b0011)
//									begin
//										daybcd0 <= 0;
//										daybcd1 <= 0;
//										monthbcd <= monthbcd + 1;
//										if (monthbcd == 4'b0100)
//											monthbcd <= 0;
//									end
									
									else
										daybcd0 <= daybcd0 + 1;
										
										
								end
								else
									hourbcd0 <= hourbcd0 + 1;
							end
							
						end
						
						else 
							minbcd1 <= minbcd1 + 1;
					end
					
					else
						minbcd0 <= minbcd0 + 1;
				end
				
				else
					secbcd1 <= secbcd1 + 1;
			end
			
			else
				secbcd0 <= secbcd0 + 1;
				
			BCDCombine <= daybcd1 * 10 + daybcd0;
		
	end
endmodule 