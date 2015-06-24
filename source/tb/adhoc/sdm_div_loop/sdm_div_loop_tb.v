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
   reg 	     clk;
   reg [9:0] frac;
   wire [5:0] sdm_mpr_o;  
   wire 	clko;
   wire 	clkob;
   wire 	sdm_qn;

 
   initial begin
      rstn = 0;
      N = 31;
      clk = 0;
      frac = 416;     
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
      $stop;      
   end

   sdm_div_loop DUT(
		    .rstn(rstn),
		    .N(N),
		    .clk(clk),
		    .frac(frac),
		    .sdm_mpr_o(sdm_mpr_o),
		    .clko(clko),
		    .clkob(clkob),
		    .sdm_qn(sdm_qn)
		    );
   
  
endmodule
