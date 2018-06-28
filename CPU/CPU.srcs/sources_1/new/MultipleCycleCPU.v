module MultipleCycleCPU(
	input CLK,
	input reset,
	output [31:0] curPC,
	output [31:0] nextPC,
	output [31:0] ReadData1,
	output [31:0] ReadData2,
	output [4:0] rs,
	output [4:0] rt,
	output [31:0] result,
	output [31:0] DataOut,
	output [2:0] state
);

	wire PCWre,InsMemRW,IRWre,sign,zero,ALUSrcA,ALUSrcB,DBDataSrc,RegWre,mRD,mWR,isHalt,ExtSel,WrRegDSrc;
	wire [1:0] RegDst,PCSrc;
	wire [2:0] ALUOp,State;
	wire [4:0] WriteReg;
	wire [31:0] readData1,readData2,Result,dataOut,NextPC,IAddr,address,InsOut,WriteData,PC4,DBDataIn,DBDataOut,Data1,Data2,ExtOut,ExtendSa,InA,InB,JumpPC,SkipPC,DAddr;
	wire [4:0] Reg31;
	
	assign Reg31=5'b11111;
	
	PC pc(CLK,reset,PCWre,NextPC,IAddr);
	
	ROM rom(InsMemRW,IAddr,address);

	InstructionRegister InReg(CLK,IRWre,address,InsOut);
	
	control_unit cu(zero,sign,reset,CLK,InsOut[31:26],RegDst,WrRegDSrc,InsMemRW,IRWre,PCWre,ExtSel,DBDataSrc,mWR,mRD,ALUSrcB,ALUSrcA,PCSrc,ALUOp,RegWre,isHalt,State);
	
	select_for_WriteReg select_2_5(Reg31,InsOut[20:16],InsOut[15:11],RegDst,WriteReg);
	
	PC_add_four pc_4(IAddr,PC4);
	
	select_for_WriteData selectWriteData(PC4,DBDataOut,WrRegDSrc,WriteData);//(PC4,DBDataOut,WrRegDSrc,WriteData);
	
	RegFile regfile(CLK,reset,RegWre,InsOut[25:21],InsOut[20:16],WriteReg,WriteData,readData1,readData2);
	
	extend_unit eu(InsOut[15:0],ExtSel,ExtOut);
	
	DataRegister ADR(CLK,readData1,Data1);
	
	DataRegister BDR(CLK,readData2,Data2);
	
	ExtendSa exsa(InsOut[10:6],ExtendSa);
	
	select selectA(Data1,ExtendSa,ALUSrcA,InA);
	
	select selectB(Data2,ExtOut,ALUSrcB,InB);
	
	ALU alu(ALUOp,InA,InB,sign,zero,Result);
	
	DataRegister ALUOut(CLK,Result,DAddr);
	
	RAM ram(CLK,DAddr,Data2,mRD,mWR,dataOut);
	
	select DBDataSelect(Result,dataOut,DBDataSrc,DBDataIn);
	
	DataRegister DBDR(CLK,DBDataIn,DBDataOut);
	
	jump_ins ji(PC4,InsOut[25:0],JumpPC);
	
	Skip_PC sp(PC4,ExtOut,SkipPC);
	
	select4_1 selectNextPC(IAddr,PC4,SkipPC,readData1,JumpPC,PCSrc,isHalt,NextPC);
	
	assign curPC=IAddr;
	assign nextPC=NextPC;
	assign ReadData1=readData1;
	assign ReadData2=readData2;
	assign rs=InsOut[25:21];
	assign rt=InsOut[20:16];
	assign result=Result;
	assign DataOut=dataOut;
	assign state=State;

endmodule
	