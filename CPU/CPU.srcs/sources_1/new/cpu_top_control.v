`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/18 10:21:04
// Design Name: 
// Module Name: cpu_top_control
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


module cpu_top_control(
    input clk,
    input reset0,
    input [2:0] mode,
    input handle_clk,
    output [6:0] segment,
    output [3:0] select
    );
    
    wire handle_clk0,reset,clk_1khz;
    wire [7:0] output1,output2;
    wire [31:0] curPC,nextPC,ReadData1,ReadData2,result,DataOut;
    wire [4:0] rs,rt;
    wire [2:0] state;
    
    debounce db1(handle_clk,clk,handle_clk0);//handle_clk shake
    debounce db2(reset0,clk,reset);
    div di(clk,clk_1khz);
    scan sc(clk,clk_1khz,select);
    show s(clk,select,output1,output2,segment);
    MultipleCycleCPU m(handle_clk0,reset0,curPC,nextPC,ReadData1,ReadData2,rs,rt,result,DataOut,state);
    show_mode sm(clk,mode,curPC,nextPC,rs,ReadData1,rt,ReadData2,result,DataOut,state,output1,output2);
    
endmodule
