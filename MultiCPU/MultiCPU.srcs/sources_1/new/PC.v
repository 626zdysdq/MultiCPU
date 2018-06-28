module PC(
	input CLK,
	input RST,
	input [31:0] NextPC,
	input PCWre,
	output reg [31:0] IAddr
);
	initial IAddr<=0;
	always @(posedge CLK or negedge RST) begin 
		if(RST==0) IAddr<=0;
		else if(PCWre)  IAddr<=NextPC;
		else IAddr<=IAddr;
	end
endmodule