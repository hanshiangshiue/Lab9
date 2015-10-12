`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:32:59 09/09/2015 
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
module speaker(
    clk,
	 rst_n,
	 audio_appsel,
	 audio_sysclk,
	 audio_bck,
	 audio_ws,
	 audio_data
	 );
input clk;
input rst_n;
output audio_appsel;
output audio_sysclk;
output audio_bck;
output audio_ws;
output audio_data;
wire [15:0] audio_left;
wire [15:0] audio_right;


buzzer_control b1(
    .clk(clk),
	 .rst_n(rst_n),
	 .note_div(20'd76628),//40MHz/(76628*2)=261Hz
	 .audio_left(audio_left),
	 .audio_right(audio_right)
	 );



speak_ctl s1(
    .clk(clk),
	 .rst_n(rst_n),
	 .audio_left(audio_left),
	 .audio_right(audio_right),
	 .audio_appsel(audio_appsel),
	 .audio_sysclk(audio_sysclk),
	 .audio_bck(audio_bck),
	 .audio_ws(audio_ws),
	 .audio_data(audio_data)
	 );


endmodule
