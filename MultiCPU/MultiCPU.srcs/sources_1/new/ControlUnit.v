module ControlUnit(
	input zero,
	input sign,
	input RST,
	input CLK,
	input [5:0] opcode,
	output reg [1:0] RegDst,
	output reg WrRegDSrc,
	output reg InsMemRW,
	output reg IRWre,
	output reg PCWre,
	output reg ExtSel,
	output reg DBDataSrc,
	output reg mWR,
	output reg mRD,
	output reg ALUSrcB,
	output reg ALUSrcA,
	output reg [1:0] PCSrc,
	output reg [2:0] ALUOp,
	output reg RegWre,
	
	output reg isHalt,
	output reg [2:0] state
	
);

	initial begin
		state=3'b000;
		PCWre=1;
		ALUSrcA=0;
		ALUSrcB=0;
		DBDataSrc=0;
		RegWre=1;
		InsMemRW=0;
		mRD=1;
		mWR=1;
		RegDst=2'b00;
		ALUOp=3'b000;
		IRWre=0;
		WrRegDSrc=1;
		isHalt=0;
		ExtSel=0;
		PCSrc=2'b00;
	end
	
	always@(posedge CLK or negedge RST)begin//on posedge set state ,D chufaqi
		if(RST==0)begin
			state<=3'b000;
			isHalt<=0;
		end
		else begin
		
			if(state==3'b000) //next state 000->001
				state<=3'b001;
			else if(state==3'b001) begin//in state 001 
				if((opcode==6'b111000)||(opcode==6'b111001)||(opcode==6'b111010)||(opcode==6'b111111))// j jr jal halt
					state<=3'b000;
				else state<=3'b010;   //if not j jr jal halt then next is 010
			end
			else if(state==3'b010)begin
				if((opcode==6'b110100)||(opcode==6'b110110))//beq bltz
					state<=3'b000;
				else if((opcode==6'b110000)||(opcode==6'b110001))//sw lw
					state<=3'b100;
				else state<=3'b011;//next
			end
			else if(state==3'b100) begin//sMEM
				if(opcode==6'b110001) state<=3'b011;
				else state<=3'b000;
			end
			else//else
				state<=3'b000;
		end
	end
	
	always@(RST or state or zero or opcode or sign)begin
	
		//ALUSrcA
		if((state==3'b010||state==3'b011) && opcode==6'b011000)//var ALUSrcA,only in sll and in state sEXE
			ALUSrcA=1;
		else 
			ALUSrcA=0;
			
		//ALUSrcB
		if(state==3'b010) begin//in sEXE
			if((opcode==6'b000010)||(opcode==6'b010010)||(opcode==6'b100111)||//addi ori sltiu
			(opcode==6'b110000)||(opcode==6'b110001))//sw lw
				ALUSrcB=1;
			else
				ALUSrcB=0;		
		end
	    else
			ALUSrcB=0;
						
		//DBDataSrc
		if(state==3'b100&&opcode==6'b110001)//lw sMEM
			DBDataSrc=1;
		else
			DBDataSrc=0;
			
		//RegWre
		if(state==3'b011) RegWre=1;//通过011的所有指�??
		else if(state==3'b001&&opcode==6'b111010)RegWre=1; //jal
		else RegWre=0;
		
		//WrRegDSrc
		if(state==3'b001&&opcode==6'b111010)WrRegDSrc=0;
		else WrRegDSrc=1;
		
		//InsMemRW
		
		//mRD
		if(state==3'b100&&opcode==6'b110001)mRD=0;
		else mRD=1;
		
		//mWR
		if(state==3'b100&&opcode==6'b110000)mWR=0;
		else mWR=1;
		
		//IRWre
		if(state==3'b000) IRWre=1;//000 to load pc
		else IRWre=0;

		//ExtSel
		if(state==3'b010)begin
			if((opcode==6'b000010)||(opcode==6'b110000)||(opcode==6'b110001)||(opcode==6'b110100)||(opcode==6'b110110))ExtSel=1;
			else ExtSel=0;			
		end
		else ExtSel=0;
			
		//PCSrc
		if(state==3'b001)begin
			if((opcode==6'b111000)||(opcode==6'b111010))PCSrc=2'b11;//j jal
			else if(opcode==6'b111001)PCSrc=2'b10;//jr
			else if(opcode==6'b111111)PCSrc=2'bz;
			else PCSrc=2'b00;
		end
		else if(state==3'b010)begin
			if((opcode==6'b110100&&zero==1)||(opcode==6'b110110&&zero==0&&sign==1))PCSrc=2'b01;//beq bltz
			else PCSrc=2'b00;
		end
		else PCSrc=2'b00;
		
		//RegDst
		if(state==3'b001&&opcode==6'b111010)RegDst=2'b00;
		else if(state==3'b011) begin
			if((opcode==6'b000010)||(opcode==6'b010010)||(opcode==6'b100111)||(opcode==6'b110001)) RegDst=2'b01;//addi ori sltiu lw
			else RegDst=2'b10;
		end
		else RegDst=2'b10;
		
		//ALUOp
		if(state==3'b010)begin
			if(opcode==6'b000001)ALUOp=3'b001;//sub alu is -
			else if((opcode==6'b010000)||(opcode==6'b010010))ALUOp=3'b101;//or ori alu is |
			else if(opcode==6'b010001)ALUOp=3'b110;//and alu is &
			else if(opcode==6'b011000)ALUOp=3'b100;//sll alu is <<
			else if(opcode==6'b100110)ALUOp=3'b011;//slt alu is compare_with_sign
			else if(opcode==6'b100111)ALUOp=3'b010;//sltiu alu is no sign compare
			else if((opcode==6'b110100)||(opcode==6'b110110))ALUOp=3'b111;//beq bltz
			else ALUOp=3'b000;
		end
		else ALUOp=3'b000;
		
		//isHalt
		if(opcode==6'b111111)isHalt=1;
		else isHalt=0;
		
		
	end
	
	always@(negedge CLK) begin//next state wheather pc can write
		if(state==3'b001)begin
			if((opcode==6'b111000)||(opcode==6'b111001)||(opcode==6'b111010))PCWre<=1;//j jal jr 
			else PCWre<=0;
		end
		else if(state==3'b010)begin
			if((opcode==6'b110100)||(opcode==6'b110110))PCWre<=1;//beq bltz
			else PCWre<=0;
		end
		else if(state==3'b100)begin
			if(opcode==6'b110000)PCWre<=1;
			else PCWre<=0;
		end
		else if(state==3'b011)PCWre<=1;
		else PCWre<=0;
	end
endmodule