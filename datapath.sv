module datapath (
    input clk,
    input resetn,

    // control signals for if stage
    input branch,

    // control signals for ex stage
    input ALUSrc,
    input [3:0] ALUOp,
    input [1:0] selOp1,
    input [1:0] selOp2,

    // control signals for mem stage
    input memRead,
    input memWrite,

    // control signals for wb stage
    input memToReg,
    input regWrite,

    // signals from hazard detection unit for stalling
    input pcWrite,
    input ifIdWrite

    // outputs
    output [31:0] instruction
    output memReadExOut,
    output [4:0] rs1Id,
    output [4:0] rs2Id,
    output [4:0] rdEx,
    output pcsrc
);

    // signals for if stage
    wire [31:0] instruction_if;
    wire [31:0] instruction_id;
    wire [31:0] pc_if;
    wire [31:0] pc_plus_imm;

    // signals for id stage
    wire [31:0] pc_id;
    wire [4:0] rs1_id;
    wire [4:0] rs2_id;
    wire [31:0] imm_id;
    wire [4:0] rd_id;
    wire [31:0] rs1_data_id;
    wire [31:0] rs2_data_id;
    wire registersIsEqual;

    // control signals for ex stage
    wire ALUSrcEx,
    wire [3:0] ALUOpEx,

    // control signals for mem stage from ex stage
    wire memReadEx,
    wire memWriteEx,
    wire memToRegEx,
    wire regWriteEx,

    // signals for ex stage
    wire [4:0] rs1_ex;
    wire [4:0] rs2_ex;
    wire [31:0] imm_ex;
    wire [4:0] rd_ex;
    wire [31:0] rs1_data_ex;
    wire [31:0] rs2_data_ex;
    wire [31:0] aluResult;
    wire [31:0] aluOperand2;

    // control signals for mem stage from ex stage
    wire memReadMem,
    wire memWriteMem,
    wire memToRegMem,
    wire regWriteMem,

    // signals for mem stage
    wire [4:0] rd_mem;
    wire [31:0] readData;
    wire [31:0] aluResultMem;
    wire [31:0] aluOperand2Mem;

    // control signals for wb stage from mem stage
    wire memToRegWb,
    wire regWriteWb,

    // signals for wb stage
    wire [31:0] readDataWb;
    wire [31:0] aluResultWb;
    wire [31:0] writeData;
    wire [4:0] rd_wb;

    wire pcSrc;

    assign pcSrc = branch & registersIsEqual;

    assign memReadExOut = memReadEx;
    assign rs1Id = rs1_id;
    assign rs2Id = rs2_id;
    assign rdEx = rd_ex;
    assign pcsrc = pcSrc;

    // if stage
    instruction_fetch if1 (
        .clk(clk),
        .resetn(resetn),
        .pcSrc(pcSrc)
        .pcWrite(pcWrite),
        .pc_plus_imm(pc_plus_imm),
        .pc_out(pc_if),
        .instruction_out(instruction_if)
    );

    if_id if_id1 (
        .clk(clk),
        .resetn(resetn),
        .pc(pc),
        .ifIdWrite(ifIdWrite),
        .instruction(instruction_if),
        .pc_out(pc_id),
        .instruction_out(instruction_id)
    );

    // id stage
    instruction_decode id1 (
        .clk(clk),
        .resetn(resetn),
        .pc(pc_id),
        .instruction(instruction_id),
        .regWriteData(writeData),
        .writeReg(rd_wb),
        .regWrite(regWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd_id),
        .imm(imm_id),
        .rs1Data(rs1_data_id),
        .rs2Data(rs2_data_id),
        .registersIsEqual(registersIsEqual)
    );

    id_ex id_ex1 (
        .clk(clk),
        .resetn(resetn),
        .rs1(rs1_id),
        .rs2(rs2_id),
        .imm(imm_id),
        .rs1Data(rs1_data_id),
        .rs2Data(rs2_data_id),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp),
        .memRead(memRead),
        .memWrite(memWrite),
        .memToReg(memToReg),
        .regWrite(regWrite)
        .immOut(imm_ex),
        .rs1DataOut(rs1_data_ex),
        .rs2DataOut(rs2_data_ex),
        .rs1Out(rs1_ex),
        .rs2Out(rs2_ex),
        .rdOut(rd_ex),
        .ALUSrcOut(ALUSrcEx),
        .ALUOpOut(ALUOpEx),
        .memReadOut(memReadEx),
        .memWriteOut(memWriteEx),
        .memToRegOut(memToRegEx),
        .regWriteOut(regWriteEx)
    );

    // ex stage
    instruction_execute ex1 (
        .clk(clk),
        .resetn(resetn),
        .rs1Data(rs1_data_ex),
        .rs2Data(rs2_data_ex),
        .imm(imm_ex),
        .selOp1(selOp1),
        .selOp2(selOp2),
        .aluResult(aluResult),
        .wbResult(writeData),
        .ALUSrc(ALUSrcEx),
        .ALUOp(ALUOpEx),
        .aluResult(aluResult),
        .aluOperand2(aluOperand2)
    );

    ex_mem ex_mem1 (
        .clk(clk),
        .resetn(resetn),
        .aluResult(aluResult),
        .aluOperand2(aluOperand2),
        .rd(rd_ex),
        .memRead(memReadEx),
        .memWrite(memWriteEx),
        .memToReg(memToRegEx),
        .regWrite(regWriteEx),
        .aluResultOut(aluResultMem),
        .rdOut(rd_mem),
        .aluOperand2Out(aluOperand2Mem),
        .memReadOut(memReadMem),
        .memWriteOut(memWriteMem),
        .memToRegOut(memToRegMem),
        .regWriteOut(regWriteMem)
    );

    // mem stage
    access_memory mem1 (
        .clk(clk),
        .resetn(resetn),
        .aluOp2(aluOperand2Mem),
        .aluResult(aluResultMem),
        .memRead(memReadMem),
        .memWrite(memWriteMem),
        .readData(readData)
    );
    
    mem_wb mem_wb1 (
        .clk(clk),
        .resetn(resetn),
        .readData(readData),
        .aluResult(aluResult),
        .rd(rd_mem),
        .memToReg(memToRegMem),
        .regWrite(regWriteMem),
        .readDataOut(readDataWb),
        .aluResultOut(aluResultWb),
        .rdOut(rd_wb),
        .memToRegOut(memToRegWb),
        .regWriteOut(regWriteWb)
    );

    // wb stage
    write_back wb1 (
        .clk(clk),
        .resetn(resetn),
        .readData(readDataWb),
        .aluResult(aluResultWb),
        .memToReg(memToRegWb),
        .writeData(writeData),
    );
    
endmodule