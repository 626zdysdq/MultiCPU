module PC(
	input CLK,
	input RST,
	input PCWre,
	input [31:0] PC_in,
	output reg [31:0] PC_out
);
	initial PC_out<=0;
	always @(posedge CLK or negedge RST) begin//pc start change at posedge
		if(RST==0) PC_out<=0;
		else if(PCWre)  PC_out<=PC_in;
		else PC_out<=PC_out;
	end
endmodule