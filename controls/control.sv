module control_n (
    input [6:0] opcode,
    output branch,
    output memWrite,
    output memRead,
    output regWrite,
    output [1:0] aluOp,
    output memToReg,
    output aluSrc
);

    wire temp1;
    wire temp2;

    assign temp1 = ~opcode[4] & opcode[6];
    assign temp2 = ~opcode[4] & opcode[5] & ~opcode[6];


    assign aluSrc = ~opcode[5] | (temp2);
    assign memToReg = ~opcode[4];
    assign regWrite = ~opcode[5] | opcode[4];
    assign memRead = ~opcode[5];
    assign memWrite = ~opcode[4] & opcode[5] & ~opcode[6];
    assign branch = temp1;
    assign aluOp = {opcode[4], temp1};
endmodule


module control (
    input [6:0] opcode,
    output reg branch,
    output reg memWrite,
    output reg memRead,
    output reg regWrite,
    output reg [1:0] aluOp,
    output reg memToReg,
    output reg aluSrc
);

    always @(*) begin
        $display("opcode: %b", opcode);
        case (opcode)
            7'b0110011: begin // R-type
                branch = 0;
                memWrite = 0;
                memRead = 0;
                regWrite = 1;
                aluOp = 2'b10;
                memToReg = 0;
                aluSrc = 0;
            end
            7'b0000011: begin // LW 
                branch = 0;
                memWrite = 0;
                memRead = 1;
                regWrite = 1;
                aluOp = 2'b00;
                memToReg = 1;
                aluSrc = 1;
            end
            7'b0100011: begin // SW
                branch = 0;
                memWrite = 1;
                memRead = 0;
                regWrite = 0;
                aluOp = 2'b00;
                memToReg = 0;
                aluSrc = 1;
            end
            7'b1100011: begin // BEQ
                branch = 1;
                memWrite = 0;
                memRead = 0;
                regWrite = 0;
                aluOp = 2'b01;
                memToReg = 0;
                aluSrc = 0;
            end
            default: begin
                branch = 0;
                memWrite = 0;
                memRead = 0;
                regWrite = 0;
                aluOp = 2'b00;
                memToReg = 0;
                aluSrc = 0;
            end
        endcase
    end
endmodule