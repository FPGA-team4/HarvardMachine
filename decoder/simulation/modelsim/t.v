
`timescale 1ns / 1ns
module t  ; 
 
  wire  [4:0]  OpecodeOutput   ; 
  reg    ClockInput   ; 
  wire    ClockOutput   ; 
  wire  AccReadFlag   ; 
  reg  [15:0]  OperandInput   ; 
  reg    AddressingModeInput   ; 
  wire  [15:0]  OperandOutput   ; 
  wire  [2:0]  OutputSelector   ; 
  reg  [4:0]  OpecodeInput   ; 
  DECODER  
   DUT  ( 
       .OpecodeOutput (OpecodeOutput ) ,
      .ClockInput (ClockInput ) ,
      .ClockOutput (ClockOutput ) ,
      .AccReadFlag (AccReadFlag ) ,
      .OperandInput (OperandInput ) ,
      .AddressingModeInput (AddressingModeInput ) ,
      .OperandOutput (OperandOutput ) ,
      .OutputSelector (OutputSelector ) ,
      .OpecodeInput (OpecodeInput ) ); 



// "Clock Pattern" : dutyCycle = 50
// Start Time = 0 ns, End Time = 1 us, Period = 100 ns
  initial
  begin
	  ClockInput  = 1'b0  ;
	 # 50 ;
// 50 ns, single loop till start period.
   repeat(9)
   begin
	   ClockInput  = 1'b1  ;
	  #50  ClockInput  = 1'b0  ;
	  #50 ;
// 950 ns, repeat pattern in loop.
   end
	  ClockInput  = 1'b1  ;
	 # 50 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  OpecodeInput  = 5'b00011  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  AddressingModeInput  = 1'b0  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  OperandInput  = 16'b0000000000000000  ;
	 # 1000 ;
// dumped values till 1 us
  end

  initial
	#2000 $stop;
endmodule
