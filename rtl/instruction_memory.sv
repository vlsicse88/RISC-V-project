module instruction_memory (
    input  logic [31:0] address,
    output logic [31:0] instruction
);

    logic [31:0] memory [0:255];

    initial begin

        // ADDI x1, x0, 5
        memory[0] = 32'h00500093;

        // ADDI x2, x0, 10
        memory[1] = 32'h00A00113;

        // ADD x3, x1, x2
        memory[2] = 32'h002081B3;

        // SW x3, 0(x0)
        memory[3] = 32'h00302023;

        // LW x4, 0(x0)
        memory[4] = 32'h00002203;

    end

    assign instruction = memory[address[9:2]];

endmodule