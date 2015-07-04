//                              -*- Mode: Verilog -*-
// Filename        : dig_txrx_dp_tb.v
// Description     : datapth testbench
// Author          : aelhosiny
// Created On      : Wed Jun 17 14:48:40 2015
// Last Modified By: aelhosiny
// Last Modified On: Wed Jun 17 14:48:40 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

`timescale 1ps/1fs

module sdm_div_loop_tb();


   parameter tclk = 834;
   
   reg rstn;   
   reg [5:0] N;
   reg       div_clk_in;
   reg       div_clkb_in;
   reg       clk_dlf;
   reg [15:0] sdm_in;
   reg [14:0] sdm_nc_in;
   reg 	sdm_nc_enable;
   
   wire       div_clk_out;
   wire       div_clkb_out;
   wire       sdm_qn;
   wire [14:0] sdm_nc_out;
   wire [5:0]  div_ctrl;

 
   initial begin
      rstn = 0;
      N = 31;
      div_clk_in = 1'b0;
      div_clkb_in = 1'b1;
      clk_dlf = 1'b0;
      sdm_in = 26625;
      sdm_nc_in = 0;
      sdm_nc_enable = 1'b0;      
   end

`include "../../include/tasks.v"
//`include "./include/config.v"
   
   always begin : sysclk_gen
      gen_clk();
   end


   always begin : cntrl_ps
      #(10*tclk);
      rstn = 1'b1;
      #(10000*tclk);
      #(10000*tclk);
      #(10000*tclk);
      #(10000*tclk);
      #(10000*tclk);
      $stop;      
   end

   sdm_div_loop DUT(		    
		    .rstn(rstn),
		    .N(N),
		    .div_clk_in(div_clk_in),
		    .div_clkb_in(div_clkb_in),
		    .clk_dlf(clk_dlf),
		    .sdm_in(sdm_in),
		    .sdm_nc_in(sdm_nc_in),
		    .sdm_nc_enable(sdm_nc_enable),
		    .div_clk_out(div_clk_out),
		    .div_clkb_out(div_clkb_out),
		    .sdm_qn(sdm_qn),
		    .sdm_nc_out(sdm_nc_out),
		    .div_ctrl(div_ctrl)
		    );
   
  
endmodule
