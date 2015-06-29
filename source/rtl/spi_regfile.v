//                              -*- Mode: Verilog -*-
// Filename        : spi_regfile.v
// Description     : SPI Regfile toplevel
// Author          : amr
// Created On      : Mon Jun 29 01:47:52 2015
// Last Modified By: amr
// Last Modified On: Mon Jun 29 01:47:52 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


module spi_regfile(/*AUTOARG*/
   // Outputs
   miso, enable_digclk, digrf_rstn, swresetb, div_sdm_nc_en,
   clk_buf_en, tdc_en, dlf_en, dac_sdm_en, dac_en, vco_en, qdiv_en,
   div_en, div_sdm_en, dlf_a2, dlf_a3, dlf_b1, dlf_b2, vco_cntrl,
   frac, div_n,
   // Inputs
   csn, sclk, mosi
   );

   input csn;
   input sclk;
   input mosi;
   
   output miso;   
   output      enable_digclk;
   output      digrf_rstn;
   output      swresetb;
   output      div_sdm_nc_en;
   output      clk_buf_en;
   output      tdc_en;
   output      dlf_en;
   output      dac_sdm_en;
   output      dac_en; 
   output      vco_en;   
   output      qdiv_en;
   output      div_en;
   output      div_sdm_en;
   output [15:0] dlf_a2;
   output [15:0] dlf_a3;
   output [15:0] dlf_b1;
   output [15:0] dlf_b2;
   output [5:0]  vco_cntrl;
   output [15:0] frac;
   output [5:0]  div_n;

   wire 	 rf_wre;
   wire [7:0] 	 rf_addr;
   wire [7:0] 	 rf_dout;
   wire [7:0] 	 rf_din;
   

   spi_if spi_if(
		   .miso(miso), 
		   .rf_addr(rf_addr), 
		   .rf_din(rf_din), 
		   .wre(rf_wre),
		   .csn(csn), 
		   .sclk(sclk), 
		   .mosi(mosi), 
		   .rf_dout(rf_dout)
		   ) ;
   
   reset_sync reset_sync(
			   .reset_in(por_rstn),
			   .clk(sclk),
			   .reset_out(rf_rstn)
			   );

   regfile regfile
     (
      .dout(rf_dout),
      .enable_digclk(enable_digclk),
      .digrf_rstn(digrf_rstn),
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





   
endmodule