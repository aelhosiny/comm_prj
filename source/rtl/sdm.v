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
   div_ctrl, sdm_qn,
   // Inputs
   din, rstn, clk, N
   );

   parameter w = 16;
   
   input [w-1:0] din;
   input 	 rstn;
   input 	 clk;
   input [5:0]   N;
   output [5:0]  div_ctrl;
   output [w-1:0] sdm_qn;
   


   wire signed [w:0] din_sgn;
   wire signed [6:0] N_sgn;
   wire signed [w:0] int1_dout;
   wire              int1_cout;
   wire signed [w:0] int2_dout;
   wire              int2_cout;
   wire signed [w:0] int3_dout;
   wire              int3_cout;
   wire signed [1:0] int1_cout_sgn;
   reg signed [1:0] int1_cout_sgn_reg;
   wire signed [1:0] sub1_out_tmp;
   wire signed [2:0] sub1_out;
   wire signed [2:0] int2_cout_sgn;
   wire signed [2:0] add1_out;
   wire signed [3:0] sub2_in1;
   reg signed [3:0] sub2_in2;
   wire signed [3:0] sub2_out;
   wire signed [3:0] int3_cout_sgn;
   wire signed [3:0] add2_out;
   wire [6:0]  dN;
   wire [6:0]  div_ctrl_i;
   reg [5:0]  div_ctrl_reg;
   
   assign din_sgn = {1'b0,din};

   integrator #(
		.w(w+1),
		.sat(1'b0),
		.outreg(1'b0)
		)
   int1(
	.rstn(rstn),
	.clk(clk),
	.din(din_sgn),
	.dout(int1_dout),
        .carry(int1_cout)
	);

   integrator #(
		.w(w+1),
		.sat(1'b0),
		.outreg(1'b0)
		)
   int2(
	.rstn(rstn),
	.clk(clk),
	.din(int1_dout),
	.dout(int2_dout),
        .carry(int2_cout)
	);

   integrator #(
		.w(w+1),
		.sat(1'b0),
		.outreg(1'b0)
		)
   int3(
	.rstn(rstn),
	.clk(clk),
	.din(int2_dout),
	.dout(int3_dout),
        .carry(int3_cout)
	);

   assign int1_cout_sgn = {1'b0, int1_cout};
   assign sub1_out_tmp = int1_cout_sgn - int1_cout_sgn_reg;   
   assign sub1_out = {sub1_out_tmp[1], sub1_out_tmp};
   assign int2_cout_sgn = {2'b00, int2_cout};
   assign add1_out = int2_cout_sgn + sub1_out;
   assign sub2_in1 = {add1_out[2], add1_out};
   assign sub2_out = sub2_in1 - sub2_in2;
   assign int3_cout_sgn = {3'b000, int3_cout};
   assign add2_out = sub2_out + int3_cout_sgn;
   assign dN = {add2_out[3], add2_out[3], add2_out[3], add2_out};
   assign N_sgn = {1'b0, N};   
   assign div_ctrl_i = dN + N_sgn;
   assign div_ctrl = div_ctrl_reg;
   assign sdm_qn = int3_dout[w-1:0];
   
   always @(posedge clk or negedge rstn) begin : clkps
      if (rstn==1'b0) begin
         int1_cout_sgn_reg <= 2'd0;
         sub2_in2 <= 4'd0;
         div_ctrl_reg <= 6'd30;
      end
      else begin
         int1_cout_sgn_reg <= int1_cout_sgn;
         sub2_in2 <= sub2_in1;
         div_ctrl_reg <= div_ctrl_i[5:0];
      end
   end
   
   
endmodule 
