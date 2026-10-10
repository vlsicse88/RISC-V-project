module data_memory (
    input  logic        clk,
    input  logic        mem_read,
    input  logic        mem_write,
    input  logic [31:0] address,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);

    logic [31:0] memory [0:255];

    integer i;

    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'b0;
    end

    // Combinational read
    assign read_data = mem_read ? memory[address[9:2]] : 32'b0;

    // Synchronous write
    always_ff @(posedge clk) begin
        if (mem_write)
            memory[address[9:2]] <= write_data;
    end

endmodule