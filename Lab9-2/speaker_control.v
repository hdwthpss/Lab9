`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:01 09/05/2015 
// Design Name: 
// Module Name:    speaker_control 
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
module speaker_control(audio_in_left,audio_in_right,rst_n,clk,audio_appsel,audio_sysclk,audio_bck,audio_ws,audio_data
    );
	 
	 
	input [15:0] audio_in_left,audio_in_right;
	input rst_n;
	input clk;
	
	output reg  audio_appsel;
	output reg audio_sysclk;
	output reg audio_bck;
	output reg audio_ws;
	output reg audio_data;
	
	reg [7:0] temp;
	reg [1:0] cnt_h;
	reg [3:0] cnt_l;
	
	
	
	reg [3:0] bck,bck_next;
	reg [15:0] q;
	
	always@(*)
		begin
			temp={audio_ws,cnt_l,audio_bck,cnt_h}+8'd1;
			audio_sysclk=clk;
			audio_appsel=1'b1;
		
				
			case({audio_ws,bck})
				5'b1_0000: audio_data = audio_in_left[15];
				5'b1_0001: audio_data = audio_in_left[14];
				5'b1_0010: audio_data = audio_in_left[13];
				5'b1_0011: audio_data = audio_in_left[12];
				5'b1_0100: audio_data = audio_in_left[11];
				5'b1_0101: audio_data = audio_in_left[10];
				5'b1_0110: audio_data = audio_in_left[9];
				5'b1_0111: audio_data = audio_in_left[8];
				5'b1_1000: audio_data = audio_in_left[7];
				5'b1_1001: audio_data = audio_in_left[6];
				5'b1_1010: audio_data = audio_in_left[5];
				5'b1_1011: audio_data = audio_in_left[4];
				5'b1_1100: audio_data = audio_in_left[3];
				5'b1_1101: audio_data = audio_in_left[2];
				5'b1_1110: audio_data = audio_in_left[1];
				5'b1_1111: audio_data = audio_in_left[0];
				5'b0_0000: audio_data = audio_in_right[15];
				5'b0_0001: audio_data = audio_in_right[14];
				5'b0_0010: audio_data = audio_in_right[13];
				5'b0_0011: audio_data = audio_in_right[12];
				5'b0_0100: audio_data = audio_in_right[11];
				5'b0_0101: audio_data = audio_in_right[10];
				5'b0_0110: audio_data = audio_in_right[9];
				5'b0_0111: audio_data = audio_in_right[8];
				5'b0_1000: audio_data = audio_in_right[7];
				5'b0_1001: audio_data = audio_in_right[6];
				5'b0_1010: audio_data = audio_in_right[5];
				5'b0_1011: audio_data = audio_in_right[4];
				5'b0_1100: audio_data = audio_in_right[3];
				5'b0_1101: audio_data = audio_in_right[2];
				5'b0_1110: audio_data = audio_in_right[1];
				5'b0_1111: audio_data = audio_in_right[0];
				default: audio_data = 1'b0;
			endcase
			
		end
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			begin
				{audio_ws,cnt_l,audio_bck,cnt_h}<=8'd0;
			end
		else
			{audio_ws,cnt_l,audio_bck,cnt_h}<=temp;
			
			
	always@(*)
		bck_next=bck+1'b1;
		
	always@(posedge audio_bck or negedge rst_n)
		if(~rst_n)
			begin
				bck<=4'd0;
			end
		else
			bck<=bck_next;
			
endmodule
