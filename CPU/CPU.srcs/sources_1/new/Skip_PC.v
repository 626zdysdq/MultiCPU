module Skip_PC(
	input [31:0] PC,
	input [31:0] ExtOut,
	output [31:0] SkipPC
);
	assign SkipPC=PC+(ExtOut<<2);
endmodule