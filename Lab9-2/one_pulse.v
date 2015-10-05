`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:01 09/02/2015 
// Design Name: 
// Module Name:    one_pulse 
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
module one_pulse(debounce_in,one_pulse_out,clk,rst_n
    );
	input debounce_in;
	input clk,rst_n;
	output one_pulse_out;
	
	reg debounce_in_delay;
	reg one_pulse_out;
	reg temp;
	
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			debounce_in_delay<=1'b0;
		else
			debounce_in_delay<=debounce_in;
	
	always@(*)
		temp=debounce_in & (~debounce_in_delay);
		
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			one_pulse_out<=1'b0;
		else
			one_pulse_out<=temp;
		

endmodule
