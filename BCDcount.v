module BCDcount(Clock, Reset, Enable,BCD1,BCD0);
	input Clock, Reset, Enable;
	output reg [3:0] BCD1,BCD0;
	
	always @(posedge Clock)
	begin
		if(Reset) begin
			BCD1 <= 0;
			BCD0 <= 0;
		end
		
		
		
		else if (Enable)
			if (BCD0 == 4'b1001) begin	//if 9 seconds na, i zero niya then i increment si tens
				BCD0 <= 0;
				if(BCD1 == 4'b1001) //if 99 seconds na, i zero niya si tens then i increment si minutes
					BCD1 <= 0;
				else
					BCD1 <= BCD1 + 1;
			end
			else
				BCD0 <= BCD0 + 1;
	end
endmodule