module write_back (
    input clk,
    input resetn,
    input [31:0] readData,
    input [31:0] aluResult,
    input memToReg,
    output [31:0] writeData
);
    mux_2_to_1 mux1 (
        .op1(aluResult),
        .op2(readData),
        .sel(memToReg),
        .out(writeData)
    );
endmodule