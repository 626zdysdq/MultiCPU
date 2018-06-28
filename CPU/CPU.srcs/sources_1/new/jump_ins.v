module jump_ins(
	input [31:0] PC4,
	input [25:0] addr,
	output reg [31:0] JumpPC
);
	initial JumpPC<=0;
	always@(addr or PC4) begin
		JumpPC[1:0]=2'b00;
		JumpPC[27:2]=addr[25:0];
		JumpPC[31:28]=PC4[31:28];
	end
endmodule