iverilog -o run.vvp tb_top.sv
vvp run.vvp
jeff_wave tb_top.vcd --svg -p tb_top/DUT/clk tb_top/DUT/dp/id1/regFile1/