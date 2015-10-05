`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:04:46 09/02/2015 
// Design Name: 
// Module Name:    debounce 
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
module debounce(debounce_in,clk,rst_n,debounce_out
    );
	input debounce_in;
	input clk,rst_n;
	output debounce_out;
	reg debounce_out;
	
	reg [3:0] debouce_window;
	reg [3:0] temp;
	reg temp_value;
	
	always@(*)
		begin
			debouce_window[0]=~debounce_in;
			debouce_window[1]=temp[0];
			debouce_window[2]=temp[1];
			debouce_window[3]=temp[2];
			temp_value=debouce_window[0] & debouce_window[1] & debouce_window[2] & debouce_window[3];
		end
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			begin
				temp<=4'b0000;
			end
		else
			begin
				temp[0]<=debouce_window[0];
				temp[1]<=debouce_window[1];
				temp[2]<=debouce_window[2];
				temp[3]<=debouce_window[3];
				debounce_out<=temp_value;
			end
endmodule
