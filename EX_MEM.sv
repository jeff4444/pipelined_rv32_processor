module ex_mem (
    input clk,
    input resetn,
    input [31:0] aluResult,
    input [31:0] aluOperand2,
    input [4:0] rd,
    // control signals for mem stage
    input memRead,
    input memWrite,
    // control signals for wb stage
    input memToReg,
    input regWrite,
    // output signals
    output reg [31:0] aluResultOut,
    output reg [4:0] rdOut,
    output reg [31:0] aluOperand2Out,

    // output control signals for mem and wb
    output reg memReadOut,
    output reg memWriteOut,
    output reg memToRegOut,
    output reg regWriteOut
);

    always @(posedge clk) begin
        if(!resetn) begin
            aluResultOut <= 0;
            rdOut <= 0;
            aluOperand2Out <= 0;
            memReadOut <= 0;
            memWriteOut <= 0;
            memToRegOut <= 0;
            regWriteOut <= 0;
        end
        else begin
            aluResultOut <= aluResult;
            rdOut <= rd;
            aluOperand2Out <= aluOperand2;
            memReadOut <= memRead;
            memWriteOut <= memWrite;
            memToRegOut <= memToReg;
            regWriteOut <= regWrite;
        end
    end
    
endmodule