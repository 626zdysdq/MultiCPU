module PC_add_four(
	input [31:0] PC,
	output [31:0] PC4
);
	assign PC4=PC+4;
endmodule