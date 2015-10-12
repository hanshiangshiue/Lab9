`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:47 08/20/2015 
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
module debounce(
    clk_150,
	 rst_n,
	 pb_in,
	 pb_debounced
	 );


input clk_150;
input rst_n;
input pb_in;
output pb_debounced;
reg pb_debounced;

reg [3:0] debounce_window;
reg pb_debounced_next;


always@(posedge clk_150 or negedge rst_n)
begin
	if(~rst_n)
		debounce_window<=4'd0;
	else
		debounce_window<={debounce_window[2:0],~pb_in};
end


always@(debounce_window)
begin
	if(debounce_window==4'b1111)
		pb_debounced_next=1'b1;
	else
		pb_debounced_next=1'b0;
end


always@(posedge clk_150 or negedge rst_n)
begin
	if(~rst_n)
		pb_debounced<=1'b0;
	else
		pb_debounced<=pb_debounced_next;
end




endmodule
