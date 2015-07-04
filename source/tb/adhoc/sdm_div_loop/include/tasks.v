task gen_clk;
   begin
      div_clk_in <= ~div_clk_in;
      #(tclk/2);
   end
endtask // for

