//                              -*- Mode: Verilog -*-
// Filename        : reset_sync.v
// Description     : reset synchronizer
// Author          : amr
// Created On      : Fri May  1 22:30:49 2015
// Last Modified By: amr
// Last Modified On: Fri May  1 22:30:49 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


module reset_sync (/*AUTOARG*/
   // Outputs
   reset_out,
   // Inputs
   reset_in, clk
   ) ;
   input reset_in;
   input clk;
   output reset_out;


   // 1'b0 => active low
   // 1'b1 => active high
   parameter reset_p = 1'b0;
   parameter clk_p = 1'b1;
   

   reg 	  sync_ff0;
   reg 	  sync_ff1;

   generate
      if (reset_p==1'b0 && clk_p==1'b1) begin : activelow_posedge
	 always @(posedge clk or negedge reset_in) begin
	    if (reset_in == 1'b0) begin
	       sync_ff0 <= 1'b0;
	       sync_ff1 <= 1'b0;	       
	    end
	    else begin
	       sync_ff0 <= reset_in;
	       sync_ff1 <= sync_ff0;	       
	    end
	 end
	 assign reset_out = (reset_in==1'b0) ? 1'b0 : sync_ff1;	 
      end // block: activelow_posedge
      else if (reset_p==1'b0 && clk_p==1'b1) begin : activehigh_posedge
	 always @(posedge clk or posedge reset_in) begin
	    if (reset_in == 1'b1) begin
	       sync_ff0 <= 1'b1;
	       sync_ff1 <= 1'b1;	       
	    end
	    else begin
	       sync_ff0 <= reset_in;
	       sync_ff1 <= sync_ff0;	       
	    end
	 end
	 assign reset_out = (reset_in==1'b1) ? 1'b1 : sync_ff1;	 
      end // block: activehigh_posedge
      else if (reset_p==1'b0 && clk_p==1'b0) begin : activelow_negedge
	 always @(negedge clk or negedge reset_in) begin
	    if (reset_in == 1'b0) begin
	       sync_ff0 <= 1'b0;
	       sync_ff1 <= 1'b0;	       
	    end
	    else begin
	       sync_ff0 <= reset_in;
	       sync_ff1 <= sync_ff0;	       
	    end
	 end
	 assign reset_out = (reset_in==1'b0) ? 1'b0 : sync_ff1;	 
      end // block: activelow_posedge
      else begin : activehigh_negedge
	 always @(negedge clk or posedge reset_in) begin
	    if (reset_in == 1'b1) begin
	       sync_ff0 <= 1'b1;
	       sync_ff1 <= 1'b1;	       
	    end
	    else begin
	       sync_ff0 <= reset_in;
	       sync_ff1 <= sync_ff0;	       
	    end
	 end
	 assign reset_out = (reset_in==1'b1) ? 1'b1 : sync_ff1;	 
      end      
   endgenerate
   
endmodule // reset_sync
