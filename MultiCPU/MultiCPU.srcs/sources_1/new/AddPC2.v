module AddPC2(
	input [31:0] PC4,
	input [31:0] Extend_Out,
	output [31:0] NewPC
);
	assign NewPC=PC4+(Extend_Out<<2);
endmodule