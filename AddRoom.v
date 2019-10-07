module AddRoom(Selector, Increment, Decrement, RoomDigit1, RoomDigit0);

	//inputs
	input [7:0] Selector;
	input wire Increment;
	input wire Decrement;


	//outputs
	output reg [3:0] RoomDigit1, RoomDigit0;

	
	

	
	always @ ( posedge Increment) begin

	
	if (Selector == 20) begin
		if (RoomDigit0 == 4'b0000) begin	//if 9 seconds na, i zero niya then i increment si tens
				RoomDigit0 <= 9;
				if(RoomDigit1 == 4'b0000) //if 99 seconds na, i zero niya si tens then i increment si minutes
					RoomDigit1 <= 9;
				else
					RoomDigit1 <= RoomDigit1 - 1;
		end
		else
				RoomDigit0 <= RoomDigit0 - 1;
	
	end
	
	
	else begin
	if (RoomDigit0 == 4'b1001) begin	//if 9 seconds na, i zero niya then i increment si tens
				RoomDigit0 <= 0;
				if(RoomDigit1 == 4'b1001) //if 99 seconds na, i zero niya si tens then i increment si minutes
					RoomDigit1 <= 0;
				else
					RoomDigit1 <= RoomDigit1 + 1;
		end
		else
				RoomDigit0 <= RoomDigit0 + 1;
	end
	
	end
	

	
	
endmodule