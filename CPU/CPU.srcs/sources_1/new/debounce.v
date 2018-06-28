`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 10:15:59
// Design Name: 
// Module Name: debounce
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

module debounce(
input inp,
input clk,
output reg outp
);
reg [19:0] delay;
initial delay = 0;
always @ (negedge clk)
begin
    if(delay == 20'b1111_0100_0010_0000) //20ms
    begin
        delay <= 0;
        outp <= inp;
    end
    else
    begin
        delay <= delay + 1;
    end
    
end
endmodule
