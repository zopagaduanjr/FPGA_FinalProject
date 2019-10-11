module Clock10ms(clkin, clkout, Key0, Selector);
	input [7:0] Selector;
	input clkin;
	input Key0;
	output reg clkout;
	
	always @(posedge clkin) begin : divider

		if(Selector == 48) begin
		integer i;
		i <= i + 1;
		if(i >= 50000000) begin
			i <= 0;
			clkout <= ~clkout;
		end
		end
		else if(!Key0) begin
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
		if(i >= 10000) begin
			i <= 0;
			clkout <= ~clkout;
		end
		end
	end
endmodule