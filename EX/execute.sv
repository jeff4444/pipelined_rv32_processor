module instruction_execute (
    input clk,
    input resetn,
    // input signals
    input [31:0] imm,
    input [31:0] rs1Data,
    input [31:0] rs2Data,
    input [1:0] selOp1,
    input [1:0] selOp2,

    // input signals from forwarding
    input [31:0] aluResultWb,
    input [31:0] wbResult,

    // input control signals for ex
    input ALUSrc,
    input [3:0] ALUOp,

    // output signals
    output [31:0] aluResult,
    output [31:0] aluOperand2
);

    wire [31:0] aluOp1, aluOp2, immORrs2;

    assign aluOperand2 = aluOp2;
    mux_4_to_1 mux1 (
        .op1(rs1Data),
        .op2(wbResult),
        .op3(aluResultWb),
        .op4(32'h0),
        .sel(selOp1),
        .out(aluOp1)
    );

    mux_2_to_1 mux2 (
        .op1(imm),
        .op2(rs2Data),
        .sel(ALUSrc),
        .out(immORrs2)
    );

    mux_4_to_1 mux3 (
        .op1(immORrs2),
        .op2(wbResult),
        .op3(aluResultWb),
        .op4(32'h0),
        .sel(selOp2),
        .out(aluOp2)
    );

    alu alu1 (
        .op1(aluOp1),
        .op2(aluOp2),
        .result(aluResult),
        .alu_op(ALUOp)
    );
endmodule