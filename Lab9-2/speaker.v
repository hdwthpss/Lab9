`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:32:09 09/05/2015 
// Design Name: 
// Module Name:    speaker 
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
module speaker(clk,rst_n,audio_appsel,audio_sysclk,audio_bck,audio_ws,audio_data,switch,button_in_sound,button_in_vol,wh_light,display,led
);
	// I/O declaration
	input clk; // clock from the crystal
	input rst_n; // active low reset
	output audio_appsel; // playing mode selection
	output audio_sysclk; // control clock for DAC (from crystal)
	output audio_bck; // bit clock of audio data (5MHz)
	output audio_ws; // left/right parallel to serial control
	output audio_data; // serial output audio data
	wire [15:0] audio_in_left, audio_in_right;
	
	output [15:0] led;
	input switch;
	
	
	input [2:0] button_in_sound;
	wire [2:0] sound;
	wire [19:0] note_div;
	
	
	input [1:0] button_in_vol;
	wire [1:0] vol;
	
	wire [31:0] vol_level;
	
	
	wire [1:0] clk_ctl;
	wire [6:0] cnt_h;
	
	wire [3:0] level_0,level_1;
	wire [3:0] bcd;
	
	output [3:0] wh_light;
	output [14:0] display;
	
	bcd_seg b(
	.bcd(bcd),
	.display(display)
	);
	
	
	scan s(
	.freq_ctl(clk_ctl),
	.in0(level_0),
	.in1(level_1),
	.wh_light(wh_light),
	.light_num(bcd)
	);
	
	
	freq_div f(
	.cnt_h(cnt_h),
	.clk_ctl(clk_ctl),
	.clk(clk), 
	.rst_n(rst_n)
	);
	
	
	push_button vol_increase(
	.in_vol(button_in_vol[0]),
	.out_vol(vol[0]),
	.clk(cnt_h[0]), 
	.rst_n(rst_n)
	);
	
	push_button vol_decrease(
	.in_vol(button_in_vol[1]),
	.out_vol(vol[1]),
	.clk(cnt_h[0]), 
	.rst_n(rst_n)
	);
	
	
	
	
	debounce sound_do(
	.debounce_in(button_in_sound[0]),
	.debounce_out(sound[0]),
	.clk(cnt_h[0]), 
	.rst_n(rst_n)
	);
	
	debounce sound_re(
	.debounce_in(button_in_sound[1]),
	.debounce_out(sound[1]),
	.clk(cnt_h[0]), 
	.rst_n(rst_n)
	);
	
	debounce sound_mi(
	.debounce_in(button_in_sound[2]),
	.debounce_out(sound[2]),
	.clk(cnt_h[0]), 
	.rst_n(rst_n)
	);
	
	
	sound_set set(
	.sound(sound),
	.note_div(note_div),
	.switch(switch),
	.vol(vol),
	.vol_level(vol_level),
	.clk(cnt_h[0]), 
	.rst_n(rst_n),
	.level_0(level_0),
	.level_1(level_1),
	.led(led)
	);
	
	
	
	
	
	
	
	
	
	// Note generation
	buzzer_control Ung(
	.clk(clk), // clock from crystal
	.rst_n(rst_n), // active low reset
	.note_div(note_div), // div for note generation
	.audio_left(audio_in_left), // left sound audio
	.audio_right(audio_in_right),// right sound audio
	.vol_level(vol_level)
	);
	
	// Speaker controllor
	speaker_control Usc(
	.clk(clk), // clock from the crystal
	.rst_n(rst_n), // active low reset
	.audio_in_left(audio_in_left), // left channel audio data input
	.audio_in_right(audio_in_right), // right channel audio data input
	.audio_appsel(audio_appsel), // playing mode selection
	.audio_sysclk(audio_sysclk), // control clock for DAC (from crystal)
	.audio_bck(audio_bck), // bit clock of audio data (5MHz)
	.audio_ws(audio_ws), // left/right parallel to serial control
	.audio_data(audio_data) // serial output audio data
	);
 
endmodule
