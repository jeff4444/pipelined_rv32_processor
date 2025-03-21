`timescale 1ns / 1ps
`include "../top.sv"
`include "../datapath.sv"
`include "../MEM_WB.sv"
`include "../EX_MEM.sv"
`include "../ID_EX.sv"
`include "../IF_ID.sv"
`include "../mux2to1.sv"
`include "../mux4to1.sv"
`include "../WB/write_back.sv"
`include "../MEM/access_mem.sv"
`include "../MEM/data_mem.sv"
`include "../EX/alu.sv"
`include "../EX/execute.sv"
`include "../ID/imm_gen.sv"
`include "../ID/instr_decode.sv"
`include "../ID/registers.sv"
`include "../IF/instr_fetch.sv"
`include "../IF/instr_mem.sv"
`include "../IF/program_counter.sv"
`include "../controls/hazard_detection_unit.sv"
`include "../controls/forwarding_unit.sv"
`include "../controls/control.sv"
`include "../controls/alu_ctrl.sv"

module tb_top ();
    
    // Inputs
    logic clk;
    logic rstn;
    
    // Instantiate the unit under test (UUT)
    top DUT (
        .clk(clk),
        .resetn(rstn)
    );
    
    always begin
        #5 clk = ~clk;
    end
    
    // Stimulus
    initial begin
        // Initialize Inputs
        clk = 0;
        rstn = 1;
        #10 rstn = 0;
        #20;
        $finish;
    end
endmodule