module DECODER(
	input wire			ClockInput,
	input wire[4:0] 	OpecodeInput,
	input wire 			AddressingModeInput,
	input wire[15:0]	OperandInput,
	
	output reg[4:0]	OpecodeOutput,
	output reg[2:0]	OutputSelectorOutput,
	output reg			AccReadFlagOutput,
	output reg[15:0]	OperandOutput,
	
	output wire			ClockOutput
);

	wire a,b,c,d,e;//cf. https://gist.github.com/Mackyson/8fa794797c2ad5771a0d5a1603667397
	assign a = OpecodeInput[4];
	assign b = OpecodeInput[3];
	assign c = OpecodeInput[2];
	assign d = OpecodeInput[1];
	assign e = OpecodeInput[0];

	always @(posedge ClockInput) begin
		OpecodeOutput[4:0] <= OpecodeInput[4:0];
		
		OutputSelectorOutput[2] <= (~a & ~b & ~c & ~d & e);
		OutputSelectorOutput[1] <= ((~a & ~b & ~c & d & e) | (~a & b &c));
		OutputSelectorOutput[0] <= ((a & ~b) | (~b & ~c & d));
		
		AccReadFlagOutput <= ((~a & b & ~c & ~d) | (~b & ~c & d & e) | (a & ~b));
		
		OperandOutput[15:0] <= OperandInput[15:0];
	end
	
endmodule