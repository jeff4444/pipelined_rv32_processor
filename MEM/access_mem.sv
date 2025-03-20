module access_memory (
    input clk,
    input resetn,
    input [31:0] aluOp2,
    input [31:0] aluResult,

    // output control signals for mem
    input memRead,
    input memWrite,

    // output signals
    output [31:0] readData,
);
    data_memory dm1 (
        .clk(clk),
        .addr(aluResult),
        .writeData(aluOp2),
        .writeEnable(memWrite),
        .readEnable(memRead),
        .readData(readData),
        .resetn(resetn)
    );
    
endmodule