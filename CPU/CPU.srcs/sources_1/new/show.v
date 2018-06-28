`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 10:18:36
// Design Name: 
// Module Name: show
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

module show(
    input clk,
    input [3:0] select,
    input [7:0] output1,
    input [7:0] output2,
    output [6:0] segment
    );
    
    reg [3:0] num;
    always@(negedge clk)
    begin
        case(select)
        4'b0111: num = output1[7:4];
        4'b1011: num = output1[3:0];
        4'b1101: num = output2[7:4];
        4'b1110: num = output2[3:0];
        default: num = 4'b0000;
        endcase
    end
    
    
    segment_show ss(
        .clk(clk),
        .num(num),
        .seg(segment)
        );
endmodule
