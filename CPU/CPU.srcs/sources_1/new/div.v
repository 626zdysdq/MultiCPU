`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 10:16:48
// Design Name: 
// Module Name: div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module div(
    input clk,
    output reg clk_1khz
    );
    reg [31:0] s;
    initial s = 0;
    always@(negedge clk)
    begin
        if(s == 99999) //ԭ 99999 Ϊ������棬��С���� ��СΪ 9
        begin
            clk_1khz <= 1;
            s <= 0;
        end
        else
        begin
            clk_1khz <= 0;
            s <= s + 1;
        end
    end
endmodule
