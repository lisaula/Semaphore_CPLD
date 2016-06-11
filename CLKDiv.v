`timescale 1ns / 1ps
module CLKDiv(
    input clk,
	 output clk1hz
	 );
	 
	 reg [21:0] counter;
	 reg clk1hz_buff;
	 
	 assign clk1hz = clk1hz_buff;
	 
	 always @(posedge clk)
	 begin 
	 
		counter = counter +1;
		
		if(counter == 4000000)
		begin
			clk1hz_buff = !clk1hz_buff;
			counter = 22'h0;
		end
	end

endmodule
