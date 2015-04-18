module clk_divider(/*AUTOARG*/
   // Inputs
   rstn, clk_in, clk_out
   );

   input rstn;
   input clk_in;
   output clk_out;

   reg 	 clk_out;
   
   
   always @(posedge clk_in or negedge rstn) begin
      if (rstn == 1'b0) begin
	 clk_out <= 1'b0;
      end
      else begin
	 clk_out <= ~clk_out;	 
      end
   end
   
endmodule   


   