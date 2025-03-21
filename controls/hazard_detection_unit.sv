module hazard_detection_unit (
    input memReadEx, // set high if memory is being read (lw)
    input [4:0] rd_ex,
    input [4:0] rs1_id,
    input [4:0] rs2_id,
    input pcSrc,
    output reg pcWrite,
    output reg ifIdWrite,
    output reg selectNOP,
    output reg IFflush
);

    always @(*) begin
        pcWrite = 0;
        ifIdWrite = 0;
        selectNOP = 0;
        IFflush = 0;

        if (memReadEx && (rd_ex != 0) && ((rd_ex == rs1_id) || (rd_ex == rs2_id))) begin
            pcWrite = 1;
            ifIdWrite = 1;
            selectNOP = 1;
        end

        if (pcSrc) begin
            IFflush = 1;
            selectNOP = 1;
        end
    end
endmodule