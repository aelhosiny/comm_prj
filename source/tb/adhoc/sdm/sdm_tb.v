

`timescale 1ps/1fs

module sdm_tb();

   parameter w = 16;
   parameter tclk = 26040;
   
   
   reg [w-1:0] din;
   reg 	 rstn;
   reg 	 clk;
   reg [5:0]   N;
   wire signed [5:0]  div_ctrl;
   wire [w-1:0]	 sdm_qn;
   wire signed [w:0] sec1_dout;
   wire signed [w:0] sub1_out;
   wire signed [w+1:0] sub1_in2;
   wire signed [w+1:0] int1_out;
   
   initial begin
      rstn = 1'b0;
      clk = 1'b0;
      din = 26625;
      N = 31;
   end

   always begin
      #(tclk/2);
      clk = ~clk;      
   end

   always begin
      #(10*tclk);
      @(negedge clk);
      rstn = 1'b1;
      #(10000*tclk);
      //#(20*1000*1000);
      //#(100000*tclk);
      //#(100000*tclk);
      $stop;      
   end

   sdm #(
	 .w(w)
	 )
   DUT(
       .clk(clk),
       .rstn(rstn),
       .din(din),
       .N(N),
       .div_ctrl(div_ctrl),
       //.sdm_out(sdm_out),
       .sdm_qn(sdm_qn)
       );

   /*assign sub1_out = DUT.sec1.sub1_out;
   assign sub1_in2 = DUT.sec1.sub1_in2;
   assign int1_out = DUT.sec1.int1_out;
   assign sec1_dout = DUT.sec1_dout;*/
   
   
   integer file1_handle;
   /*integer file2_handle;
   integer file3_handle;
   integer file4_handle;
   integer file5_handle;*/
   
   initial begin
      file1_handle=$fopen("$OUTPATH/sdm_rtl_out.txt");
      /*file2_handle=$fopen("$OUTPATH/sec1_rtl_out.txt");
      file3_handle=$fopen("$OUTPATH/sub1_out_rtl.txt");
      file4_handle=$fopen("$OUTPATH/sub1_in2_rtl.txt");
      file5_handle=$fopen("$OUTPATH/int1_out_rtl.txt");*/
   end
   
   always @(posedge rstn or negedge clk) begin
      if (rstn==1'b1) begin
	 $fdisplay(file1_handle,"%d",div_ctrl);
	 /*$fdisplay(file2_handle,"%d",sec1_dout);
	 $fdisplay(file3_handle,"%d",sub1_out);
	 $fdisplay(file4_handle,"%d",sub1_in2);
         $fdisplay(file5_handle,"%d",int1_out);*/
      end
   end
   

endmodule
