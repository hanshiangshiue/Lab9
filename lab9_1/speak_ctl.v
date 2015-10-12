`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:59:36 09/09/2015 
// Design Name: 
// Module Name:    speak_ctl 
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
module speak_ctl(
    clk,
	 rst_n,
	 audio_left,
	 audio_right,
	 audio_appsel,
	 audio_sysclk,
	 audio_bck,
	 audio_ws,
	 audio_data
	 );


input clk;
input rst_n;
input [15:0] audio_left;
input [15:0] audio_right;
output audio_appsel;//sterio playing
output audio_sysclk;//40MHz
output audio_bck;//5MHz, bit clock of audio data   40MHz/(2^3)=5MHz
output audio_ws;//5/32MHz, stereo sampling clock   40MHz/(2^8)=5/32MHz
output audio_data;


reg [24:0] cnt;
reg [24:0] cnt_tmp;
reg [15:0] shift;
reg audio_data;
wire audio_appsel;
wire audio_sysclk;
wire audio_bck;
wire audio_ws;

assign audio_appsel=1'b1;
assign audio_sysclk=clk;
assign audio_bck=cnt[2];//40MHz/(2^3)=5MHz
assign audio_ws=cnt[7];//40MHz/(2^8)=5/32MHz



always@(*)
begin
	cnt_tmp=cnt+1'b1;
end



always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		cnt<=25'd0;
	else
		cnt<=cnt_tmp;
end



always@(posedge audio_bck or negedge rst_n)
begin
	if(~rst_n)
	begin
		shift<=16'b0;
	end
	else	
	begin
		if(audio_ws==1'b0)
		begin
			shift<=audio_left;
		end
		else
		begin
			shift<=audio_right;
		end
	end
end


//¶Ç°e¶¶§Ç:MSB -> LSB
always@(*)
begin
	case(cnt[6:3])
		4'd0: audio_data=shift[15];
		4'd1: audio_data=shift[14];
		4'd2: audio_data=shift[13];
		4'd3: audio_data=shift[12];
		4'd4: audio_data=shift[11];
		4'd5: audio_data=shift[10];
		4'd6: audio_data=shift[9];
		4'd7: audio_data=shift[8];
		4'd8: audio_data=shift[7];
		4'd9: audio_data=shift[6];
		4'd10: audio_data=shift[5];
		4'd11: audio_data=shift[4];
		4'd12: audio_data=shift[3];
		4'd13: audio_data=shift[2];
		4'd14: audio_data=shift[1];
		4'd15: audio_data=shift[0];
	endcase
end

endmodule
