//                              -*- Mode: Verilog -*-
// Filename        : word_sync.v
// Description     : FIFO based synchronizer
// Author          : amr
// Created On      : Fri Jun 26 18:17:37 2015
// Last Modified By: amr
// Last Modified On: Fri Jun 26 18:17:37 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module word_sync(/*AUTOARG*/
   // Outputs
   dout,
   // Inputs
   rstn_src, rstn_sink, clk_src, clk_sink, din
   );

   parameter w = 4;
   parameter depth = 4;
   parameter w_ptr = 2;
   
   
   input rstn_src;
   input rstn_sink;
   input clk_src;
   input clk_sink;
   input [w-1:0] din;
   output [w-1:0] dout;

   reg [w-1:0] 	  regbank [depth-1:0];
   wire [w-1:0]   regbank_init [depth-1:0];
   reg 		  empty;   
   
   reg [w_ptr-1:0] rd_ptr;
   wire [w_ptr-1:0] rd_ptr_nx;
   wire [w_ptr-1:0] rd_ptr_gry_i;
   reg [w_ptr-1:0] rd_ptr_gry;
   wire [w_ptr-1:0] wr_ptr_gry_sink;
   wire [w_ptr-1:0] wr_ptr_sink;
   
   reg [w_ptr-1:0] wr_ptr;
   wire [w_ptr-1:0] wr_ptr_nx;
   wire [w_ptr-1:0] wr_ptr_gry_i;
   reg [w_ptr-1:0] wr_ptr_gry;
   wire [w_ptr-1:0] rd_ptr_gry_src;
   wire [w_ptr-1:0] rd_ptr_src;
   reg [w-1:0] 	    dout;
  
   reg 		   full;
   wire 	   wre;
   wire 	   rde;

   genvar 	   i;
   for (i=0; i<depth; i=i+1) begin : meminit
      assign regbank_init[i] = {w{1'b0}};
   end
   
   /****************************************/
   // Write Domain Logic
   /****************************************/
   assign wre = ~full;
   assign wr_ptr_nx = wr_ptr + wre;
   /////////////////////////////////////////////////////////
   // Write pointer Binary to Gray encoding
   for( i = w_ptr - 2; i >= 0 ; i= i-1 ) begin : wr_bin2gry
      assign  wr_ptr_gry_i[i] = wr_ptr_nx[i+1] ^ wr_ptr_nx[i];
   end	  
   assign wr_ptr_gry_i[w_ptr -1] = wr_ptr_nx[w_ptr -1];
   /////////////////////////////////////////////////////////
   // Sync the gray read pointer to Write domain
   generate
      for (i=0; i<w_ptr; i=i+1) begin : gen1
	 signal_sync rd_ptr_sync(
				 .sync_out(rd_ptr_gry_src[i]),
				 .rstn(rstn_src), 
				 .clk(clk_src), 
				 .async_in(rd_ptr_gry[i])
				 );
      end
   endgenerate   
   /////////////////////////////////////////////////////////
   // Decode gray read pointer to binary
   for( i = w_ptr - 2; i >= 0 ; i=i-1 ) begin : rd_gry2bin
      assign rd_ptr_src[i]               = rd_ptr_src[i+1] ^ rd_ptr_gry_src[i]; 
   end
   assign rd_ptr_src[w_ptr -1] = rd_ptr_gry_src[w_ptr -1];
   /////////////////////////////////////////////////////////   
   always @(posedge clk_src or negedge rstn_src) begin : srclk_ps
      if (rstn_src==1'b0) begin
	 wr_ptr <= {w{1'b0}};
	 wr_ptr_gry <= {w{1'b0}};
	 full <= 1'b0;
      end
      else begin
	 wr_ptr <= wr_ptr_nx;
	 wr_ptr_gry <= wr_ptr_gry_i;	 
	 if (wr_ptr_nx == rd_ptr_src && wre==1'b1) begin
	    full <= 1'b1;
	 end
	 else if (rd_ptr_src > wr_ptr) begin
	    full <= 1'b0;	    
	 end
	 if (wre==1'b1) begin
	    regbank[wr_ptr] <= din;
	 end
      end
   end // block: srclk_ps
   
   /****************************************/
   /****************************************/

   /****************************************/
   // Write Domain Logic
   /****************************************/
   assign rde = ~empty;
   assign rd_ptr_nx = rd_ptr + rde;
   /////////////////////////////////////////////////////////
   // Read pointer Binary to Gray encoding
   //genvar 	 i;
   for( i = w_ptr - 2; i >= 0 ; i= i-1 ) begin : rd_bin2gry
      assign  rd_ptr_gry_i[i] = rd_ptr_nx[i+1] ^ rd_ptr_nx[i];
   end	  
   assign rd_ptr_gry_i[w_ptr -1] = rd_ptr_nx[w_ptr -1];
   /////////////////////////////////////////////////////////
   // Sync the gray Write pointer to Read domain
   generate
      for (i=0; i<w_ptr; i=i+1) begin : gen2
	 signal_sync wr_ptr_sync(
				 .sync_out(wr_ptr_gry_sink[i]),
				 .rstn(rstn_sink), 
				 .clk(clk_sink), 
				 .async_in(wr_ptr_gry[i])
				 );      
      end
   endgenerate   
   /////////////////////////////////////////////////////////
   // Decode gray write pointer to binary
   for( i = w_ptr - 2; i >= 0 ; i=i-1 ) begin : wr_gry2bin
      assign wr_ptr_sink[i]               = wr_ptr_sink[i+1] ^ wr_ptr_gry_sink[i]; 
   end
   assign wr_ptr_sink[w_ptr -1] = wr_ptr_gry_sink[w_ptr -1];
   /////////////////////////////////////////////////////////       
   always @(posedge clk_sink or negedge rstn_sink) begin : sinkclk_ps
      if (rstn_sink == 1'b0) begin
	 rd_ptr_gry <= {w{1'b0}};
	 empty <= 1'b1;
	 rd_ptr <= {w{1'b0}};
	 dout <= {w{1'b0}};
      end
      else begin
	 rd_ptr <= rd_ptr_nx;
	 rd_ptr_gry <= rd_ptr_gry_i;
	 if (wr_ptr_sink > rd_ptr) begin
	    empty <= 1'b0;	    
	 end
	 else if (rd_ptr_nx == wr_ptr_sink) begin
	    empty <= 1'b1;	    
	 end
	 if (rde==1'b1) begin
	    dout <= regbank[rd_ptr];
	 end
      end
   end
   
   
   
endmodule