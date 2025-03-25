module top (
    input clk,
    input resetn
);
    // control signals for if stage
    wire branch;
    wire branchCtrl;
    wire [31:0] instruction;

    // signals for id stage
    wire [4:0] rs1_id;
    wire [4:0] rs2_id;

    // control signals for ex stage
    wire ALUSrc;
    wire ALUSrcCtrl;
    wire [3:0] ALUOp;
    wire [3:0] ALUOpCtrl;
    wire [1:0] ALUOpSel;
    wire memReadEx;
    wire [4:0] rd_ex;

    // control signals for mem stage
    wire memRead;
    wire memWrite;
    wire memReadCtrl;
    wire memWriteCtrl;

    // control signals for wb stage
    wire memToReg;
    wire memToRegCtrl;
    wire regWrite;
    wire regWriteCtrl;
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

    wire [9:0] controlSignals;

    assign controlSignals = {branchCtrl, memReadCtrl, memWriteCtrl, regWriteCtrl, ALUOpCtrl, memToRegCtrl, ALUSrcCtrl};

    wire [9:0] datapathControlSignals;

    assign {branch, memRead, memWrite, regWrite, ALUOp, memToReg, ALUSrc} = datapathControlSignals;

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
        .pcsrc(pcSrc),
        .rs1Ex(rs1_ex),
        .rs2Ex(rs2_ex),
        .rdMem(rd_mem),
        .rdWb(rd_wb),
        .regWriteMemm(regWriteMem),
        .regWriteWbb(regWriteWb)
    );

    alu_control alu_ctrl (
        .instruction(instruction),
        .alu_op_sel(ALUOpSel),
        .alu_op(ALUOpCtrl)
    );

    control ctrl (
        .opcode(instruction[6:0]),
        .branch(branchCtrl),
        .memWrite(memWriteCtrl),
        .memRead(memReadCtrl),
        .regWrite(regWriteCtrl),
        .aluOp(ALUOpSel),
        .memToReg(memToRegCtrl),
        .aluSrc(ALUSrcCtrl)
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

    mux_2_to_1 #(
        .WIDTH(10)
    ) mux1 (
        .op1(controlSignals),
        .op2(10'b0),
        .sel(selectNOP),
        .out(datapathControlSignals)
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