module alu (
    input [31:0] op1,
    input [31:0] op2,
    input [3:0] alu_op,
    output reg [31:0] result
);
    always @(*) begin
        case (alu_op)
            4'b0000: result = op1 & op2;
            4'b0001: result = op1 | op2;
            4'b0010: result = op1 + op2;
            4'b0110: result = op1 - op2;
            default: result = 32'h0;
        endcase
    end
    
endmodule