module ExtendSa(
	input [4:0] sa,
	output [31:0] extendedSa
);
	assign extendedSa[31:5]=0;
	assign extendedSa[4:0]=sa;
	
endmodule