`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 01:26:50
// Design Name: 
// Module Name: sim_cpu
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


module sim_cpu(
    );
    reg clk;
    reg handle_clk0;
    reg reset0;
    reg [2:0] mode;
    //output    
    wire [6:0] segment;
    wire [3:0] select;
        
cpu_top_control ctc(clk,reset0,mode,handle_clk0,segment,select);

    
initial begin
    clk = 0;
    handle_clk0 = 0;
    reset0 = 0;
    mode = 3'b000;

    #3; reset0 = 1;
    #3; reset0 = 0;
end

always #5 clk = ~clk;
always #2000 handle_clk0 = ~handle_clk0;//仿真周期 调小
always #500 mode = mode + 1;   
    
endmodule
