`include "../alu.sv"
`include "../add.sv"
`timescale 1ns / 1ps

module tb_add (
);
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] result;

    integer i;

    adder adder1 (
        .op1(a),
        .op2(b),
        .result(result)
    );

    initial begin
        for (i = 0; i < 100; i = i + 1) begin
            a = $random;
            b = $random;
            #1;
            if (result != a + b) begin
                $display("Error: result is not a + b");
            end
        end
    end
endmodule