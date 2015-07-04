

`timescale 1ps/1fs

module sdm_tb();

   parameter w = 16;
   parameter tclk = 26040;
   
   
   reg [w-1:0] din;
   reg 	 rstn;
   reg 	 clk;
   wire signed [3:0]  sdm_out;
   wire 	 sdm_qn;
   wire signed [w:0] sec1_dout;
   wire signed [w:0] sub1_out;
   wire signed [w:0] sub1_in2;
   
   initial begin
      rstn = 1'b0;
      clk = 1'b0;
      din = 16385;
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
       .sdm_out(sdm_out),
       .sdm_qn(sdm_qn)
       );

   assign sub1_out = DUT.sec1.sub1_out;
   assign sub1_in2 = DUT.sec1.sub1_in2;
   assign sec1_dout = DUT.sec1_dout;
   
   
   integer file1_handle;
   integer file2_handle;
   integer file3_handle;
   integer file4_handle;
   
   initial begin
      file1_handle=$fopen("$OUTPATH/sdm_rtl_out.txt");
      file2_handle=$fopen("$OUTPATH/sec1_rtl_out.txt");
      file3_handle=$fopen("$OUTPATH/sub1_rtl_out.txt");
      file4_handle=$fopen("$OUTPATH/sub1_in2_rtl_out.txt");
   end
   
   always @(posedge rstn or negedge clk) begin
      if (rstn==1'b1) begin
	 $fdisplay(file1_handle,"%d",sdm_out);
	 $fdisplay(file2_handle,"%d",sec1_dout);
	 $fdisplay(file3_handle,"%d",sub1_out);
	 $fdisplay(file4_handle,"%b",DUT.sec1.qunt1_reg);
      end
   end
   

endmodule