`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:39 09/04/2015 
// Design Name: 
// Module Name:    buzzer_control 
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
module buzzer_control(
    clk,
	 rst_n,
	 cnt_h,//////////////
	 loud_press,
	 quiet_press,
	 note_div,
	 audio_left,
	 audio_right,
	 LED,
	 level1,
	 level0
	 );

input clk;
input rst_n;
input [5:0] cnt_h;/////////////////////////
input [19:0] note_div;//div for note generation
input loud_press;
input quiet_press;
output [15:0] audio_left;//left sound audio
output [15:0] audio_right;//right sound audio
output [15:0] LED;
output [3:0] level1;
output [3:0] level0;

reg [19:0] clk_cnt;
reg [19:0] clk_cnt_next;
reg b_clk;
reg b_clk_next;
wire [15:0] audio_left;
wire [15:0] audio_right;
reg [15:0] LED;
reg [15:0] LED_tmp;
reg [3:0] level1;
reg [3:0] level1_tmp;
reg [3:0] level0;
reg [3:0] level0_tmp;
reg [3:0] level;
reg [3:0] level_tmp;
reg [15:0] volume;
reg [15:0] volume_tmp;



always@(*)
begin
	if(loud_press && ~(LED==16'hFFFF))
	begin
		volume_tmp=volume+16'h0500;
		LED_tmp={1'b1,LED[15:1]};
		level_tmp=level+1'b1;
	end
	else if(quiet_press && ~(LED==16'h8000))
	begin
		volume_tmp=volume-16'h0500;
		LED_tmp={LED[14:0],1'b0};
		level_tmp=level-1'b1;
	end
	else
	begin
		volume_tmp=volume;
		LED_tmp=LED;
		level_tmp=level;
	end
end



always@(posedge cnt_h[4] or negedge rst_n)//這邊clock要注意 太快會掃錯 因為沒有做one_pulse(想要繼續按著也能增強音量)
begin
	if(~rst_n)
	begin
		volume<=16'h3FFF;
		LED<=16'hFFFF;
		level<=4'd15;
	end
	else
	begin
		volume<=volume_tmp;
		LED<=LED_tmp;
		level<=level_tmp;
	end
end



always@(*)
begin
	case(level)
	4'd0:
	begin
		level1=4'd0;
		level0=4'd1;
	end
	4'd1:
	begin
		level1=4'd0;
		level0=4'd2;
	end
	4'd2:
	begin
		level1=4'd0;
		level0=4'd3;
	end
	4'd3:
	begin
		level1=4'd0;
		level0=4'd4;
	end
	4'd4:
	begin
		level1=4'd0;
		level0=4'd5;
	end
	4'd5:
	begin
		level1=4'd0;
		level0=4'd6;
	end
	4'd6:
	begin
		level1=4'd0;
		level0=4'd7;
	end
	4'd7:
	begin
		level1=4'd0;
		level0=4'd8;
	end
	4'd8:
	begin
		level1=4'd0;
		level0=4'd9;
	end
	4'd9:
	begin
		level1=4'd1;
		level0=4'd0;
	end
	4'd10:
	begin
		level1=4'd1;
		level0=4'd1;
	end
	4'd11:
	begin
		level1=4'd1;
		level0=4'd2;
	end
	4'd12:
	begin
		level1=4'd1;
		level0=4'd3;
	end
	4'd13:
	begin
		level1=4'd1;
		level0=4'd4;
	end
	4'd14:
	begin
		level1=4'd1;
		level0=4'd5;
	end
	4'd15:
	begin
		level1=4'd1;
		level0=4'd6;
	end
	default:
	begin
		level1=4'd0;
		level0=4'd0;
	end
	endcase
end




//note frequency generation
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		clk_cnt<=20'd0;
		b_clk<=1'b0;
	end
	else
	begin
		clk_cnt<=clk_cnt_next;
		b_clk<=b_clk_next;
	end
end



//note frequency generation
always@(*)
begin
	if(clk_cnt==note_div)
	begin
		clk_cnt_next=20'd0;
		b_clk_next=~b_clk;
	end
	else
	begin
		clk_cnt_next=clk_cnt+1'b1;
		b_clk_next=b_clk;
	end
end



//assign the amplitude of the note  差距越大越小聲 差距越小越大聲
assign audio_left=(b_clk==1'b0)?16'hF000:volume;
assign audio_right=(b_clk==1'b0)?16'hF000:volume;



endmodule
