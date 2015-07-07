//                              -*- Mode: Verilog -*-
// Filename        : digcore_tb.v
// Description     : digcore testbench
// Author          : amr
// Created On      : Sat Jun  6 01:29:15 2015
// Last Modified By: amr
// Last Modified On: Sat Jun  6 01:29:15 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


`resetall
`timescale 100ps/1ps

module digcore_tb();

   parameter t_spiclk = 1000; // 10MHz
   parameter t_sysclk = 8; // 800ps => 1250MHz
   parameter read_cmd    = 8'hc1;
   parameter read_burst  = 8'hc5;   
   parameter write_cmd   = 8'hc2;
   parameter write_burst = 8'hca;   
   parameter regcount = 14;   
   
   reg por_rstn;
   reg sys_clk;
   reg [4:0] tdc_dout;
   wire       clk_tdc;   
   wire      clk_dlf;
   wire [15:0] dlf_out;
   wire [14:0] sdm_nc_out;
   reg 	 sclk;
   reg 	 mosi;
   reg 	 csn;
   wire 	 miso;
   wire      swresetb;
   wire      div_sdm_nc_en;
   wire      clk_buf_en;
   wire      tdc_en;
   wire      dac_sdm_en;
   wire      dac_en; 
   wire      vco_en;   
   wire      qdiv_en;
   wire      div_en;
   wire      div_sdm_en;   
   wire [5:0]  vco_cntrl;
   wire [15:0] frac;
   wire [5:0]  div_n;

`include "../../tasks.v"
   
   initial begin : init_conf
      por_rstn = 1'b0;
      sys_clk = 1'b0;
      tdc_dout = 1'b0;
      sclk  = 1'b0;
      mosi = 1'b0;
      csn = 1'b1;      
   end

   always begin : test
      #(10*t_spiclk);
      por_rstn = 1'b1;
      write_reg(0, 8'd0, 8'h5A);
      write_reg(regcount, 8'd0, 8'd0);
      #(10*t_spiclk);
      read_reg(regcount, 8'd0);
      
      $stop;
   end


   digcore digcore_1(
		     .clk_tdc(clk_tdc), 
		     .clk_dlf(clk_dlf), 
		     .dlf_out(dlf_out), 
		     .sdm_nc_out(sdm_nc_out), 
		     .miso(miso), 
		     .swresetb(swresetb),
		     .div_sdm_nc_en(div_sdm_nc_en), 
		     .clk_buf_en(clk_buf_en), 
		     .tdc_en(tdc_en), 
		     .dac_sdm_en(dac_sdm_en), 
		     .dac_en(dac_en), 
		     .vco_en(vco_en),
		     .qdiv_en(qdiv_en), 
		     .div_en(div_en), 
		     .div_sdm_en(div_sdm_en), 
		     .vco_cntrl(vco_cntrl), 
		     .frac(frac), 
		     .div_n(div_n),
		     .por_rstn(por_rstn), 
		     .sys_clk(sys_clk), 
		     .tdc_dout(tdc_dout), 
		     .sclk(sclk), 
		     .mosi(mosi), 
		     .csn(csn)
		     );   
   

endmodule
