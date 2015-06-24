task gen_clk;
   begin
      clk <= ~clk;
      #(tclk/2);
   end
endtask // for

