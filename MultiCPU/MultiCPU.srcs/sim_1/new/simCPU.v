`timescale 1ns / 1ps


module simCPU();

	reg reset;
	reg clk;
	
	
	wire [31:0] curPC,nextPC,ReadData1,ReadData2;
	wire [4:0] rs,rt;
	wire [31:0] result,DataOut;
	wire [2:0] state;
	
	MultiCPU muticpu(clk,reset,curPC,nextPC,ReadData1,ReadData2,rs,rt,result,DataOut,state);
	
	initial
	begin
		clk=1;
		reset=1;
		#20 reset=0;
		#20 reset=1;
		
		forever #20 clk=~clk;
		#800 $stop;
		
	end
	
endmodule
