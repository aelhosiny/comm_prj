//                              -*- Mode: Verilog -*-
// Filename        : regfile.v
// Description     : register file
// Author          : amr
// Created On      : Fri Apr 24 23:59:06 2015
// Last Modified By: amr
// Last Modified On: Fri Apr 24 23:59:06 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module regfile (/*AUTOARG*/
   // Outputs
   dout, enable_digclk, digrf_rstn, swresetb, div_sdm_nc_en,
   clk_buf_en, tdc_en, dlf_en, dac_sdm_en, dac_en, vco_en, qdiv_en,
   div_en, div_sdm_en, dlf_a2, dlf_a3, dlf_b1, dlf_b2, vco_cntrl,
   frac, div_n,
   // Inputs
   wre, sclk, rstn, addr, din
   ) ;
   input wre;
   input sclk;
   input rstn;
   input [7:0] addr;
   input [7:0] din;
   output      dout;
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
   
 
   parameter regcount = 14;   
   parameter dflt_r0  = 8'h00;
   parameter dflt_r1  = 8'h00;
   parameter dflt_r2  = 8'h00;
   parameter dflt_r3  = 8'h00;
   parameter dflt_r4  = 8'h00;
   parameter dflt_r5  = 8'h00;
   parameter dflt_r6  = 8'h00;
   parameter dflt_r7  = 8'h00;
   parameter dflt_r8  = 8'h00;
   parameter dflt_r9  = 8'h00;
   parameter dflt_r10 = 8'h00;
   parameter dflt_r11 = 8'h00;
   parameter dflt_r12 = 8'h00;
   parameter dflt_r13 = 8'h00;
   
   reg [7:0] 	 regbank [13:0];
   wire [7:0] 	 dout_s [13:0];   
   wire [7:0] 	 dout_msk_s [13:0];

   //////////////////////
   //    Begin Body     /
   //////////////////////
   
   assign dout_msk_s[0]  = 8'b0001111;
   assign dout_msk_s[1]  = 8'b1111111;
   assign dout_msk_s[2]  = 8'b1111111;
   assign dout_msk_s[3]  = 8'b1111111;
   assign dout_msk_s[4]  = 8'b1111111;
   assign dout_msk_s[5]  = 8'b1111111;
   assign dout_msk_s[6]  = 8'b1111111;
   assign dout_msk_s[7]  = 8'b1111111;
   assign dout_msk_s[8]  = 8'b1111111;
   assign dout_msk_s[9]  = 8'b1111111;
   assign dout_msk_s[10] = 8'b0011111;
   assign dout_msk_s[11] = 8'b1111111;
   assign dout_msk_s[12] = 8'b1111111;
   assign dout_msk_s[13] = 8'b0011111;   
   

   genvar 	 i,j;
   generate
      for (i=0; i<regcount; i=i+1) begin : outer
	 for (j=0; j<8; j=j+1) begin : inner
	    assign dout_s[i][j] = (dout_msk_s[i][j] ==1'b1) ? regbank[i][j] : 1'b0;	    
	 end
      end
   endgenerate
   

   assign dout = dout_s[addr];
   
   
   integer ii;   
   always @(posedge sclk or negedge rstn) begin
      if (rstn==1'b0) begin
	 regbank[0] <= dflt_r0;
	 regbank[1] <= dflt_r1;
	 regbank[2] <= dflt_r2;
	 regbank[3] <= dflt_r3;
	 regbank[4] <= dflt_r4;
	 regbank[5] <= dflt_r5;
	 regbank[6] <= dflt_r6;
	 regbank[7] <= dflt_r7;
	 regbank[8] <= dflt_r8;
	 regbank[9] <= dflt_r9;
	 regbank[10] <= dflt_r10;
	 regbank[11] <= dflt_r11;
	 regbank[13] <= dflt_r13;	 
      end
      else begin
	 for (ii=0; ii<regcount; ii=ii+1) begin
	    if (wre==1'b1 && addr==ii) begin
	       regbank[ii] <= din;	       
	    end
	 end
      end // else: !if(rstn==1'b0)      
   end // always @ (posedge sclk or negedge rstn)
   
   
   assign enable_digclk = regbank[0][4];
   assign digrf_rstn = regbank[0][3];
   assign swresetb = regbank[0][2];
   assign div_sdm_nc_en = regbank[0][1];
   assign clk_buf_en = regbank[0][0];

   assign tdc_en     = regbank[1][7];
   assign dlf_en     = regbank[1][6];
   assign dac_sdm_en = regbank[1][5];
   assign dac_en     = regbank[1][4];
   assign vco_en     = regbank[1][3];
   assign qdiv_en    = regbank[1][2];
   assign div_en     = regbank[1][1];
   assign div_sdm_en = regbank[1][0];

   assign dlf_a2    = {regbank[2], regbank[3]};
   assign dlf_a3    = {regbank[4], regbank[5]};
   assign dlf_b1    = {regbank[6], regbank[7]};
   assign dlf_b2    = {regbank[8], regbank[9]};
   assign vco_cntrl = regbank[10];
   assign frac      = {regbank[11], regbank[12]};
   assign div_n     = regbank[13];
  
endmodule // regfile
