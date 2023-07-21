transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/IITB-CPU Project/statetransition.vhd}
vcom -93 -work work {D:/IITB-CPU Project/comparator.vhd}
vcom -93 -work work {D:/IITB-CPU Project/shifter7.vhd}
vcom -93 -work work {D:/IITB-CPU Project/priorityencoder.vhd}
vcom -93 -work work {D:/IITB-CPU Project/tempreg.vhd}
vcom -93 -work work {D:/IITB-CPU Project/structure.vhd}
vcom -93 -work work {D:/IITB-CPU Project/seq_extender.vhd}
vcom -93 -work work {D:/IITB-CPU Project/se9_16.vhd}
vcom -93 -work work {D:/IITB-CPU Project/se7_16.vhd}
vcom -93 -work work {D:/IITB-CPU Project/regfile.vhd}
vcom -93 -work work {D:/IITB-CPU Project/memory.vhd}
vcom -93 -work work {D:/IITB-CPU Project/decode_3_8.vhd}
vcom -93 -work work {D:/IITB-CPU Project/alu.vhd}
vcom -93 -work work {D:/IITB-CPU Project/cpu.vhd}

vcom -93 -work work {D:/IITB-CPU Project/clock_divider_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  clock_divider_tb

add wave *
view structure
view signals
run -all
