module clk_divider(/*AUTOARG*/
   // Outputs
   clk_out, clkb_out,
   // Inputs
   rstn, clk_in
   );

   input rstn;
   input clk_in;
   output clk_out;
   output clkb_out;

   reg 	 clk_out;
   reg   clkb_out;
   
   always @(posedge clk_in or negedge rstn) begin
      if (rstn == 1'b0) begin
	 clk_out <= 1'b0;
         clkb_out <= 1'b1;
      end
      else begin
	 clk_out <= ~clk_out;
	 clkb_out <= ~clkb_out;
      end
   end
   
endmodule   


   