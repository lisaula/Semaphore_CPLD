`timescale 1ns / 1ps
module FSM_SEMA_MAIN(
	input p,
	input w,
	input s,
	input clk,
	input reset,
	output[2:0] w_gyr,
	output[2:0] s_gyr,
	output[1:0] p_gr
    );
	 reg[3:0] cst;
	 wire[3:0] nst;
	 wire Clk_m_s;
	CLKDiv Clock_m_s(clk, Clk_m_s);
	FSM_Sema_CL sema(p,w,s,cst,w_gyr,s_gyr,p_gr,nst);
	
	always @(posedge Clk_m_s)
	begin
		if(reset) begin
			cst = 4'b0000;
			end
		else
			begin
			cst = nst;
			end
	end
endmodule
