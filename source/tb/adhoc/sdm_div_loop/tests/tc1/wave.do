onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /sdm_div_loop_tb/rstn
add wave -noupdate -group TB /sdm_div_loop_tb/N
add wave -noupdate -group TB /sdm_div_loop_tb/clk
add wave -noupdate -group TB /sdm_div_loop_tb/frac
add wave -noupdate -group TB /sdm_div_loop_tb/sdm_mpr_o
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/rstn
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/N
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/clk
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/frac
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/sdm_mpr_o
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/sdm_out_ext
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/sdm_out
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/clko
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/clkob
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/add_out
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/add_out_reg
add wave -noupdate -group DUT /sdm_div_loop_tb/DUT/rstn_s
add wave -noupdate -group div /sdm_div_loop_tb/DUT/loop_divider/rstn
add wave -noupdate -group div /sdm_div_loop_tb/DUT/loop_divider/clk
add wave -noupdate -group div /sdm_div_loop_tb/DUT/loop_divider/clkb
add wave -noupdate -group div /sdm_div_loop_tb/DUT/loop_divider/div_n
add wave -noupdate -group div /sdm_div_loop_tb/DUT/loop_divider/clko
add wave -noupdate -group div /sdm_div_loop_tb/DUT/loop_divider/clkob
add wave -noupdate -group div /sdm_div_loop_tb/DUT/loop_divider/rstn_s
add wave -noupdate -group div /sdm_div_loop_tb/DUT/loop_divider/clk_cntr
add wave -noupdate -group div /sdm_div_loop_tb/DUT/loop_divider/div_n_hlf
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/din
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/rstn
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/clk
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sdm_out
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sdm_qn
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/din_sgn
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sec1_dout
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sec1_qunt
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sec2_dout
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sec2_qunt
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sec3_qunt
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sec2_diff
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sec3_diff1
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sec3_diff2_in
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/sec3_diff2
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/add_in1
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/add_in2
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/add_in3
add wave -noupdate -group SDM /sdm_div_loop_tb/DUT/sdm/add_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1482018000 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits fs
update
WaveRestoreZoom {0 fs} {8765757 ps}
