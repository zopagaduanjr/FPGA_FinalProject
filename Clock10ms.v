module Clock10ms(clkin, clkout, Selector);
	input [7:0] Selector;
	input clkin;
	output reg clkout;
	
	always @(posedge clkin) begin : divider
		if(Selector == 16) begin
		integer i;
		i <= i + 1;
		if(i >= 25000000) begin
			i <= 0;
			clkout <= ~clkout;
		end
		end
		if(Selector == 48) begin
		integer i;
		i <= i + 1;
		if(i >= 50000000) begin
			i <= 0;
			clkout <= ~clkout;
		end
		end
		else begin
		integer i;
		i <= i + 1;
		if(i >= 2500) begin
			i <= 0;
			clkout <= ~clkout;
		end
		end
	end
endmodule