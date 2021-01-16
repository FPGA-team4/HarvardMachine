module ALU(
	input 					clkInput,
	input 					ConditionFlagReadInput,
	input			[4:0]		OperandInput,
	input 		[2:0]		OutputSelectorInput,
	input 		[15:0]	AccumulatorReadInput,
	input 		[15:0]	DataReadInput,

	output reg 				ConditionFlagWriteOutput,
	output reg	 			EndFlagWriteOutput,
	output reg	[7:0]		ProgramCounterOutput,
	output reg	[15:0]	AccumulatorWriteOutput,
	output reg	[15:0]	DataWriteOutput,
	output reg	[15:0]	OutputBinaryOutput
);
    
	reg	[15:0]	result;		//演算結果の保存線
	reg				ALUState;	//ALUの状態
	wire				calcConditionFlagWrite, calcEndFlagWrite;													//calcとselecの結果を保存
	wire	[15:0]	calcResult, selecAccumulatorWrite, selecDataWrite, selecOutputBinary;
	wire	[7:0]		selecProgramCounter;
	
	//初期化
	initial begin
		ALUState = 1'b0;
	end
	
	Calculator calc(OperandInput, ConditionFlagReadInput, AccumulatorReadInput, DataReadInput, calcConditionFlagWrite, calcEndFlagWrite, calcResult);	//演算
	Selector selec(result, OutputSelectorInput, selecProgramCounter, selecAccumulatorWrite, selecDataWrite, selecOutputBinary);	//出力選択
	
	//演算と出力
	always @(posedge clkInput) begin
		case(ALUState)
			1'b0:	begin
						ConditionFlagWriteOutput	<=	calcConditionFlagWrite;
						EndFlagWriteOutput			<=	calcEndFlagWrite;
						result							<=	calcResult;							//calcの出力を反映
					end
			1'b1:	begin
						ProgramCounterOutput			<=	selecProgramCounter;
						AccumulatorWriteOutput		<=	selecAccumulatorWrite;
						DataWriteOutput				<=	selecDataWrite;
						OutputBinaryOutput			<=	selecOutputBinary;				//selecの出力を反映
					end
			default:	;
		endcase
	end
	
	//状態選択
	always@(posedge clkInput) begin
		case(ALUState)
			1'b0: ALUState <= 1'b1;
			1'b1: ALUState <= 1'b0;
			default: ALUState <= 1'b0;
		endcase
	end
endmodule


//演算モジュール
module Calculator(Operand, ConditionFlagRead, AccumulatorRead, DataRead, ConditionFlagWrite, EndFlagWrite, result);
	input		[4:0] 	Operand;
	input					ConditionFlagRead;
	input		[15:0]	AccumulatorRead;
	input		[15:0]	DataRead;
	output				ConditionFlagWrite;
	output				EndFlagWrite;
	output	[15:0]	result;

	reg	[15:0]	interResult;
	reg				interConditionFlagWrite, interEndFlagWrite;	//このモジュールの出力result，CFW，EFWに代入する前にcase文内で間にかませる線
	wire	[15:0]	resultMul, resultDiv, resultMod;			//モジュールMUL，DIV，MODの結果を入れる線
	
	MUL mul(.dataa(AccumulatorRead), .datab(DataRead), .result(resultMul));		//掛け算
	DIV div(.denom(DataRead), .numer(AccumulatorRead), .quotient(resultDiv));	//除算
	DIV mod(.denom(DataRead), .numer(AccumulatorRead), .remain(resultMod));		//余算
	
	always @(*) begin
		case(Operand)
			5'b00000:	interResult <= 16'b0000000000000000;										//NOP
			5'b00001:	interResult <= DataRead;														//PRINT
			5'b00010:	interResult <= AccumulatorRead;												//LOAD
			5'b00011:	interResult <= DataRead;														//STORE
			5'b00100:	interEndFlagWrite <= 1'b1;														//EOP
			5'b01000:	interConditionFlagWrite <= $signed(AccumulatorRead) < $signed(DataRead);				//LT
			5'b01001:	interConditionFlagWrite <= $signed(AccumulatorRead) > $signed(DataRead);				//GT
			5'b01100:	interResult <= DataRead;														//JUMP
			5'b01101:	if(ConditionFlagRead)															//BEQ
								interResult <= DataRead;
			5'b01110:	if(!ConditionFlagRead)															//BNE
								interResult <= DataRead;
			5'b10000:	interResult <= $signed(AccumulatorRead) + $signed(DataRead);		//ADD
			5'b10001:	interResult <= AccumulatorRead - DataRead;								//SUB
			5'b10010:	interResult <= resultMul;														//MUL
			5'b10011:	interResult <= resultDiv;														//DIV
			5'b10100:	interResult <= resultMod;														//MOD
			5'b10101:	interResult <= ~AccumulatorRead;												//NOT
			5'b10110:	interResult <= AccumulatorRead | DataRead;								//OR
			5'b10111:	interResult <= AccumulatorRead & DataRead;								//AND
			default:		interResult <= 16'b0000000000000000;										//others
		endcase
	end
	
	assign result = interResult;
	assign EndFlagWrite = interEndFlagWrite;
	assign ConditionFlagWrite = interConditionFlagWrite;
endmodule


//出力選択モジュール
module Selector(result, OutputSelector, ProgramCounter, AccumulatorWrite, DataWrite, OutputBinary);
	input				[15:0] 	result;
	input				[2:0]		OutputSelector;
	output	reg	[7:0]		ProgramCounter;
	output	reg	[15:0]	AccumulatorWrite;
	output	reg	[15:0]	DataWrite;
	output	reg	[15:0]	OutputBinary;

	always @(*) begin
	 	case(OutputSelector)
			3'b000:	;											//無
			3'b001:	AccumulatorWrite <= result;		//ACC
			3'b010:	ProgramCounter <= result[7:0];	//PC
			3'b011:	DataWrite <= result;					//メモリ
			3'b100:	OutputBinary <= result;				//7セグ
			default:	;											//others
		endcase
	 end
endmodule