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