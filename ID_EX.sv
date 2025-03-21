module id_ex (
    input clk,
    input resetn,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] imm,
    input [31:0] rs1Data,
    input [31:0] rs2Data,
    // control signals for ex stage
    input ALUSrc,
    input [3:0] ALUOp,
    // control signals for mem stage
    input memRead,
    input memWrite,
    // control signals for wb stage
    input memToReg,
    input regWrite,
    // output signals
    output reg [31:0] immOut,
    output reg [31:0] rs1DataOut,
    output reg [31:0] rs2DataOut,
    output reg [31:0] rs1Out,
    output reg [31:0] rs2Out,
    output reg [31:0] rdOut,

    // output control signals for ex, mem and wb
    output reg ALUSrcOut,
    output reg [3:0] ALUOpOut,
    output reg memReadOut,
    output reg memWriteOut,
    output reg memToRegOut,
    output reg regWriteOut,
);
    
    always @(posedge clk) begin
        if(!resetn) begin
            immOut <= 0;
            rs1DataOut <= 0;
            rs2DataOut <= 0;
            rs1Out <= 0;
            rs2Out <= 0;
            rdOut <= 0;
            ALUSrcOut <= 0;
            ALUOpOut <= 0;
            memReadOut <= 0;
            memWriteOut <= 0;
            memToRegOut <= 0;
            regWriteOut <= 0;
        end
        else begin
            immOut <= imm;
            rs1DataOut <= rs1Data;
            rs2DataOut <= rs2Data;
            rs1Out <= rs1;
            rs2Out <= rs2;
            rdOut <= rd;
            ALUSrcOut <= ALUSrc;
            ALUOpOut <= ALUOp;
            memReadOut <= memRead;
            memWriteOut <= memWrite;
            memToRegOut <= memToReg;
            regWriteOut <= regWrite;
        end
    end
    
endmodule