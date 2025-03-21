module if_id (
    input clk,
    input resetn,
    input [31:0] pc,
    input [31:0] instruction,
    input ifIdWrite,
    input IFflush,
    output reg [31:0] pc_out,
    output reg [31:0] instruction_out
);

    // Always block
    always_ff @(posedge clk) begin
        if (!resetn || IFflush) begin
            pc_out <= 32'h0;
            instruction_out <= 32'h0;
        end else begin
            if (ifIdWrite) begin
                pc_reg <= pc;
                instruction_out <= instruction;
            end
        end
    end
endmodule