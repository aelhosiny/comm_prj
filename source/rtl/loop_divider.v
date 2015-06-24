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
   reg 	       clko;
   reg 	       clkob;
   

   
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
	 clk_cntr <= 6'b0;
	 clko <= 1'b0;
	 clkob <= 1'b1;	 
      end
      else begin
	 if (clk_cntr+1==div_n_hlf || clk_cntr+1==div_n) begin
	    clko <= ~clko;
	    clkob <= ~clkob;
	 end
	 if (clk_cntr+1 == div_n) begin
	    clk_cntr <= 6'b0;	    
	 end
	 else begin
	    clk_cntr <= clk_cntr + 1'b1;	    
	 end
      end
   end

/*    always @(posedge clkb or negedge rstn_b_s) begin
      if (rstn_b_s==1'b0) begin
	 clkb_cntr <= 6'b0;
	 clkob <= 1'b1;	 
      end
      else begin
	 if (clkb_cntr+1==div_n_hlf || clkb_cntr+1==div_n) begin
	    clkob <= ~clkob;	    
	 end
	 if (clkb_cntr+1 == div_n) begin
	    clkb_cntr <= 6'b0;
	 end
	 else begin
	    clkb_cntr <= clkb_cntr + 1'b1;
	 end
      end
   end  */
   
endmodule // loop_divider
