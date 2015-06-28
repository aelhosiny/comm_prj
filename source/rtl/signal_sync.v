//                              -*- Mode: Verilog -*-
// Filename        : signal_sync.v
// Description     : synchronize crossing domain signals
// Author          : amr
// Created On      : Fri Jun  5 20:34:18 2015
// Last Modified By: amr
// Last Modified On: Fri Jun  5 20:34:18 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module signal_sync(/*AUTOARG*/
   // Outputs
   sync_out,
   // Inputs
   rstn, clk, async_in
   );

   parameter polarity_g = 1'b0;
   parameter stages = 3;
   
   
   input rstn;
   input clk;
   input async_in;
   output sync_out;

   reg  sync_ff0_s;
   reg 	sync_ff1_s;
   reg 	sync_ff2_s;
   
   always @(posedge clk or negedge rstn) begin
      if (rstn == 1'b0) begin
	 sync_ff0_s <= polarity_g;
	 sync_ff1_s <= polarity_g;
	 sync_ff2_s <= polarity_g;
      end
      else begin
	 sync_ff0_s <= async_in;
	 sync_ff1_s <= sync_ff0_s;
	 sync_ff2_s <= sync_ff1_s;
      end
   end

   if (stages==2) begin : st2
      assign sync_out = sync_ff1_s;
   end
   else if (stages==3) begin : st3
      assign sync_out = sync_ff2_s;
   end
   
endmodule