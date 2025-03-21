module registers (
    input clk,
    input resetn,
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    input regWrite
);

    reg [31:0] regFile [31:0];

    // attach wires to all register values
    wire [31:0] reg0;
    wire [31:0] reg1;
    wire [31:0] reg2;
    wire [31:0] reg3;
    wire [31:0] reg4;
    wire [31:0] reg5;
    wire [31:0] reg6;
    wire [31:0] reg7;

    assign reg0 = regFile[0];
    assign reg1 = regFile[1];
    assign reg2 = regFile[2];
    assign reg3 = regFile[3];
    assign reg4 = regFile[4];
    assign reg5 = regFile[5];
    assign reg6 = regFile[6];
    assign reg7 = regFile[7];

    always @(posedge clk) begin
        if (!resetn) begin
            for (integer i = 0; i < 32; i = i + 1) begin
                regFile[i] <= 0;
            end
        end else begin
            if (regWrite) begin
                if (writeReg != 0) begin
                    regFile[writeReg] <= writeData;
                end
            end
        end
    end

    always @(negedge clk) begin
        readData1 <= regFile[readReg1];
        readData2 <= regFile[readReg2];
    end
    
endmodule