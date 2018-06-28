module select_for_WriteReg(
	input [4:0] input31,
	input [4:0] rt,
	input [4:0] rd,
	input [1:0] RegDst,
	output reg [4:0] WriteReg
);
	always @(input31 or rt or rd or RegDst) begin
		case(RegDst)
			2'b00: WriteReg<=input31;
			2'b01: WriteReg<=rt;
			2'b10: WriteReg<=rd;
		endcase
	end
endmodule
