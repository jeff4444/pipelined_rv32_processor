module test (
    input clk,
    input rst,
    input [2:0] in,
    output reg [2:0] out
);

    // dff
    reg [2:0] dff_q;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            dff_q <= 1'b0;
        end else begin
            dff_q <= in;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 1'b0;
        end else begin
            out <= dff_q;
        end
    end
    
endmodule