`include "../ID/registers.sv"

module tb_registers ();
    // Inputs
    reg clk;
    reg resetn;
    reg [4:0] readReg1;
    reg [4:0] readReg2;
    reg [4:0] writeReg;
    reg [31:0] writeData;
    reg regWrite;

    // Outputs
    wire [31:0] readData1;
    wire [31:0] readData2;

    // Instantiate the Unit Under Test (UUT)
    registers uut (
        .clk(clk),
        .resetn(resetn),
        .readReg1(readReg1),
        .readReg2(readReg2),
        .writeReg(writeReg),
        .writeData(writeData),
        .readData1(readData1),
        .readData2(readData2),
        .regWrite(regWrite)
    );



    always #5 clk = ~clk;

    initial begin
        clk = 0;
        resetn = 0;
        #10 resetn = 1;
        #5;
        readReg1 = 0;
        readReg2 = 1;
        writeReg = 1;
        regWrite = 1;
        writeData = 32'hdeadbeef;
        #5;
        if (readData1 !== 0) begin
            $display("Test failed: readData1 is not 0");
            $finish;
        end
        if (readData2 !== 32'hdeadbeef) begin
            $display("Test failed: readData2 is not 32'hdeadbeef");
            $finish;
        end

        #5;

        
        $finish;
    end

    // dump waveforms
    initial begin
        $dumpfile("tb_registers.vcd");
        $dumpvars(0, tb_registers);
    end

endmodule