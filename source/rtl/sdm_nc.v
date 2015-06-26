//                              -*- Mode: Verilog -*-
// Filename        : sdm_nc.v
// Description     : SDM noise cancellation
// Author          : amr
// Created On      : Fri Jun 26 17:50:31 2015
// Last Modified By: amr
// Last Modified On: Fri Jun 26 17:50:31 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


module sdm_nc(/*AUTOARG*/);
   
   parameter w1 = 15;
   parameter w2 = 10;
   
   input rstn;
   input enable;   
   input clk_ref;
   input clk_dlf;
   input [w1-1:0] sdm_nc_in;
   output [w1+2*w2:0] sdm_nc_out;
   

   reg [w1-1:0]   sdm_nc_in_reg;
   wire [w2-1:0]  acc1_out;
   wire [w1+w2-1:0] mul1_out;
   wire [w1+w2-1:0] acc2_out;
   wire [w1+w2:0]   inc_out;
   wire [w1+2*w2:0] mul2_out;
   reg [w1+2*w2:0] mul2_out_reg;
   wire [w1+w2:0]  filter_out;
   

   assign sdm_nc_out = mul2_out_reg;

   always @(posedge 
   
endmodule