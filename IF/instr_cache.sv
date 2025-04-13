module instr_cache_n_way #(
    parameter integer ADDRESS_WIDTH = 32,
    parameter integer N = 4, // Number of ways (blocks per set)
    parameter integer WORDS_PER_BLOCK = 4, // Size of each block in words
    parameter integer NUM_BLOCKS = 16 // Number of blocks in the cache
    parameter integer WORD_SIZE = 4, // Size of each word in bytes

) (
    input clk,
    input resetn,
    input [ADDRESS_WIDTH-1:0] address,
    output reg [31:0] instruction,
    output reg hit,    
);
    parameter integer NUM_SETS = NUM_BLOCKS / N;
    parameter integer INDEX_OFFSET_SIZE = $clog2(NUM_SETS);
    parameter integer BLOCK_OFFSET_SIZE = $clog2(WORDS_PER_BLOCK);
    parameter integer BYTE_OFFSET_SIZE = $clog2(WORD_SIZE);
    parameter integer TAG_SIZE = ADDRESS_WIDTH - INDEX_OFFSET_SIZE - BLOCK_OFFSET_SIZE - BYTE_OFFSET_SIZE;

    parameter integer SIZE_OF_BLOCK = WORDS_PER_BLOCK * WORD_SIZE; // Size of each block in bytes
    parameter integer SIZE_OF_CACHE_INDEX_BITS = (SIZE_OF_BLOCK * 8) + TAG_SIZE + 1;

    // Cache memory
    reg [0 : SIZE_OF_CACHE_INDEX_BITS - 1] cache [0 : NUM_SETS - 1][0 : N - 1]

    wire [INDEX_OFFSET_SIZE-1:0] index;
    wire [BLOCK_OFFSET_SIZE-1:0] block_offset;
    wire [BYTE_OFFSET_SIZE-1:0] byte_offset;
    wire [TAG_SIZE-1:0] tag;


    byte_offset = address[BYTE_OFFSET_SIZE-1:0];
    block_offset = address[BLOCK_OFFSET_SIZE + BYTE_OFFSET_SIZE - 1 : BYTE_OFFSET_SIZE];
    index = address[INDEX_OFFSET_SIZE + BLOCK_OFFSET_SIZE + BYTE_OFFSET_SIZE + 1 : BLOCK_OFFSET_SIZE + BYTE_OFFSET_SIZE];
    tag = address[ADDRESS_WIDTH - 1 : INDEX_OFFSET_SIZE + BLOCK_OFFSET_SIZE + BYTE_OFFSET_SIZE];



    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // Initialize cache memory
            for (integer i = 0; i < NUM_SETS; i = i + 1) begin
                for (integer j = 0; j < N; j = j + 1) begin
                    cache[i][j] <= {SIZE_OF_CACHE_INDEX_BITS{1'b0}};
                end
            end
        end else begin
            // Check for hit/miss and read instruction from cache
            hit = 0;
            for (integer i = 0; i < N; i = i + 1) begin
                if (cache[index][i][1 : TAG_SIZE] == tag && cache[index][i][0]) begin
                    instruction <= cache[index][i][TAG_SIZE + 1 + (block_offset << 5) : TAG_SIZE + 1 + (block_offset << 5) + 31];
                    hit <= 1;
                    break;
                end
            end

            // If miss, fetch from memory and update cache (not implemented in this snippet)
        end
    end
endmodule