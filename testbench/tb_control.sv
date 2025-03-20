`include "../control.sv"

module tb_control (
);
    reg [6:0] opcode;
    reg branch;
    reg memWrite;
    reg memRead;
    reg regWrite;
    reg [1:0] aluOp;
    reg memToReg;
    reg aluSrc;

    control control1 (
        .opcode(opcode),
        .branch(branch),
        .memWrite(memWrite),
        .memRead(memRead),
        .regWrite(regWrite),
        .aluOp(aluOp),
        .memToReg(memToReg),
        .aluSrc(aluSrc)
    );

    
endmodule