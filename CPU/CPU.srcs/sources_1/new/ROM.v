`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/05 10:41:04
// Design Name: 
// Module Name: ROM
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


module ROM(
    input rd,                   
    input [31:0] addr,
    output reg [31:0] dataOut
    );
    
     reg [7:0] mem [0:99];   
     
     initial begin
         $readmemb ("E:/Xilinx/workbench/Multi_period_cpu/test.txt", mem); 
        dataOut<=0;
      end   
     always @( addr or rd)
         begin
             dataOut[7:0] = mem[addr + 3];
             dataOut[15:8] = mem[addr + 2];
             dataOut[23:16] = mem[addr + 1];
             dataOut[31:24] = mem[addr];
         end 
endmodule
