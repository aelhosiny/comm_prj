//                              -*- Mode: Verilog -*-
// Filename        : clk_rst_gen.v
// Description     : clk_rst_gen
// Author          : amr
// Created On      : Fri Jun  5 15:27:18 2015
// Last Modified By: amr
// Last Modified On: Fri Jun  5 15:27:18 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module clk_rst_gen(/*AUTOARG*/
   // Outputs
   dig_rstn, clk_625mhz, clk_lf, clk_lf_out, clk_625mhz_out,
   // Inputs
   por_rstn, digrf_rstn, enable_digclk, sys_clk
   );

   // power on reset for the chip. Hard reset pin
   input por_rstn;
   // soft reset to digcore from register file
   input digrf_rstn;
   // enable/gate clock to digital from register file
   input enable_digclk;
   // input system clock, 625MHz clock input
   input sys_clk;
   // reset out to digital blocks, combines soft and hard resets
   output dig_rstn;
   // gated 625MHz clock to digital
   output clk_625mhz;
   // programable clock to LPF, freq is controlled by the
   // decimation ratio of the downsampler
   output clk_lf;
   // clk_lf output without gating
   output clk_lf_out;
   // 625MHz clock output to toplevel without gating
   output clk_625mhz_out;
   
   

   wire   clk_625mhz_s;
   wire   sys_clk_gated_s;   
   wire [3:0] clkinv_index_s;
   reg [3:0]  clkdiv_cnt_s;
   reg 	      clk_lf_s;
   reg 	      enable_digclk_ne_s;
   wire       por_rstn_s;
   wire       enable_digclk_s;
   
   

   reset_sync reset_sync_1(
			   .reset_in(por_rstn),
			   .clk(sys_clk),
			   .reset_out(por_rstn_s));

   clk_divider clk_divider_1(
			     .rstn(por_rstn_s),
			     .clk_in(sys_clk),
			     .clk_out(clk_625mhz_s));
   
   assign clk_625mhz_out = clk_625mhz_s;

   // DLF clock generation
  always @(posedge clk_625mhz_s or negedge por_rstn_s) begin
      if (por_rstn_s==1'b0) begin
	 clkdiv_cnt_s <= 4'd0;
	 clk_lf_s <= 1'b0;	 
      end
      else begin	
	 clkdiv_cnt_s <= clkdiv_cnt_s + 1'b1;	    
	 if (clkdiv_cnt_s == 4'd15 || clkdiv_cnt_s==4'd0) begin
            clk_lf_s <= ~clk_lf_s;
	 end	 
      end
   end   

   assign clk_lf_out = clk_lf_s;
   
		      
   // Digital clock gating and reset
   reset_sync reset_sync_2(
			   .reset_in(digrf_rstn & por_rstn),
			   .clk(clk_625mhz_s),
			   .reset_out(dig_rstn_s)
			   );

   assign dig_rstn = dig_rstn_s;
   
   
   signal_sync #(
		 .polarity_g(1'b0)
		 )
   signal_sync_1(
		 .rstn(dig_rstn_s),
		 .clk(clk_625mhz_s),
		 .async_in(enable_digclk),
		 .sync_out(enable_digclk_s)
		 );

   always @(negedge clk_625mhz_s or negedge dig_rstn_s) begin
      if (dig_rstn_s==1'b0) begin
	 enable_digclk_ne_s <= 1'b0;	 
      end
      else begin
	 enable_digclk_ne_s <= enable_digclk_s;
      end
   end
   
   assign clk_lf = clk_lf_s & enable_digclk_ne_s;
   assign clk_625mhz = clk_625mhz_s & enable_digclk_ne_s;
 

endmodule