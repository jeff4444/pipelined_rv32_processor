iverilog -o run.vvp tb_top.sv
vvp run.vvp
jeff_wave tb_top.vcd --svg -p tb_top/DUT/dp/id1 tb_top/DUT/dp/id1/regFile1
# jeff_wave tb_top.vcd --svg --end_time 5s -p tb_top/DUT/clk tb_top/DUT/dp/ex1
# jeff_wave tb_top.vcd --svg -p tb_top/DUT/clk tb_top/DUT/dp/id1/regFile1/
# jeff_wave tb_top.vcd --svg -p tb_top/DUT/clk tb_top/DUT/dp/ex1/ tb_top/DUT/fu/ tb_top/DUT/dp/wb1/

# jeff_wave tb_top.vcd --svg -p tb_top/DUT/dp/id1/regFile1/reg0 tb_top/DUT/dp/id1/regFile1/reg1 tb_top/DUT/dp/id1/regFile1/reg2 tb_top/DUT/dp/id1/regFile1/reg3 tb_top/DUT/dp/id1/regFile1/reg4 tb_top/DUT/dp/id1/regFile1/reg5 tb_top/DUT/dp/id1/regFile1/reg6 tb_top/DUT/dp/id1/regFile1/reg7

# jeff_wave tb_top.vcd --svg -p tb_top/DUT/clk tb_top/DUT/dp/resetn tb_top/DUT/dp/instruction_if tb_top/DUT/dp/rs1_id tb_top/DUT/dp/rs2_id tb_top/DUT/dp/rd_id tb_top/DUT/dp/rd_ex tb_top/DUT/dp/rd_mem tb_top/DUT/dp/rd_wb tb_top/DUT/dp/rs1_data_id tb_top/DUT/dp/rs2_data_id tb_top/DUT/dp/aluResult tb_top/DUT/dp/readData tb_top/DUT/dp/writeData tb_top/DUT/fu/forwardA tb_top/DUT/fu/forwardB