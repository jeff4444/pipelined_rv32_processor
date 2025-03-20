module mux_4_to_1 (
    input [31:0] op1,
    input [31:0] op2,
    input [31:0] op3,
    input [31:0] op4,
    input [1:0] sel,
    output reg [31:0] out
);
    always @(*) begin
        case(sel)
            2'b00: out = op1;
            2'b01: out = op2;
            2'b10: out = op3;
            2'b11: out = op4;
        endcase
    end
endmodule