`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:04:03 09/09/2015 
// Design Name: 
// Module Name:    speak 
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
module speak(
    clk,
	 rst_n,
	 Do,
	 Re,
	 Mi,
	 loud,
	 quiet,
	 audio_appsel,
	 audio_sysclk,
	 audio_bck,
	 audio_ws,
	 audio_data,
	 LED,
	 ftsd_ctl,
	 display
	 );

input clk;
input rst_n;
input Do;
input Re;
input Mi;
input loud;//button to turn volume up 
input quiet;//button to turn volume down
output audio_appsel;
output audio_sysclk;
output audio_bck;
output audio_ws;
output audio_data;
output [15:0] LED;
output [3:0] ftsd_ctl;
output [14:0] display;


wire [1:0] clk_ctl;
wire clk_150;
wire [14:0] cnt_l;
wire [5:0] cnt_h;
reg [19:0] note_div;
wire loud_debounced;
wire quiet_debounced;
wire [15:0] audio_left;
wire [15:0] audio_right;
wire [3:0] level1;
wire [3:0] level0;
wire [3:0] ftsd_in;



always@(*)
begin
	if(~Do)
	begin
		note_div=20'd76628;
	end
	else if(~Re)
	begin
		note_div=20'd68259;
	end
	else if(~Mi)
	begin
		note_div=20'd60606;
	end
	else
	begin
		note_div=20'd0;
	end
end




freq_div f1(
	.clk_ctl(clk_ctl),
	.clk_150(clk_150),
	.cnt_l(cnt_l),
	.cnt_h(cnt_h),
	.clk(clk),
	.rst_n(rst_n)
	);


debounce d1(
    .clk_150(clk_150),
	 .rst_n(rst_n),
	 .pb_in(loud),
	 .pb_debounced(loud_debounced)
	 );


debounce d2(
    .clk_150(clk_150),
	 .rst_n(rst_n),
	 .pb_in(quiet),
	 .pb_debounced(quiet_debounced)
	 );


buzzer_control b1(
    .clk(clk),
	 .rst_n(rst_n),
	 .cnt_h(cnt_h),///////////////////
	 .loud_press(loud_debounced),
	 .quiet_press(quiet_debounced),
	 .note_div(note_div),
	 .audio_left(audio_left),
	 .audio_right(audio_right),
	 .LED(LED),
	 .level1(level1),
	 .level0(level0)
	 );



speak_ctl s1(
    .clk(clk),
	 .rst_n(rst_n),
	 .audio_left(audio_left),
	 .audio_right(audio_right),
	 .cnt_l(cnt_l),
	 .audio_appsel(audio_appsel),
	 .audio_sysclk(audio_sysclk),
	 .audio_bck(audio_bck),
	 .audio_ws(audio_ws),
	 .audio_data(audio_data)
	 );



scan_ctl sc1(
	.ftsd_ctl(ftsd_ctl),
	.ftsd_in(ftsd_in),
	.in0(4'd0),
	.in1(4'd0),
	.in2(level1),
	.in3(level0),
	.ftsd_ctl_en(clk_ctl)
    );



bcd2ftsegdec bcd1(
	.display(display),
	.bcd(ftsd_in)
    );


endmodule
