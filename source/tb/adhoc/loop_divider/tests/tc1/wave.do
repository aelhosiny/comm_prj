onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /loop_divider_tb/rstn
add wave -noupdate -expand -group TB /loop_divider_tb/clk
add wave -noupdate -expand -group TB /loop_divider_tb/clkb
add wave -noupdate -expand -group TB -radix unsigned /loop_divider_tb/div_n
add wave -noupdate -expand -group TB /loop_divider_tb/clko
add wave -noupdate -expand -group TB /loop_divider_tb/clkob
add wave -noupdate -expand -group DUT /loop_divider_tb/DUT/rstn
add wave -noupdate -expand -group DUT /loop_divider_tb/DUT/clk
add wave -noupdate -expand -group DUT /loop_divider_tb/DUT/clkb
add wave -noupdate -expand -group DUT /loop_divider_tb/DUT/div_n
add wave -noupdate -expand -group DUT -color Magenta /loop_divider_tb/DUT/clko
add wave -noupdate -expand -group DUT -color Yellow /loop_divider_tb/DUT/clkob
add wave -noupdate -expand -group DUT /loop_divider_tb/DUT/rstn_s
add wave -noupdate -expand -group DUT /loop_divider_tb/DUT/rstn_b_s
add wave -noupdate -expand -group DUT /loop_divider_tb/DUT/clk_cntr
add wave -noupdate -expand -group DUT /loop_divider_tb/DUT/clkb_cntr
add wave -noupdate -expand -group DUT /loop_divider_tb/DUT/div_n_hlf
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2058671 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 140
configure wave -valuecolwidth 40
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3150 ns}
