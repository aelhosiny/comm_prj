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
   dout,
   // Inputs
   rstn, clk, din
   );

   parameter w = 10;   
   
   input rstn;
   input clk;
   input [w-1:0] din;
   output [w-1:0]  dout;


   wire [w-1:0] 	 din_ext;
   wire [w-1:0] 	 add_out;
   reg [w-1:0] 	 add_out_reg;


   assign din_ext = {1'b0, din};
   
     
   always @(posedge clk or negedge rstn) begin
      if (rstn==1'b0) begin
	 add_out_reg <= {(w){1'b0}};	 
      end
      else begin
	 add_out_reg <= add_out;	 
      end
   end
   
   assign add_out = add_out_reg + din_ext;

   assign dout = add_out;
   


endmodule
   