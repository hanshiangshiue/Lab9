`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:51:28 09/09/2015
// Design Name:   speaker
// Module Name:   C:/Users/owner/Desktop/lab9_1/speaker_test.v
// Project Name:  lab9_1
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

module speaker_test;

	// Inputs
	reg clk;
	reg rst_n;

	// Outputs
	wire audio_appsel;
	wire audio_sysclk;
	wire audio_bck;
	wire audio_ws;
	wire audio_data;
	//wire [24:0] cnt;/////////////

	// Instantiate the Unit Under Test (UUT)
	speaker uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.audio_appsel(audio_appsel), 
		.audio_sysclk(audio_sysclk), 
		.audio_bck(audio_bck), 
		.audio_ws(audio_ws), 
		.audio_data(audio_data)
		//.cnt(cnt)/////////////
	);
	
	
	always #25 clk=~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst_n = 0;

		// Wait 100 ns for global reset to finish
		#100 rst_n=1;
        
		  
		// Add stimulus here

	end
      
endmodule

