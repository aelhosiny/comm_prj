initial begin
   
   pkt_fifo_mode = 0;
   scrm_enable = 0;
   mode_switch = 0;
   ms_prmentr = 0;
   ms_fec_mode = 0;
   ms_new_mode = 0;
   frmtype = 3'b000;
   frmsubtype = 2'b00;
   frmvrsn = 2'b10;
   panid_cmprsn = 1'b0;   
   scrt_enable = 1'b1;
   frm_pndng = 0;
   ack_req = 0;
   seqnum_sprsn = 1'b0;
   ielst_prsnt = 1'b1;
   dstadd_mode = 2'b11;
   srcadd_mode = 2'b00;
   seqnum = 8'hA5;
   dstpanid = 16'hE2E1;
   srcpanid = 16'hFFFF;
   dstadd = 64'hB8B7B6B5B4B3B2B1;
   srcadd = 64'hC8C7C6C5C4C3C2C1;
   scrt_lvl = 3'b001;
   scrt_keyidmode = 2'b11;
   scrt_frmcntrsprsn = 0;
   scrt_frmcntrsize = 1;
   scrt_frmcounter = 40'hA5A4A3A2A1;
   scrt_keyid = 72'hD9D8D7D6D5D4D3D2D1;
   long_frmctrl = 0;
   mltprps_panidprsnt = 0;
   pancoord = 0;
   thrdlvl_fltr = 1'b1;
   macimplicitbroadcast = 0;
   fcslngth = 1'b1;
   frmlngth = 11'd64;
   crc_init = 0;
   acktimeduration = 5'h00;
   bit_pulse = 0;
   macshrtadd = 16'hC2C1;
   macextadd = 64'hB8B7B6B5B4B3B2B1;
   macpanid = 16'hE2E1;;

   preamb_len = 4;
   sfd_sel = 0;
   ena_fec = 0;
   
   
end // initial begin
