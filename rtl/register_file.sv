module register_file (
    input  logic        clk,
    input  logic        rst,

    // Read ports
    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    output logic [31:0] rd1,
    output logic [31:0] rd2,

    // Write port
    input  logic        reg_write,
    input  logic [4:0]  rd,
    input  logic [31:0] write_data
);

    // 32 registers, each 32 bits wide
    logic [31:0] registers [0:31];

    integer i;

    // Reset and write operation
    always_ff @(posedge clk) begin

        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end

        else if (reg_write && (rd != 5'b00000)) begin
            registers[rd] <= write_data;
        end

    end

    // Read operations
    assign rd1 = (rs1 == 5'b00000) ? 32'b0 : registers[rs1];
    assign rd2 = (rs2 == 5'b00000) ? 32'b0 : registers[rs2];

endmodule