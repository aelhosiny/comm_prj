//                              -*- Mode: Verilog -*-
// Filename        : differentiator.v
// Description     : parametrized differentiator
// Author          : amr
// Created On      : Tue May 19 23:21:28 2015
// Last Modified By: amr
// Last Modified On: Tue May 19 23:21:28 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module differentiator(/*AUTOARG*/
   // Outputs
   dout,
   // Inputs
   clk, rstn, din
   );

   parameter w = 10;

   input clk;
   input rstn;
   input signed [w-1:0] din;
   output signed [w-1:0] dout;


   wire signed [w-1:0] 	 sub_out;
   reg signed [w-1:0] 		 din_reg;

   always @(posedge clk or negedge rstn) begin
      if (rstn==1'b0) begin
	 din_reg <= {w{1'b0}};	 
      end
      else begin
	 din_reg <= din;	 
      end
   end

   assign sub_out = din - din_reg;

   assign dout  = sub_out;
   

endmodule