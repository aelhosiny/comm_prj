//                              -*- Mode: Verilog -*-
// Filename        : sdm_sec.v
// Description     : SDM section
// Author          : amr
// Created On      : Wed May 20 00:16:11 2015
// Last Modified By: amr
// Last Modified On: Wed May 20 00:16:11 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module sdm_sec(/*AUTOARG*/
   // Outputs
   dout, qunt_out, sdm_qn,
   // Inputs
   rstn, clk, din
   );

   parameter w = 17;
   
   
   input rstn;
   input clk;
   input signed [w-1:0] din;
   output signed [w-1:0] dout;   
   output signed [1:0]	 qunt_out;
   output	 sdm_qn;
   


   wire signed [w-1:0] sub1_in1;
   wire signed [w-1:0] sub1_in2;
   wire signed [w-1:0] sub1_out;
   wire signed [w:0] int1_in;   
   wire signed [w:0] int1_out;   
   wire 	     qunt1;   
   reg 		     qunt1_reg;
   wire signed [w-1:0] limiter_out;
   wire signed [w:0] sub2_in1;
   wire signed [w:0] sub2_in2;
   wire signed [w:0] sub2_out;
   wire signed [w:0] sdm_qn_ext;

   
   assign sub1_in1 = {1'b0, din};   
   assign qunt1 = int1_out[w-1];
   assign sub1_in2 = {{w-1{1'b0}},qunt1};
   assign sub1_out = sub1_in1 - sub1_in2;

   assign int1_in = {sub1_out[w-1],sub1_out};
   
   integrator #(
		.w(w+1),
		.sat(1'b0),
		.outreg(1'b1)
		)
   int1(
	.rstn(rstn),
	.clk(clk),
	.din(int1_in),
	.dout(int1_out)
	);

   
   assign sub2_in1 = int1_out;
   assign sub2_in2 = {{w-1{1'b0}},qunt1_reg};
   assign sub2_out = sub2_in1 - sub2_in2;
   assign sdm_qn_ext = sub2_in2 - sub2_in1;
   assign sdm_qn = sdm_qn_ext[0];
   
   assign qunt_out = {1'b0,qunt1};
   assign dout = {sub2_out[w],sub2_out[w-2:0]};
   

   always @(posedge clk or negedge rstn) begin
      if (rstn==1'b0) begin
	 qunt1_reg <= 1'b0;
      end
      else begin
	 qunt1_reg <= qunt1;	 
      end
   end

endmodule  