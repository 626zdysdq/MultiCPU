`timescale 1ns / 1ps


module extend(
    input [15:0] datain,
    input ExtSel,
    output reg [31:0] result
    );
    always@(datain or ExtSel) begin
        result[15:0]<=datain[15:0];//16位传入
        if(ExtSel==1 && datain[15]==1)
            result[31:16]<=16'b1111_1111_1111_1111;//扩展全为1，负数；
        else
            result[31:16]=0;//扩展全部为0
    end
endmodule
