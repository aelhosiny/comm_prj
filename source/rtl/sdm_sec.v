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
   dout, qunt_out,
   // Inputs
   rstn, clk, din
   );

   parameter w = 10;
   
   
   input rstn;
   input clk;
   input signed [w-1:0] din;
   output signed [w-1:0] dout;   
   output signed [1:0]	 qunt_out;
   


   wire signed [w-1:0] sub1_in1;
   wire signed [w-1:0] sub1_in2;
   wire signed [w-1:0] sub1_out;   
   wire signed [w-1:0] int1_out;   
   wire 	     qunt1;   
   reg 		     qunt1_reg;   
   wire signed [w-1:0] sub2_in1;
   wire signed [w-1:0] sub2_in2;
   wire signed [w-1:0] sub2_out;

   
   assign sub1_in1 = {1'b0, din};
   assign sub1_in2 = {{(w-1){1'b0}}, qunt1_reg};
   assign qunt1 = (int1_out < 0) ? 1'b0 : 1'b1;
   assign sub1_out = sub1_in1 - sub1_in2;

   integrator #(
		.w(w)
		)
   int1(
	.rstn(rstn),
	.clk(clk),
	.din(sub1_out),
	.dout(int1_out)
	);

   
   assign sub2_in1 = int1_out;
   assign sub2_in2 = {{(w-1){1'b0}}, qunt1};
   assign sub2_out = sub2_in1 - sub2_in2;
   
   assign qunt_out = {1'b0,qunt1};
   assign dout = sub2_out;
   

   always @(posedge clk or negedge rstn) begin
      if (rstn==1'b0) begin
	 qunt1_reg <= 1'b0;	 
      end
      else begin
	 qunt1_reg <= qunt1;	 
      end
   end

endmodule  