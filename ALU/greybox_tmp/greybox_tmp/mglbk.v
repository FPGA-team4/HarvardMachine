//lpm_divide CBX_SINGLE_OUTPUT_FILE="ON" LPM_DREPRESENTATION="UNSIGNED" LPM_HINT="LPM_REMAINDERPOSITIVE=TRUE" LPM_NREPRESENTATION="SIGNED" LPM_TYPE="LPM_DIVIDE" LPM_WIDTHD=16 LPM_WIDTHN=16 denom numer quotient remain
//VERSION_BEGIN 20.1 cbx_mgl 2020:11:11:17:08:38:SJ cbx_stratixii 2020:11:11:17:06:46:SJ cbx_util_mgl 2020:11:11:17:06:46:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2020  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and any partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details, at
//  https://fpgasoftware.intel.com/eula.



//synthesis_resources = lpm_divide 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mglbk
	( 
	denom,
	numer,
	quotient,
	remain) /* synthesis synthesis_clearbox=1 */;
	input   [15:0]  denom;
	input   [15:0]  numer;
	output   [15:0]  quotient;
	output   [15:0]  remain;

	wire  [15:0]   wire_mgl_prim1_quotient;
	wire  [15:0]   wire_mgl_prim1_remain;

	lpm_divide   mgl_prim1
	( 
	.denom(denom),
	.numer(numer),
	.quotient(wire_mgl_prim1_quotient),
	.remain(wire_mgl_prim1_remain));
	defparam
		mgl_prim1.lpm_drepresentation = "UNSIGNED",
		mgl_prim1.lpm_nrepresentation = "SIGNED",
		mgl_prim1.lpm_type = "LPM_DIVIDE",
		mgl_prim1.lpm_widthd = 16,
		mgl_prim1.lpm_widthn = 16,
		mgl_prim1.lpm_hint = "LPM_REMAINDERPOSITIVE=TRUE";
	assign
		quotient = wire_mgl_prim1_quotient,
		remain = wire_mgl_prim1_remain;
endmodule //mglbk
//VALID FILE