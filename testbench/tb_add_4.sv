`include "../add_4.sv"
`include "../alu.sv"
`include "../add.sv"
`timescale 1ns / 1ps

module tb_add_4 (
);
    reg [31:0] a;

    wire [31:0] result;

    integer i;

    increment_by_4 increment_by_41 (
        .pc(a),
        .result(result)
    );

    initial begin
        for (i = 0; i < 100; i = i + 1) begin
            a = $random;
            #1;
            if (result != a + 4) begin
                $display("Error: result is not a + 4");
            end
        end
    end
endmodule