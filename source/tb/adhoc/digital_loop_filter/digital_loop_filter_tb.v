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

  module digital_loop_filter_tb();


   parameter t_spiclk = 1000; // 10MHz
   parameter t_sysclk = 8; // 800ps => 1250MHz
   /*parameter read_cmd    = 8'hc1;
    parameter read_burst  = 8'hc5;   
    parameter write_cmd   = 8'hc2;
    parameter write_burst = 8'hca;   
    parameter regcount = 14;   */
   
   reg por_rstn;
   reg sys_clk;
   reg [4:0] tdc_dout;
   reg       digrf_rstn;
   reg       enable_digclk;
   reg signed [15:0] dlf_a2;
   reg signed [15:0] dlf_a3;
   reg signed [15:0] dlf_b1;
   reg signed [15:0] dlf_b2;
   reg               dlf_en;
   reg [14:0]        dlf_sdm_nc_in;
   wire              clk_tdc;
   wire              clk_dlf;
   wire [15:0]       dlf_out;
   wire [14:0]       sdm_nc_out;
   reg               clken;

   

`include "../../tasks.v"
   
   initial begin : init_conf
      por_rstn = 0;
      sys_clk = 0;
      tdc_dout = 0;
      digrf_rstn = 0;
      enable_digclk = 0;
      dlf_a2 = 31934;
      dlf_a3 =  -15552;
      dlf_b1 = 1594;
      dlf_b2 = -1587;
      dlf_en = 0;
      dlf_sdm_nc_in = 0; 
      clken = 1'b0;
   end

   integer file_handle;
   initial begin
      file_handle = $fopen("/home/amr/work/comm_prj/source/tb/adhoc/digital_loop_filter/tests/tc1/simin/tdc_out.txt", "r");
   end

   always begin
      gen_clk();
   end
   
   always begin : test
      #(10*t_sysclk);
      por_rstn = 1'b1;
      #(10*t_sysclk);
      digrf_rstn = 1'b1;
      #(10*t_sysclk);
      clken = 1'b1;
      enable_digclk = 1'b1;
      #(10*t_sysclk);
      @(posedge sys_clk);
      dlf_en = 1'b1;
      while (file_handle != 0) begin
         @(posedge clk_tdc);
         $fscanf(file_handle, "%d\n", tdc_dout);
      end
      /*write_reg(0, 8'd0, 8'h5A);
       write_reg(regcount, 8'd0, 8'd0);
       #(10*t_spiclk);
       read_reg(regcount, 8'd0);*/
      
      $stop;
   end


   digital_loop_filter DUT(
                           /*.por_rstn(por_rstn),
                            .digrf_rstn(digrf_rstn),                       
                            .enable_digclk(enable_digclk),*/
                           .por_rstn(por_rstn),
                           .digrf_rstn(por_rstn),                          
                           .enable_digclk(por_rstn),
                           .sys_clk(clken & sys_clk),              
                           .tdc_dout(tdc_dout),
                           .dlf_a2(dlf_a2),
                           .dlf_a3(dlf_a3),
                           .dlf_b1(dlf_b1),
                           .dlf_b2(dlf_b2),
                           .dlf_en(dlf_en),
                           .dlf_sdm_nc_in(dlf_sdm_nc_in),
                           .clk_tdc(clk_tdc),
                           .clk_dlf(clk_dlf),
                           .dlf_out(dlf_out),
                           .sdm_nc_out(sdm_nc_out)
                           );   
   

endmodule
