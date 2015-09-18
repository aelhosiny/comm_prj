//                              -*- Mode: Verilog -*-
// Filename        : digital_loop_filter.v
// Description     : digital core toplevel
// Author          : amr
// Created On      : Fri Jun  5 21:18:24 2015
// Last Modified By: amr
// Last Modified On: Fri Jun  5 21:18:24 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module digital_loop_filter(/*AUTOARG*/
   // Outputs
   clk_tdc, clk_dlf, dlf_out, sdm_nc_out,
   // Inputs
   por_rstn, sys_clk, tdc_dout, digrf_rstn, enable_digclk, dlf_a2,
   dlf_a3, dlf_b1, dlf_b2, dlf_en, dlf_sdm_nc_in
   );

   // power on reset for the chip. Hard reset pin
   input por_rstn;
   // input system clock, (1250MHz max) clock input
   input sys_clk;
   // output samples from TDC
   input [4:0] tdc_dout;
   // Reset from regfile
   input       digrf_rstn;
   // Enable digital_loop_filter clock from regfile
   input       enable_digclk;
   // DLF coefficients
   input [17:0] dlf_a2;   
   input [17:0] dlf_a3;  
   input [17:0] dlf_b1;  
   input [17:0] dlf_b2;
   // DLF enable from regfile
   input 	dlf_en;
   // SDM NC to be subtracted from DEC out
   input [14:0] dlf_sdm_nc_in;
   // output 625MHz clock
   output 	clk_tdc;
   // output dlf clock
   output 	clk_dlf;
   // DLF output
   output [15:0] dlf_out;
   // SD NC output
   output [14:0] sdm_nc_out;
   
   wire 	 dig_rstn_s;
   wire 	 dec_clk;
   wire 	 clk_dlf_s;   
   wire signed [15:0]  dlf_in;
   wire signed [20:0]  dec_out;
   wire signed [15:0]  dec_out_slc;
   wire signed [15:0]  sub_out;
   wire signed [15:0]  dlf_sdm_nc_in_ext;
   wire signed [5:0]   dec_in;

   assign dec_in = tdc_dout - 6'sd16;
   assign dlf_sdm_nc_in_ext = {1'b0,dlf_sdm_nc_in};
   assign dec_out_slc = dec_out[20:5];
   assign sub_out = dec_out_slc - dlf_sdm_nc_in_ext;
   
   assign dlf_in = sub_out;
   assign sdm_nc_out = sub_out;

   clk_rst_gen clk_rst_gen_1(
			     .dig_rstn(dig_rstn_s), 
			     .clk_625mhz(dec_clk), 
			     .clk_lf(clk_dlf_s), 
			     .clk_lf_out(clk_dlf), 
			     .clk_625mhz_out(clk_tdc),
			     .por_rstn(por_rstn), 
			     .digrf_rstn(digrf_rstn), 
			     .enable_digclk(enable_digclk), 
			     .sys_clk(sys_clk)
			     );


   signal_sync #(
		 .polarity_g(1'b0)
		 )
   signal_sync_1(
		 .rstn(dig_rstn_s),
		 .clk(dec_clk),
		 .async_in(dlf_en),
		 .sync_out(dlf_en_s)
		 );
   
   loop_filter loop_filter_1(
			     .clk(clk_dlf_s),
			     .rstn(dig_rstn_s),
			     .enable(dlf_en_s),
			     .filter_in(dlf_in),
			     .ceout(),
			     .filter_out(dlf_out),
			     .a2(dlf_a2),
			     .a3(dlf_a3),
			     .b1(dlf_b1),
			     .b2(dlf_b2)
			     );   
   
   decimator decimator_1(
			 .clk(dec_clk),
			 .enable(dlf_en_s),
			 .rstn(dig_rstn_s),
			 .filter_in(dec_in),
			 .filter_out(dec_out),
			 .ce_out()
			 );


endmodule
