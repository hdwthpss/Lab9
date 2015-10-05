`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:56:52 09/15/2015 
// Design Name: 
// Module Name:    push_button 
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
module push_button(in_vol,rst_n,clk,out_vol
    );
	input in_vol;
	input clk,rst_n;
	output out_vol;
	
	wire vol_debounce;
	
	
	
	debounce vol_de(
	.debounce_in(in_vol),
	.debounce_out(vol_debounce),
	.clk(clk),
	.rst_n(rst_n)
	);
	
	one_pulse vol_on(
	.debounce_in(vol_debounce),
	.one_pulse_out(out_vol),
	.clk(clk),
	.rst_n(rst_n)
	);
	
endmodule
