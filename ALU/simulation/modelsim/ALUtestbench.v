
`timescale 1ns / 1ns
module ALUtestbench  ; 
 
  reg    clkInput   ; 
  reg  [2:0]  OutputSelectorInput   ; 
  reg  [15:0]  AccumulatorReadInput   ; 
  wire  [15:0]  AccumulatorWriteOutput   ; 
  reg  [15:0]  DataReadInput   ; 
  wire  [15:0]  DataWriteOutput   ; 
  wire  [15:0]  OutputBinaryOutput   ; 
  reg  [4:0]  OperandInput   ; 
  wire  [7:0]  ProgramCounterOutput   ; 
  reg    ConditionFlagReadInput   ; 
  wire  	ConditionFlagWriteOutput   ; 
  wire   EndFlagWriteOutput   ; 
  ALU  
   DUT  ( 
       .clkInput (clkInput ) ,
      .OutputSelectorInput (OutputSelectorInput ) ,
      .AccumulatorReadInput (AccumulatorReadInput ) ,
      .AccumulatorWriteOutput (AccumulatorWriteOutput ) ,
      .DataReadInput (DataReadInput ) ,
      .DataWriteOutput (DataWriteOutput ) ,
      .OutputBinaryOutput (OutputBinaryOutput ) ,
      .OperandInput (OperandInput ) ,
      .ProgramCounterOutput (ProgramCounterOutput ) ,
      .ConditionFlagReadInput (ConditionFlagReadInput ) ,
      .ConditionFlagWriteOutput (ConditionFlagWriteOutput ) ,
      .EndFlagWriteOutput (EndFlagWriteOutput ) ); 



// "Clock Pattern" : dutyCycle = 50
// Start Time = 0 ns, End Time = 1 us, Period = 100 ns
  initial
  begin
	  clkInput  = 1'b0  ;
	 # 50 ;
// 50 ns, single loop till start period.
   repeat(9)
   begin
	   clkInput  = 1'b1  ;
	  #50  clkInput  = 1'b0  ;
	  #50 ;
// 950 ns, repeat pattern in loop.
   end
	  clkInput  = 1'b1  ;
	 # 50 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  ConditionFlagReadInput  = 1'b0  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  OperandInput  = 5'b10000  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  OutputSelectorInput  = 3'b001  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  AccumulatorReadInput  = 16'b0000000000001111  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  DataReadInput  = 16'b0000000000000001  ;
	 # 1000 ;
// dumped values till 1 us
  end

  initial
	#2000 $stop;
endmodule
