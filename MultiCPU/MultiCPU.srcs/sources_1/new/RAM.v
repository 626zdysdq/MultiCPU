`timescale 1ns / 1ps


module RAM(
        input clk,
        input [31:0] address,
        input [31:0] writeData, // [31:24], [23:16], [15:8], [7:0]
        input nRD,              
        input nWR,              
        output [31:0] Dataout
        );
        
        
        reg [7:0] RAM [0:31];
        integer i;
        initial 
        begin
            for(i = 0; i < 32; i = i+1) RAM[i] <= 0;
        end
        // è¯?
        assign Dataout[7:0]   = (nRD==0)?RAM[address + 3]:8'bz; 
        assign Dataout[15:8]  = (nRD==0)?RAM[address + 2]:8'bz;
        assign Dataout[23:16] = (nRD==0)?RAM[address + 1]:8'bz;
        assign Dataout[31:24] = (nRD==0)?RAM[address ]:8'bz;
        
        // å†?
        always@( negedge clk ) begin  
           if( nWR==0 ) begin    
               RAM[address]   <= writeData[31:24];
               RAM[address+1] <= writeData[23:16];
               RAM[address+2] <= writeData[15:8];
               RAM[address+3] <= writeData[7:0];
           end
        end
endmodule
