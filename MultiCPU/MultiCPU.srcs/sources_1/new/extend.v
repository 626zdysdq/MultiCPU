`timescale 1ns / 1ps


module extend(
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
