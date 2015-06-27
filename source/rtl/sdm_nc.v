//                              -*- Mode: Verilog -*-
// Filename        : sdm_nc.v
// Description     : SDM noise cancellation
// Author          : amr
// Created On      : Fri Jun 26 17:50:31 2015
// Last Modified By: amr
// Last Modified On: Fri Jun 26 17:50:31 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


module sdm_nc(/*AUTOARG*/
   // Outputs
   sdm_nc_out,
   // Inputs
   rstn, enable, clk_ref, clk_dlf, sdm_nc_in, sdm_qn
   );
   
   parameter w1 = 15;
   parameter w2 = 10;
   
   input rstn;
   input enable;   
   input clk_ref;
   input clk_dlf;
   input [w1-1:0] sdm_nc_in;
   input 	  sdm_qn;
   output [14:0] sdm_nc_out;
   

   wire [w1-1:0]   sdm_nc_in_sync;
   wire [w2-1:0]  acc1_out;
   wire [w1+w2-1:0] mul1_out;
   wire [w1+w2-1:0] acc2_out;
   wire [w1+w2:0]   inc_out;
   wire [w1+2*w2:0] mul2_out;
   reg [w1+2*w2:0] mul2_out_reg;
   wire [w1+w2:0]  filter_out;
   wire 	   rstn_clkdlf;
   wire 	   rstn_clkref;
   wire [w2-1:0]   sdm_qn_ext;
   wire [14:0] sdm_nc_out_i;
   wire        enable_sync;

   assign sdm_qn_ext = {{(w2-1){1'b0}},sdm_qn};
   
   reset_sync reset_sync1(
			 .reset_out(rstn_clkdlf),
			 .reset_in(rstn), 
			 .clk(clk_dlf)
			 ) ;
   reset_sync reset_sync2(
			 .reset_out(rstn_clkref),
			 .reset_in(rstn), 
			 .clk(clk_ref)
			 ) ;
      
   word_sync #(
	       .w(w1)
	       )
     word_sync1(
			 .dout(sdm_nc_in_sync),
			 .rstn_src(rstn_clkdlf), 
			 .rstn_sink(rstn_clkref), 
			 .clk_src(clk_dlf), 
			 .clk_sink(clk_ref), 
			 .din(sdm_nc_in)
			 );

   integrator #(
		.w(w2)
		)
   acc1(
	.rstn(rstn_clkref),
	.clk(clk_ref),
	.din(sdm_qn_ext),
	.dout(acc1_out)
	);

   assign mul1_out = sdm_nc_in_sync * acc1_out;

   integrator #(
		.w(w2+w1)
		)
   acc2(
	.rstn(rstn_clkref),
	.clk(clk_ref),
	.din(mul1_out),
	.dout(acc2_out)
	);

   assign inc_out = acc2_out + 1'b1;

   sdm_nc_filter filter
    (
     .clk(clk_ref),
     .clk_enable(1'b1),
     .rstn(rstn_clkref),
     .filter_in(inc_out),
     .filter_out(filter_out)
     );

   assign mul2_out = filter_out * acc1_out;
   assign sdm_nc_out_i = mul2_out[w1+2*w2:w1+2*w2-14];

   signal_sync ssync1
     (
      .sync_out(enable_sync),
      .rstn(rstn_clkdlf), 
      .clk(clk_dlf), 
      .async_in(enable)
   );

   word_sync #(
	       .w(15)
	       )
     word_sync2(   
			 .dout(sdm_nc_out),
			 .rstn_src(rstn_clkref), 
			 .rstn_sink(rstn_clkdlf & enable_sync), 
			 .clk_src(clk_ref), 
			 .clk_sink(clk_dlf), 
			 .din(sdm_nc_out_i)
			 );   
   
   
endmodule