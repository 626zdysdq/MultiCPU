`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 10:17:44
// Design Name: 
// Module Name: scan
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

module scan(
    input clk,
    input clk_1khz,
    output wire [3:0] select//ѡλ
    );
    reg [1:0] t;
    initial t = 0;
    
    assign select[0] = (t == 2'b00)? 0: 1;
    assign select[1] = (t == 2'b01)? 0: 1;
    assign select[2] = (t == 2'b10)? 0: 1;
    assign select[3] = (t == 2'b11)? 0: 1;
    
    always@(negedge clk)
    begin
        if(clk_1khz == 1) t <= t + 1;
    end
endmodule
