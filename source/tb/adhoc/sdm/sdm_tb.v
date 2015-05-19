

`timescale 1ns/1ps

module sdm_tb();

   parameter w = 10;
   parameter tclk = 10;
   
   
   reg [w-1:0] din;
   reg 	 rstn;
   reg 	 clk;
   wire [3:0]  sdm_out;
   wire 	 sdm_qn;
   
   initial begin
      rstn = 1'b0;
      clk = 1'b0;
      din = 0;
   end

   always begin
      #(tclk/2);
      clk = ~clk;      
   end

   always begin
      #(10*tclk);
      @(negedge clk);
      rstn = 1'b1;
      #(1000*tclk);
      $stop;      
   end

   sdm #(
	 .w(w)
	 )
   DUT(
       .clk(clk),
       .rstn(rstn),
       .din(din),
       .sdm_out(sdm_out),
       .sdm_qn(sdm_qn)
       );
   

endmodule