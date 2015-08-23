//                              -*- Mode: Verilog -*-
// Filename        : fractional_divider.v
// Description     : Integrate the SDM and loop divider
// Author          : amr
// Created On      : Mon Jun 22 00:37:28 2015
// Last Modified By: amr
// Last Modified On: Mon Jun 22 00:37:28 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


module fractional_divider(/*AUTOARG*/
   // Outputs
   div_clk_out, div_clkb_out, sdm_qn, div_ctrl,
   // Inputs
   rstn, N, div_clk_in, div_clkb_in, sdm_in
   );

   input rstn;   
   input [5:0] N;
   input       div_clk_in;
   input       div_clkb_in;
   //input       clk_dlf;
   input [15:0] sdm_in;
   //input [14:0] sdm_nc_in;
   //input 	sdm_nc_enable;
   output 	div_clk_out;
   output 	div_clkb_out;
   output [15:0] sdm_qn;
   //output [14:0] sdm_nc_out;
   output [5:0] div_ctrl;
   
   
   
   
   /*wire [5:0]  sdm_mpr_o;
   wire signed [6:0]  sdm_out_ext;
   wire [3:0]  sdm_out;
   wire signed [6:0]  add_out;
   reg signed [6:0]  add_out_reg;*/
   wire 	     rstn_clkin_s;
   
   
   /*assign sdm_out_ext = {sdm_out[3], sdm_out[3], sdm_out[3], sdm_out};
   assign add_out = N + sdm_out_ext;
   assign sdm_mpr_o = add_out_reg[5:0];
   assign div_ctrl = sdm_mpr_o;*/
   
   reset_sync reset_sync1(
		      .reset_out(rstn_clkin_s),
		      .reset_in(rstn), 
		      .clk(div_clk_in)
		      ) ;
   
   
   loop_divider loop_divider(
			     .clko(div_clk_out), 
			     .clkob(div_clkb_out),
			     .rstn(rstn_clkin_s), 
			     .clk(div_clk_in), 
			     .clkb(1'b0), 
			     .div_n(div_ctrl)
			     ) ;

   sdm sdm(
	   .div_ctrl(div_ctrl), 
	   .sdm_qn(sdm_qn),
	   .din(sdm_in), 
	   .rstn(rstn_clkin_s), 
	   .clk(div_clk_out),
           .N(N)
           );   

   /*sdm_nc sdm_nc
     (
      .sdm_nc_out(sdm_nc_out),
      .rstn(rstn),
      .rstn_clkref(rstn_clkin_s),
      .enable(sdm_nc_enable), 
      .clk_ref(div_clk_out), 
      .clk_dlf(clk_dlf), 
      .sdm_nc_in(sdm_nc_in), 
      .sdm_qn(sdm_qn)
      );*/
   

   /*always @(posedge div_clk_out or negedge rstn_clkin_s) begin : clkps
      if (rstn_clkin_s == 1'b0) begin
	 add_out_reg <= 7'd30;	 
      end
      else begin
	 add_out_reg <= add_out;	 
      end
   end*/


endmodule
