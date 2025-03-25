module mux_2_to_1 #(
    parameter WIDTH = 32
)
(
    input [WIDTH - 1:0] op1,
    input [WIDTH - 1:0] op2,
    input sel,
    output [WIDTH - 1:0] out
);
    assign out = sel ? op2 : op1;
endmodule