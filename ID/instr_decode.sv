module instruction_decode (
    input clk,
    input resetn,
    // input signals
    input [31:0] pc,
    input [31:0] instruction,

    // input signals from wb
    input [31:0] regWriteData,
    input [4:0] writeReg,
    // control signals for id stage
    input regWrite,
    // output signals
    output [31:0] pc_plus_imm,
    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd,
    output [31:0] imm,
    output [31:0] rs1Data,
    output [31:0] rs2Data,
    output registersIsEqual
);
    wire [31:0] immediate;

    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd = instruction[11:7];
    assign registersIsEqual = (instruction[19:15] == instruction[24:20]);
    assign pc_plus_imm = pc + immediate;
    assign imm = immediate;

    registers regFile1 (
        .clk(clk),
        .resetn(resetn),
        .readReg1(instruction[19:15]),
        .readReg2(instruction[24:20]),
        .writeReg(writeReg),
        .writeData(regWriteData),
        .readData1(rs1Data),
        .readData2(rs2Data),
        .regWrite(regWrite)
    );

    immediate_gen imm1 (
        .instruction(instruction),
        .immediate(immediate)
    );
    
endmodule