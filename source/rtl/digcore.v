//                              -*- Mode: Verilog -*-
// Filename        : digcore.v
// Description     : digital core toplevel
// Author          : amr
// Created On      : Fri Jun  5 21:18:24 2015
// Last Modified By: amr
// Last Modified On: Fri Jun  5 21:18:24 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module digcore(/*AUTOARG*/
   // Outputs
   clk_tdc, clk_dlf, dlf_out, sdm_nc_out, miso, swresetb,
   div_sdm_nc_en, clk_buf_en, tdc_en, dac_sdm_en, dac_en, vco_en,
   qdiv_en, div_en, div_sdm_en, vco_cntrl, frac, div_n,
   // Inputs
   por_rstn, sys_clk, tdc_dout, sclk, mosi, csn
   );

   // power on reset for the chip. Hard reset pin
   input por_rstn;
   // input system clock, (1250MHz max) clock input
   input sys_clk;
   // output samples from TDC
   input [4:0] tdc_dout;
   // output 625MHz clock
   output       clk_tdc;   
   // output dlf clock
   output      clk_dlf;
   // DLF output
   output [15:0] dlf_out;
   // SD NC output
   output [14:0] sdm_nc_out;
   // registe file ports
   input 	 sclk;
   input 	 mosi;
   input 	 csn;
   output 	 miso;
   output      swresetb;
   output      div_sdm_nc_en;
   output      clk_buf_en;
   output      tdc_en;
   output      dac_sdm_en;
   output      dac_en; 
   output      vco_en;   
   output      qdiv_en;
   output      div_en;
   output      div_sdm_en;   
   output [5:0]  vco_cntrl;
   output [15:0] frac;
   output [5:0]  div_n;
   
   wire 	 dig_rstn_s;
   wire 	 dec_clk;
   wire 	 clk_dlf_s;
   wire 	 digrf_rstn_s;
   wire 	 enable_digclk_s;
   wire [7:0] 	 rf_dout;
   wire 	 dlf_en;
   wire [15:0] 	 dlf_a2;   
   wire [15:0] 	 dlf_a3;   
   wire [15:0] 	 dlf_b1;   
   wire [15:0] 	 dlf_b2;
   wire [7:0] 	 rf_din;
   wire [7:0] 	 rf_addr;
   wire 	 rf_rstn;
   wire 	 rf_wre;
   wire [14:0] 	 dlf_in;
   

   clk_rst_gen clk_rst_gen_1(
			     // Outputs
			     .dig_rstn(dig_rstn_s), 
			     .clk_625mhz(dec_clk), 
			     .clk_lf(clk_dlf_s), 
			     .clk_lf_out(clk_dlf), 
			     .clk_625mhz_out(clk_tdc),
			     // Inputs
			     .por_rstn(por_rstn), 
			     .digrf_rstn(digrf_rstn_s), 
			     .enable_digclk(enable_digclk_s), 
			     .sys_clk(sys_clk)
			     );
   
   reset_sync reset_sync_1(
			   .reset_in(por_rstn),
			   .clk(sclk),
			   .reset_out(rf_rstn)
			   );

   regfile regfile_1(
		     .dout(rf_dout),
		     .enable_digclk(enable_digclk_s),
		     .digrf_rstn(digrf_rstn_s),
		     .swresetb(swresetb),
		     .div_sdm_nc_en(div_sdm_nc_en),
		     .clk_buf_en(clk_buf_en),
		     .tdc_en(tdc_en),
		     .dlf_en(dlf_en),
		     .dac_sdm_en(dac_sdm_en),
		     .dac_en(dac_en),
		     .vco_en(vco_en),
		     .qdiv_en(qdiv_en),
		     .div_en(div_en),
		     .div_sdm_en(div_sdm_en),
		     .dlf_a2(dlf_a2),
		     .dlf_a3(dlf_a3),
		     .dlf_b1(dlf_b1),
		     .dlf_b2(dlf_b2),
		     .vco_cntrl(vco_cntrl),
		     .frac(frac),
		     .div_n(div_n),
		     .wre(rf_wre),
		     .sclk(sclk),
		     .rstn(rf_rstn),
		     .addr(rf_addr),
		     .din(rf_din)
		     ) ;

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
			     .filter_in({1'b0,dlf_in}),
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
			 .filter_in(tdc_dout),
			 .filter_out(dlf_in),
			 .ce_out()
			 );

   spi_if spi_if_1(
		   .miso(miso), 
		   .rf_addr(rf_addr), 
		   .rf_din(rf_din), 
		   .wre(rf_wre),
		   .csn(csn), 
		   .sclk(sclk), 
		   .mosi(mosi), 
		   .rf_dout(rf_dout)
		   ) ;

endmodule