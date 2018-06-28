`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/05 11:11:44
// Design Name: 
// Module Name: extend_unit
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


module extend_unit(
    input [15:0] datain,
    input ExtSel,
    output reg [31:0] result
    );
    always@(datain or ExtSel) begin
        result[15:0]<=datain[15:0];//16λ����
        if(ExtSel==1 && datain[15]==1)
            result[31:16]<=16'b1111_1111_1111_1111;//��չȫΪ1��������
        else
            result[31:16]=0;//��չȫ��Ϊ0
    end
endmodule
