//                              -*- Mode: Verilog -*-
// Filename        : loop_divider_tb.v
// Description     : loop divider test bench
// Author          : amr
// Created On      : Fri May  1 23:52:05 2015
// Last Modified By: amr
// Last Modified On: Fri May  1 23:52:05 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

`timescale 1ns/1ps


module loop_divider_tb (/*AUTOARG*/ ) ;

   reg rstn;
   reg clk;
   wire clkb;
   reg [5:0] div_n;

   wire      clko;
   wire      clkob;

   parameter tclk = 10;

   task wait_cycles;
      integer i;      
      begin
	 for (i=0; i<10; i=i+1) begin
	    @(posedge clko);	    
	 end
      end
   endtask

   
   initial begin
      rstn = 1'b0;
      clk = 1'b0;
      div_n = 2;      
   end
   
   always begin : clkgen
      #(tclk);
      clk = ~clk;      
   end

   assign clkb = ~clk;

   always begin : cntrl_pr
      rstn = 1'b0;      
      #(10*tclk);
      rstn = 1'b1;
      wait_cycles();
      

      rstn = 1'b0; 
      div_n = 3;      
      #(10*tclk);
      rstn = 1'b1;
      wait_cycles();
      
      rstn = 1'b0; 
      div_n = 4;      
      #(10*tclk);
      rstn = 1'b1;
      wait_cycles();

      rstn = 1'b0; 
      div_n = 5;      
      #(10*tclk);
      rstn = 1'b1;
      wait_cycles();

      rstn = 1'b0; 
      div_n = 6;      
      #(10*tclk);
      rstn = 1'b1;
      wait_cycles();

      rstn = 1'b0; 
      div_n = 7;      
      #(10*tclk);
      rstn = 1'b1;
      wait_cycles();

      rstn = 1'b0; 
      div_n = 13;      
      #(10*tclk);
      rstn = 1'b1;
      wait_cycles();

      rstn = 1'b0; 
      div_n = 17;      
      #(10*tclk);
      rstn = 1'b1;
      wait_cycles();

      rstn = 1'b0; 
      div_n = 23;      
      #(10*tclk);
      rstn = 1'b1;
      wait_cycles();

      $stop;      
   end

   loop_divider DUT(
		    .rstn(rstn),
		    .clk(clk),
		    .clkb(clkb),
		    .div_n(div_n),
		    .clko(clko),
		    .clkob(clkob)
		    );
   
   




   
endmodule // loop_divider_tb
