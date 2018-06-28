module NextPC(
	input [31:0] IAddr,
	input [31:0] PC4,
	input [31:0] SkipPC,
	input [31:0] rs,
	input [31:0] JumpPC,
	input [1:0] PCSrc,
	input isHalt,
	output reg [31:0] NextPC
);
	always@(PC4 or SkipPC or JumpPC or PCSrc or isHalt)begin
		if(isHalt==1)
			NextPC<=IAddr;
		else begin
			case(PCSrc)
				2'b00:NextPC<=PC4;
				2'b01:NextPC<=SkipPC;
				2'b10:NextPC<=rs;
				2'b11:NextPC<=JumpPC;
			endcase
		end
	end
endmodule