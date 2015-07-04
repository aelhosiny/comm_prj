//                              -*- Mode: Verilog -*-
// Filename        : loop_divider.v
// Description     : programable loop divider
// Author          : amr
// Created On      : Fri May  1 22:28:40 2015
// Last Modified By: amr
// Last Modified On: Fri May  1 22:28:40 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!
module loop_divider (/*AUTOARG*/
   // Outputs
   clko, clkob,
   // Inputs
   rstn, clk, clkb, div_n
   ) ;
   input rstn;
   input clk;
   input clkb;
   input [5:0] div_n;
   output      clko;
   output      clkob;

   wire        rstn_s;
   wire        rstn_b_s;
   reg [5:0]   clk_cntr;
   reg [5:0]   clkb_cntr;
   reg 	       clko_r;
   reg 	       clkob_r;
   reg 	       clko_ne;
   reg 	       clkob_ne;   
   

   
   wire [5:0]  div_n_hlf;


   assign div_n_hlf = div_n >> 1;
   
   

   /*reset_sync #(
	   .reset_p(1'b0),
	   .clk_p(1'b1)
	   )
   sync1(
	      .reset_in(rstn),
	      .clk(clk),
	      .reset_out(rstn_s)
	      );*/

   assign rstn_s = rstn;
   

   /*reset_sync #(
	   .reset_p(1'b0),
	   .clk_p(1'b0)
	   )
   sync2(
	      .reset_in(rstn),
	      .clk(clkb),
	      .reset_out(rstn_b_s)
	      );*/

   
   always @(posedge clk or negedge rstn_s) begin
      if (rstn_s==1'b0) begin
	 clk_cntr <= 6'd0;
	 clko_r <= 1'b0;
	 clkob_r <= 1'b1;	 
      end
      else begin
	 if (clk_cntr==div_n_hlf || clk_cntr==6'd0) begin
	    clko_r <= ~clko_r;
	    clkob_r <= ~clkob_r;
	 end
	 if (clk_cntr+1 == div_n) begin
	    clk_cntr <= 6'b0;	    
	 end
	 else begin
	    clk_cntr <= clk_cntr + 1'b1;	    
	 end
      end
   end

   always @(negedge clk or negedge rstn_s) begin : ne_retime
      if (rstn_s == 1'b0) begin
	 clko_ne <= 1'b0;
	 clkob_ne <= 1'b0;
      end
      else begin
	 clko_ne <= clko_r  & div_n[0];
	 clkob_ne <= clkob_r & div_n[0];
      end
   end

   assign clko = clko_ne | clko_r;
   assign clkob = clkob_r | clkob_ne;
   
endmodule // loop_divider
