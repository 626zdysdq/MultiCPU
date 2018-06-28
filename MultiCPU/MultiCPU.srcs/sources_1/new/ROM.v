`timescale 1ns / 1ps
module ROM(
    input InsMemRW,                   
    input [31:0] IAddr,
    output reg [31:0] IDataOut
    );
    
     reg [7:0] mem [0:99];   
     
     initial begin
         $readmemb ("C:/Users/zhuduoyu/MultiCPU/test.txt", mem); 
        IDataOut<=0;
      end   
     always @(InsMemRW or IAddr)
         begin
             IDataOut[7:0] = mem[IAddr + 3];
             IDataOut[15:8] = mem[IAddr + 2];
             IDataOut[23:16] = mem[IAddr + 1];
             IDataOut[31:24] = mem[IAddr];
         end 
endmodule
