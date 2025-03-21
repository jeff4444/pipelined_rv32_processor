module forwarding_unit(
    input [4:0] rs1_ex,
    input [4:0] rs2_ex,
    input [4:0] rd_mem,
    input [4:0] rd_wb,
    input regWriteMem,
    input regWriteWb,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);

    always @(*) begin
        forwardA = 0;
        forwardB = 0;

        if (regWriteMem && rd_mem != 0) begin
            if (rd_mem == rs1_ex) begin
                forwardA = 2'b10;
            end
            if (rd_mem == rs2_ex) begin
                forwardB = 2'b10;
            end
        end

        if (regWriteWb && rd_wb != 0) begin
            if (rd_wb == rs1_ex) begin
                forwardA = 2'b01;
            end
            if (rd_wb == rs2_ex) begin
                forwardB = 2'b01;
            end
        end
    end
endmodule