`include "test.sv"
module tb_test (

);
    reg clk;
    reg rstn;
    reg [2:0] in;
    wire [2:0] out;

    always begin
        #5 clk = ~clk;
    end

    initial begin
        // Initialize Inputs
        clk = 0;
        rstn = 1;
        #10 rstn = 0;
        #10 in = 3'b010;
        #10 in = 3'b011;
        #200;
        $finish;
    end

    test DUT (
        .clk(clk),
        .rst(rstn),
        .in(in),
        .out(out)
    );

    // dump waveforms
    initial begin
        $dumpfile("tb_test.vcd");
        $dumpvars(0, tb_test);
    end

endmodule