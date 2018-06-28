module IR(
	input CLK,
	input IRWre,
	input [31:0] DataOut,
	output reg [31:0] InsOut
);
	
	reg [31:0] Ins_Register;
	initial Ins_Register=0;//initial the ins data=0
	
	always @(negedge CLK) begin
		if(IRWre==1)//write
			Ins_Register<=DataOut;
		else
			Ins_Register<=Ins_Register;
	end
	
	always @(posedge CLK) begin//read
		InsOut<=Ins_Register;
	end
	
endmodule	