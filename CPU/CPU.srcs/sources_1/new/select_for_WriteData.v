module select_for_WriteData(
	input [31:0] PC4,
	input [31:0] DB,
	input WrRegDSrc,
	output [31:0] WriteData
);
    assign WriteData=WrRegDSrc?DB:PC4;
endmodule