module top (
    input clk,
    input resetn
);
    // control signals for if stage
    wire branch;
    wire [31:0] instruction;

    // signals for id stage
    wire [4:0] rs1_id;
    wire [4:0] rs2_id;

    // control signals for ex stage
    wire ALUSrc;
    wire [3:0] ALUOp;
    wire [1:0] ALUOpSel;
    wire memReadEx;
    wire [4:0] rd_ex;

    // control signals for mem stage
    wire memRead;
    wire memWrite;

    // control signals for wb stage
    wire memToReg;
    wire regWrite;

    // signals from hazard detection unit for stalling
    wire pcWrite;
    wire ifIdWrite;

    wire selectNOP;
    wire IFflush;
    wire pcSrc;

    wire [4:0] rs1_ex;
    wire [4:0] rs2_ex;
    wire [4:0] rd_mem;
    wire [4:0] rd_wb;
    wire regWriteMem;
    wire regWriteWb;
    wire [1:0] forwardA;
    wire [1:0] forwardB;

    datapath dp (
        .clk(clk),
        .resetn(resetn),
        .branch(branch),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp),
        .selOp1(forwardA),
        .selOp2(forwardB),
        .memRead(memRead),
        .memWrite(memWrite),
        .memToReg(memToReg),
        .regWrite(regWrite),
        .pcWrite(pcWrite),
        .ifIdWrite(ifIdWrite),
        .instruction(instruction),
        .memReadExOut(memReadEx),
        .rs1Id(rs1_id),
        .rs2Id(rs2_id),
        .rdEx(rd_ex),
        .pcsrc(pcSrc)
    );

    alu_control alu_ctrl (
        .instruction(instruction),
        .alu_op_sel(ALUOpSel),
        .alu_op(ALUOp)
    );

    control ctrl (
        .opcode(instruction[6:0]),
        .branch(branch),
        .memWrite(memWrite),
        .memRead(memRead),
        .regWrite(regWrite),
        .aluOp(ALUOpSel),
        .memToReg(memToReg),
        .aluSrc(ALUSrc)
    );

    hazard_detection_unit hdu (
        .memReadEx(memReadEx),
        .rd_ex(rd_ex),
        .rs1_id(rs1_id),
        .rs2_id(rs2_id),
        .pcSrc(pcSrc),
        .pcWrite(pcWrite),
        .ifIdWrite(ifIdWrite),
        .selectNOP(selectNOP),
        .IFflush(IFflush)
    );

    forwarding_unit fu (
        .rs1_ex(rs1_ex),
        .rs2_ex(rs2_ex),
        .rd_mem(rd_mem),
        .rd_wb(rd_wb),
        .regWriteMem(regWriteMem),
        .regWriteWb(regWriteWb),
        .forwardA(forwardA),
        .forwardB(forwardB)
    );
endmodule