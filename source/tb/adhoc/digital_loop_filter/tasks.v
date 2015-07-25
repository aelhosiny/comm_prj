//                              -*- Mode: Verilog -*-
// Filename        : tasks.v
// Description     : tasks used in TB
// Author          : amr
// Created On      : Sat Jun  6 01:34:03 2015
// Last Modified By: amr
// Last Modified On: Sat Jun  6 01:34:03 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

/*task write_reg;
   input integer burst;   
   input [7:0] addr;
   input [7:0] data;
   reg [23:0]   data_reg;  
   integer     i,j,k;
   reg [7:0]   d;   
   begin
      if (burst==0) begin
	 fork
	    begin
	       #1;	       
	       csn = 1'b0;
	       #(t_spiclk/2);
	       data_reg = {write_cmd, addr, data};
	       mosi = write_cmd[7];	
	       for (i=0; i<23; i=i+1) begin
		  @(negedge sclk);		  
		  data_reg = {data_reg[22:0], 1'b0};
		  mosi = data_reg[23];		  
	       end
	       @(negedge sclk);
	       #(t_spiclk/2);
	       csn = 1'b1;
	    end
	    begin
	       @(negedge csn);
	       #(t_spiclk);
	       $display("Run SPI clock");
	       for (j=0; j<24; j=j+1) begin
		  sclk = ~sclk;
		  #(t_spiclk/2);
		  sclk = ~sclk;
		  #(t_spiclk/2);		  
	       end	       
	    end
	 join
      end // if (burst==0)      
      else begin
	 fork
	    begin
	       #1;	       
	       csn = 1'b0;
	       #(t_spiclk/2);
	       data_reg = {write_burst, addr, data};
	       mosi = write_burst[7];	       
	       for (i=0; i<15; i=i+1) begin
		  @(negedge sclk);
		  mosi = data_reg[22];
		  data_reg <= {data_reg[22:0], 1'b0};	
	       end
	       d=data;
	       for (i=0; i<burst; i=i+1) begin
		  d=data+i;
		  for (k=0; k<8; k=k+1) begin
		     @(negedge sclk);
		     mosi = d[7];
		     d = {d[6:0], 1'b0};
		  end
	       end
	       @(negedge sclk);
	       #(t_spiclk/2);	
	       csn = 1'b1;
	    end
	    begin
	       @(negedge csn);
	       #(t_spiclk);
	       $display("Run SPI clock");	       
	       for (j=0; j<((burst*8)+16); j=j+1) begin
		  sclk = ~sclk;
		  #(t_spiclk/2);
		  sclk = ~sclk;
		  #(t_spiclk/2);		  
	       end
	    end
	 join	 
      end // else: !if(burst==0)      
   end
endtask // write_reg

task read_reg;
   input integer burst;   
   input [7:0] 	 addr;
   reg [23:0] 	 data_reg;  
   integer 	 i,j,k;
   reg [7:0] 	 d;         
   begin
      if (burst==0) begin
	 fork
	    begin	 
	       #1;	       
	       csn = 1'b0;
	       #(t_spiclk/2);
	       data_reg = {read_cmd, addr};
	       mosi = write_burst[7];	       
	       for (i=0; i<15; i=i+1) begin
		  @(negedge sclk);
		  mosi = data_reg[22];
		  data_reg <= {data_reg[22:0], 1'b0};	
	       end
	       for (k=0; k<8; k=k+1) begin
		  @(negedge sclk);
	       end
	       @(negedge sclk);
	       #(t_spiclk/2);	
	       csn = 1'b1;
	    end
	    begin
	       @(negedge csn);
	       #(t_spiclk);
	       $display("Run SPI clock");	       
	       for (j=0; j<24; j=j+1) begin
		  sclk = ~sclk;
		  #(t_spiclk/2);
		  sclk = ~sclk;
		  #(t_spiclk/2);		  
	       end
	    end
	 join
      end // if (burst==0)
      else begin
	 fork
	    begin
	       #1;	       
	       csn = 1'b0;
	       #(t_spiclk/2);
	       data_reg = {read_burst, addr};
	       mosi = write_burst[7];	       
	       for (i=0; i<15; i=i+1) begin
		  @(negedge sclk);
		  mosi = data_reg[22];
		  data_reg <= {data_reg[22:0], 1'b0};	
	       end
	       for (i=0; i<burst; i=i+1) begin
		  for (k=0; k<8; k=k+1) begin
		     @(negedge sclk);
		  end
	       end
	       @(negedge sclk);
	       #(t_spiclk/2);	
	       csn = 1'b1;
	    end // else: !if(burst==0)
	    begin
	       @(negedge csn);
	       #(t_spiclk);
	       $display("Run SPI clock");	       
	       for (j=0; j<((burst*8)+16); j=j+1) begin
		  sclk = ~sclk;
		  #(t_spiclk/2);
		  sclk = ~sclk;
		  #(t_spiclk/2);		  
	       end
	    end
	 join
      end
   end
endtask // read_reg*/

task gen_clk;
   begin
      sys_clk <= ~sys_clk;
      #(t_sysclk/2);
   end
endtask // for