`include "../processor.sv"
`include "../program_counter.sv"
`include "../add_4.sv"
`include "../add.sv"
`include "../alu.sv"
`include "../alu_ctrl.sv"
`include "../control.sv"
`include "../data_mem.sv"
`include "../imm_gen.sv"
`include "../instr_mem.sv"
`include "../mux.sv"
`include "../registers.sv"
`timescale 1ns / 1ps

module tb_processor (
);

    reg clk;
    reg resetn;

    always begin
        #5 clk = ~clk;
    end

    rv32_processor processor (
        .clk(clk),
        .resetn(resetn)
    );

    initial begin
        clk = 0;
        resetn = 0;
        #10 resetn = 1;
        #130 $finish;
    end

    initial begin
        $dumpfile("tb_processor.vcd");
        $dumpvars(0, tb_processor);
    end
    
endmodule