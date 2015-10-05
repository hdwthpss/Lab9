`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:43:31 09/11/2015
// Design Name:   speaker
// Module Name:   E:/Lab9_1/test.v
// Project Name:  Lab9_1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: speaker
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg rst_n;

	// Outputs
	wire audio_appsel;
	wire audio_sysclk;
	wire audio_bck;
	wire audio_ws;
	wire audio_data;

	// Instantiate the Unit Under Test (UUT)
	speaker uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.audio_appsel(audio_appsel), 
		.audio_sysclk(audio_sysclk), 
		.audio_bck(audio_bck), 
		.audio_ws(audio_ws), 
		.audio_data(audio_data)
	);
    
	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;
		#1
		rst_n=1;
		// Wait 100 ns for global reset to finish
	
		// Add stimulus here

	end
      always #1 clk = ~clk;
endmodule

