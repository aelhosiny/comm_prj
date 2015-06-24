//                              -*- Mode: Verilog -*-
// Filename        : sdm_div_loop.v
// Description     : Integrate the SDM and loop divider
// Author          : amr
// Created On      : Mon Jun 22 00:37:28 2015
// Last Modified By: amr
// Last Modified On: Mon Jun 22 00:37:28 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


module sdm_div_loop(/*AUTOARG*/
   // Outputs
   sdm_mpr_o, clko, clkob, sdm_qn,
   // Inputs
   rstn, N, clk, frac
   );

   input rstn;   
   input [5:0] N;
   input       clk;
   input [9:0] frac;
   output [5:0] sdm_mpr_o;
   output 	clko;
   output 	clkob;
   output 	sdm_qn;
   
   
   
   
   wire [5:0]  sdm_mpr_o;
   wire signed [6:0]  sdm_out_ext;
   wire [3:0]  sdm_out;
   wire        clko;
   wire        clkob;
   wire signed [6:0]  add_out;
   reg signed [6:0]  add_out_reg;
   wire 	     rstn_s;
   
   
   assign sdm_out_ext = {sdm_out[3], sdm_out[3], sdm_out[3], sdm_out};
   assign add_out = N + sdm_out_ext;
   assign sdm_mpr_o = add_out_reg[5:0];
   

reset_sync reset_sync(
		      .reset_out(rstn_s),
		      .reset_in(rstn), 
		      .clk(clk)
		      ) ;
   
   loop_divider loop_divider(
			     .clko(clko), 
			     .clkob(clkob),
			     .rstn(rstn_s), 
			     .clk(clk), 
			     .clkb(1'b0), 
			     .div_n(sdm_mpr_o)
			     ) ;

   sdm sdm(
	   .sdm_out(sdm_out), 
	   .sdm_qn(sdm_qn),
	   .din(frac), 
	   .rstn(rstn_s), 
	   .clk(clko)
   );

   always @(posedge clko or negedge rstn_s) begin : clkps
      if (rstn_s == 1'b0) begin
	 add_out_reg <= 7'd2;	 
      end
      else begin
	 add_out_reg <= add_out;	 
      end
   end


endmodule