module DECODER(
	input wire			ClockInput,
	input wire[21:0]	InstructionInput,
//	input wire[4:0] 	OpecodeInput,
//	input wire 			AddressingModeInput,
//	input wire[15:0]	OperandInput,
	
	output reg[4:0]	OpecodeOutput,
	output reg 			AddressingModeOutput,
	output reg[15:0]	OperandOutput,
	
	output reg[2:0]	OutputSelectorOutput,
	output reg			AccReadFlagOutput
);
	wire[4:0] opecodeInput;
	wire addressingModeInput;
	wire[15:0] operandInput;

	assign opecodeInput = InstructionInput[21:17];
	assign addressingModeInput = InstructionInput[16];
	assign operandInput = InstructionInput[15:0];
	
	wire a,b,c,d,e;//cf. https://gist.github.com/Mackyson/8fa794797c2ad5771a0d5a1603667397
	
	assign a = opecodeInput[4];
	assign b = opecodeInput[3];
	assign c = opecodeInput[2];
	assign d = opecodeInput[1];
	assign e = opecodeInput[0];

	always @(posedge ClockInput) begin
	
		
		OpecodeOutput[4:0] <= opecodeInput[4:0];
		AddressingModeOutput <= addressingModeInput;
		
		OutputSelectorOutput[2] <= (~a & ~b & ~c & ~d & e);
		OutputSelectorOutput[1] <= ((~a & ~b & ~c & d & e) | (~a & b &c));
		OutputSelectorOutput[0] <= ((a & ~b) | (~b & ~c & d));
		
		AccReadFlagOutput <= ((~a & b & ~c & ~d) | (~b & ~c & d & e) | (a & ~b));
		
		OperandOutput[15:0] <= operandInput[15:0];
	end
	
endmodule