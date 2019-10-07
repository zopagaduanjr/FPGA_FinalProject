module Clock10ms(clkin, clkout);
	input clkin;
	output reg clkout;
	
	always @(posedge clkin) begin : divider
		integer i;
		
		i <= i + 1;
		if(i >= 25000000) begin
			i <= 0;
			clkout <= ~clkout;
		end
		
	end
endmodule