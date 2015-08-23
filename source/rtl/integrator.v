//                              -*- Mode: Verilog -*-
// Filename        : integrator.v
// Description     : parametrized integrator
// Author          : amr
// Created On      : Tue May 19 23:06:33 2015
// Last Modified By: amr
// Last Modified On: Tue May 19 23:06:33 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module integrator(/*AUTOARG*/
   // Outputs
   dout, carry,
   // Inputs
   rstn, clk, din
   );

   parameter w = 10;
   parameter sat = 1'b0;
   parameter outreg = 1'b1;
   
   input rstn;
   input clk;
   input signed [w-1:0] din;
   output signed [w-1:0]  dout;
   output                 carry;

   wire signed [w:0] 	 add_out_tmp;
   wire signed [w-1:0] 	 add_out;
   reg signed [w-1:0] 	 add_out_reg;
   reg                carry_reg;
   
     
   always @(posedge clk or negedge rstn) begin
      if (rstn==1'b0) begin
	 add_out_reg <= {(w){1'b0}};
	 carry_reg <= 1'b0;
      end
      else begin
	 add_out_reg <= add_out;
	 carry_reg <= add_out_tmp[w-1];
      end
   end
   
   assign add_out_tmp = add_out_reg + din;

   if (sat==1'b1) begin : sat_g
      assign add_out = (add_out_tmp[w-1] == 1'b1) ? {1'b0,{(w-1){1'b1}}} : {1'b0,add_out_tmp[w-2:0]};
   end
   else begin : nosat_g
      assign add_out = {add_out_tmp[w], add_out_tmp[w-2:0]};
   end

   if (outreg == 1'b1) begin : outreg_g
      assign dout = add_out_reg;
      assign carry = carry_reg;
   end
   else begin : nooutreg_g
      assign dout = add_out;
      assign carry = add_out_tmp[w-1];
   end
   


endmodule
   
