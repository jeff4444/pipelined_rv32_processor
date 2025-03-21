module instruction_fetch (
    input clk,
    input resetn,
    input [31:0] pc_plus_imm,
    input pcSrc,
    input pcWrite,
    output [31:0] pc_out,
    output [31:0] instruction_out
);

    wire [31:0] pc;
    wire [31:0] pc_out_reg;
    wire [31:0] pc_plus_4;

    assign pc_plus_4 = pc_out_reg + 32'h4;
    assign pc_out = pc_out_reg;

    mux_2_to_1 mux (
        .op1(pc_plus_imm),
        .op2(pc_plus_4),
        .sel(pcSrc),
        .out(pc)
    );

    program_counter pc_inst (
        .clk(clk),
        .resetn(resetn),
        .pc_next(pc),
        .pcWrite(pcWrite),
        .pc_prev(pc_out_reg)
    );

    intruction_memory im (
        .clk(clk),
        .resetn(resetn),
        .address(pc_out_reg),
        .instruction(instruction_out)
    );
endmodule