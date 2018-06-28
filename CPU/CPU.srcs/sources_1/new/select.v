module select(
	input [31:0] Data1,
	input [31:0] Data2,
	input control,
	output [31:0] OutData
);
	assign OutData=control?Data2:Data1;
endmodule