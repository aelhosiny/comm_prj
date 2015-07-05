//                              -*- Mode: Verilog -*-
// Filename        : sdm.v
// Description     : SDM
// Author          : amr
// Created On      : Tue May 19 23:44:17 2015
// Last Modified By: amr
// Last Modified On: Tue May 19 23:44:17 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module sdm(/*AUTOARG*/
   // Outputs
   sdm_out, sdm_qn,
   // Inputs
   din, rstn, clk
   );

   parameter w = 16;
   
   input [w-1:0] din;
   input 	 rstn;
   input 	 clk;
   output [3:0]  sdm_out;
   output 	 sdm_qn;
   


   wire signed [w:0] din_sgn;   
   wire signed [w:0] sec1_dout;
   wire signed [1:0] sec1_qunt;  
   wire signed [w:0] sec2_dout;
   wire signed [1:0] sec2_qunt;
   wire signed [1:0] sec3_qunt;
   wire signed [1:0] sec2_diff;
   wire signed [1:0] sec3_diff1;
   wire signed [2:0] sec3_diff2_in;
   wire signed [2:0] sec3_diff2;
   wire signed [3:0] add_in1;
   wire signed [3:0] add_in2;
   wire signed [3:0] add_in3;
   wire signed [3:0] add_out;
   reg signed [3:0] add_out_reg;


   
   
   assign din_sgn = {1'b0,din};
   


   sdm_sec #(
	     .w(w+1)
	     )
   sec1(
	.rstn(rstn),
	.clk(clk),
	.din(din_sgn),
	.dout(sec1_dout),
	.qunt_out(sec1_qunt),
	.sdm_qn()
	);

   sdm_sec #(
	     .w(w+1)
	     )
   sec2(
	.rstn(rstn),
	.clk(clk),
	.din(sec1_dout),
	.dout(sec2_dout),
	.qunt_out(sec2_qunt),
	.sdm_qn()
	);
   
   sdm_sec #(
	     .w(w+1)
	     )
   sec3(
	.rstn(rstn),
	.clk(clk),
	.din(sec2_dout),
	.dout(),
	.qunt_out(sec3_qunt),
	.sdm_qn(sdm_qn)
	);
   

   differentiator #(
		    .w(2)
		    )
   diff1(
	 .clk(clk),
	 .rstn(rstn),
	 .din(sec2_qunt),
	 .dout(sec2_diff)
	 );
   
   differentiator #(
		    .w(2)
		    )
   diff2(
	 .clk(clk),
	 .rstn(rstn),
	 .din(sec3_qunt),
	 .dout(sec3_diff1)
	 );

   assign sec3_diff2_in = {sec3_diff1[1], sec3_diff1};

   differentiator #(
		    .w(3)
		    )
   diff3(
	 .clk(clk),
	 .rstn(rstn),
	 .din(sec3_diff2_in),
	 .dout(sec3_diff2)
	 );

   assign add_in1 = {sec1_qunt[1], sec1_qunt[1], sec1_qunt};
   assign add_in2 = {sec2_diff[1], sec2_diff[1], sec2_diff};
   assign add_in3 = {sec3_diff2[2], sec3_diff2};
   assign add_out = add_in1 + add_in2 + add_in3;

   always @(posedge clk or negedge rstn) begin : outreg
      if (rstn==1'b0) begin
	 add_out_reg <= 4'd0;
      end
      else begin
	 add_out_reg <= add_out;
      end
   end
   
   assign sdm_out = add_out_reg;
   

   
endmodule 
	  