`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:27 09/05/2015 
// Design Name: 
// Module Name:    buzzer_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module buzzer_control(clk,rst_n,note_div,audio_left,audio_right
);
	input clk;
	input rst_n;
	input [19:0] note_div;
	output [15:0] audio_left, audio_right;

	reg [19:0] clk_cnt_next, clk_cnt;
	reg b_clk, b_clk_next;

	always @(posedge clk or negedge rst_n)
	begin
		if (~rst_n)
		begin
			clk_cnt <= 20'd0;
			b_clk <= 1'b0;
		end
		else
		begin
			clk_cnt <= clk_cnt_next;
			b_clk <= b_clk_next;
		end
	end

	always @*
	begin
		if (clk_cnt == note_div)
		begin
			clk_cnt_next = 20'd0;
			b_clk_next = ~b_clk;
		end
		else
		begin
			clk_cnt_next = clk_cnt + 1'b1;
			b_clk_next = b_clk;
		end
	end

	assign audio_left = (b_clk == 1'b0) ? 16'h4000 : 16'h3FFF;
	assign audio_right = (b_clk == 1'b0) ? 16'h4000 : 16'h3FFF;
endmodule
