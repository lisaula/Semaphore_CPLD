`timescale 1ns / 1ps
module FSM_Sema_CL(
	input p,
	input w,
	input s,
	input[3:0] curr_st,
	output reg[2:0] w_gyr,
	output reg[2:0] s_gyr,
	output reg[1:0] p_gr,
	output reg[3:0] next_st
	);

parameter 
	w_green = 4'b0000,
	w_yellow_s = 4'b0001,
	w_yellow_p = 4'b0010,
	s_green = 4'b0011,
	s_yellow_w = 4'b0100,
	s_yellow_p = 4'b0101,
	p_green_w = 4'b0110,
	p_green_s = 4'b0111,

	ps_off1 = 4'b1000,
	ps_on1 = 4'b1001,
	ps_off2 = 4'b1010,
	ps_on2 = 4'b1011,

	pw_off1 = 4'b1100,
	pw_on1 = 4'b1101,
	pw_off2 = 4'b1110,
	pw_on2 = 4'b1111;

//se pudiera hacer concatenando los bits de salida
//assign s_gyr = curr_st[7:5]

	always @(s or w or p or curr_st)
	begin
		next_st = curr_st;
		w_gyr=w_gyr;
		s_gyr=s_gyr;
		p_gr=p_gr;
		case (curr_st)
			w_green : 
				begin
				if(s)begin
					next_st = w_yellow_s;
					s_gyr = 3'b001;
					w_gyr = 3'b010;
					p_gr = 2'b01;
					end
				else if (p) begin
					next_st = w_yellow_p;
					s_gyr = 3'b001;
					w_gyr = 3'b010;
					p_gr = 2'b01;
					end
				end
			w_yellow_s:begin
				next_st = s_green;
				s_gyr = 3'b100;
				w_gyr = 3'b001;
				p_gr = 2'b01;
				end
			w_yellow_p: begin
				next_st = p_green_w;
				s_gyr = 3'b001;
				w_gyr = 3'b001;
				p_gr = 2'b10;
				end
			s_green: 
				begin
				if(p) begin
					next_st = s_yellow_p;
					s_gyr = 3'b010;
					w_gyr = 3'b001;
					p_gr = 2'b01;
					end
				else if(s) begin
					next_st = s_yellow_w;
					s_gyr = 3'b010;
					w_gyr = 3'b001;
					p_gr = 2'b01;
					end
				end
			s_yellow_p: begin
				next_st = p_green_s;
				s_gyr = 3'b001;
				w_gyr = 3'b001;
				p_gr = 2'b10;
				end
			s_yellow_w: begin
				next_st = w_green;
				s_gyr = 3'b001;
				w_gyr = 3'b100;
				p_gr = 2'b01;
				end
			p_green_s: 
				begin
				if(w) begin
					next_st = pw_off1;
					s_gyr = 3'b001;
					w_gyr = 3'b001;
					p_gr = 2'b00;
					end
				else if (s) begin
					next_st = ps_off1;
					s_gyr = 3'b001;
					w_gyr = 3'b001;
					p_gr = 2'b00;
					end
				end
			p_green_w: 
				begin
				if(s) begin
					next_st = ps_off1;
					s_gyr = 3'b001;
					w_gyr = 3'b001;
					p_gr = 2'b00;
					end
				else if(w) begin
					next_st = pw_off1;
					s_gyr = 3'b001;
					w_gyr = 3'b001;
					p_gr = 2'b00;
					end
				end
			//blink del peaton a south
			ps_off1: begin
				next_st = ps_on1;
				s_gyr = 3'b001;
				w_gyr = 3'b001;
				p_gr = 2'b10;
				end
			ps_on1: begin
				next_st = ps_off2;
				s_gyr = 3'b001;
				w_gyr = 3'b001;
				p_gr = 2'b00;
				end
			ps_off2: begin
				next_st = ps_on2;
				s_gyr = 3'b001;
				w_gyr = 3'b001;
				p_gr = 2'b10;
				end
			ps_on2: begin
				next_st = s_green;
				s_gyr = 3'b100;
				w_gyr = 3'b001;
				p_gr = 2'b01;
				end

			//blink del peaton a weast
			pw_off1: begin
				next_st = pw_on1;
				s_gyr = 3'b001;
				w_gyr = 3'b001;
				p_gr = 2'b10;
				end
			pw_on1: begin
				next_st = pw_off2;
				s_gyr = 3'b001;
				w_gyr = 3'b001;
				p_gr = 2'b00;
				end
			pw_off2: begin
				next_st = pw_on2;
				s_gyr = 3'b001;
				w_gyr = 3'b001;
				p_gr = 2'b10;
				end
			pw_on2: begin
				next_st = w_green;
				s_gyr = 3'b001;
				w_gyr = 3'b100;
				p_gr = 2'b01;
				end
			endcase
	end
endmodule