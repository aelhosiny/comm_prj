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
   reg signed [17:0] dlf_a2;
   reg signed [17:0] dlf_a3;
   reg signed [17:0] dlf_b1;
   reg signed [17:0] dlf_b2;
   reg               dlf_en;
   reg [14:0]        dlf_sdm_nc_in;
   wire              clk_tdc;
   wire              clk_dlf;
   wire signed [15:0]       dlf_out;
   wire [14:0]       sdm_nc_out;
   reg               clken;
   wire signed [15:0] dlf_in;
   
   assign dlf_in = DUT.loop_filter_1.filter_in ;
   
   integer           file_handle, fileo1_handle, fileo2_handle;
   initial begin
      file_handle = $fopen("$INPATH/tdc_out.txt", "r");
      fileo1_handle=$fopen("$OUTPATH/tdc_out1.txt", "w");
      fileo2_handle=$fopen("$OUTPATH/tdc_out2.txt", "w");
   end
   

`include "../../include/tasks.v"
   
   initial begin : init_conf
      por_rstn = 0;
      sys_clk = 0;
      tdc_dout = 0;
      digrf_rstn = 0;
      enable_digclk = 0;
      dlf_a2 = -119760;
      dlf_a3 =  54248;
      dlf_b1 = 90033;
      dlf_b2 = -88579;
      dlf_en = 0;
      dlf_sdm_nc_in = 0; 
      clken = 1'b0;
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
      /*fork 
         begin
            external_stim();
         end
         begin
            @(posedge dlf_en);
            while (dlf_en==1'b1) begin
               $fdisplay(fileo1_handle,"%d",dlf_out);
               @(posedge clk_dlf);
            end
         end
      join*/
      fork
         begin
            ramp_test();
         end
         begin
            @(posedge dlf_en);
            $fdisplay(fileo2_handle,"tdc_dout,dlf_out");
            while (dlf_en==1'b1) begin
               $fdisplay(fileo2_handle,"%d,%d,%d",tdc_dout,dlf_in,dlf_out);
               //@(posedge clk_dlf);
               @(posedge clk_tdc);
            end
         end
      join
      $fclolse(file_handle);
      $fclolse(fileo2_handle);
      $fclolse(fileo2_handle);
      $stop;
   end
   

   digital_loop_filter DUT(
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
