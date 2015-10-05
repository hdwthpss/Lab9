`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:54:55 09/15/2015 
// Design Name: 
// Module Name:    sound_set 
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
module sound_set(sound,note_div,switch,vol,vol_level,clk,rst_n,level_0,level_1,led
    );
	input [2:0] sound;
	input switch;
	input [1:0] vol;
	input clk,rst_n;
	output reg [15:0] led;
	output reg [19:0] note_div;
	output reg [31:0] vol_level;
	reg [31:0] vol_level_next;
	
	output reg [3:0] level_0;
	output reg [3:0] level_1;
	reg [3:0] level_0_next;
	reg [3:0] level_1_next;
	
	always@(*)
		begin
			if(sound[0]==1'b1 && switch==1'b1)
				note_div = 20'd76628;
			else if(sound[1]==1'b1 && switch==1'b1)
				note_div = 20'd68259;
			else if(sound[2]==1'b1 && switch==1'b1)
				note_div = 20'd60606;
			else
				note_div = 20'd0;
				
				
			if(vol[0]==1'b1)
				begin
					if(level_0==4'd9)
						begin
							level_0_next=4'd0;
							level_1_next=level_1+4'd1;
						end
					else
						begin
							level_0_next=level_0+4'd1;
							level_1_next=level_1;
						end
					
					vol_level_next[31:16]=vol_level[31:16]+16'h400;
					vol_level_next[15:0]=vol_level[15:0]-16'h400;
				end
				
			else if(vol[1]==1'b1)
				begin
					if(level_0==4'd0 && level_1!=4'd0)
						begin
							level_0_next=4'd9;
							level_1_next=level_1-4'd1;
						end
					else
						begin
							level_0_next=level_0-4'd1;
							level_1_next=level_1;
						end
					
					vol_level_next[31:16]=vol_level[31:16]-16'h400;
					vol_level_next[15:0]=vol_level[15:0]+16'h400;
				end
			else
				begin
					level_0_next=level_0;
					level_1_next=level_1;
					vol_level_next=vol_level;
				end
		
		end
	
	
	always@(*)
		case({level_1,level_0})
			8'b0000_0001 : led=16'b1000_0000_0000_0000;
			8'b0000_0010 : led=16'b1100_0000_0000_0000;
			8'b0000_0011 : led=16'b1110_0000_0000_0000;
			8'b0000_0100 : led=16'b1111_0000_0000_0000;
			8'b0000_0101 : led=16'b1111_1000_0000_0000;
			8'b0000_0110 : led=16'b1111_1100_0000_0000;
			8'b0000_0111 : led=16'b1111_1110_0000_0000;
			8'b0000_1000 : led=16'b1111_1111_0000_0000;
			8'b0000_1001 : led=16'b1111_1111_1000_0000;
			8'b0001_0000 : led=16'b1111_1111_1100_0000;
			8'b0001_0001 : led=16'b1111_1111_1110_0000;
			8'b0001_0010 : led=16'b1111_1111_1111_0000;
			8'b0001_0011 : led=16'b1111_1111_1111_1000;
			8'b0001_0100 : led=16'b1111_1111_1111_1100;
			8'b0001_0101 : led=16'b1111_1111_1111_1110;
			8'b0001_0110 : led=16'b1111_1111_1111_1111;
		endcase
			
			
	
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			begin
				vol_level <= {16'h0000,16'h0000};
				level_0<=4'd1;
				level_1<=4'd0;
			end
		else
			begin
				vol_level <= vol_level_next;
				level_1<=level_1_next;
				level_0<=level_0_next;
			end
	
endmodule
