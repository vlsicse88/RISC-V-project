`timescale 1ns/1ps

module immediate_generator_tb;

    logic [31:0] instruction;
    logic [31:0] immediate;

    immediate_generator uut (
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin

        // I-type: ADDI x5, x1, 10
        instruction = 32'b00000000101000001000001010010011;
        #10;
        $display("I-type  : immediate = %0d (0x%08h)", immediate, immediate);

        // Load: LW x5, 20(x1)
        instruction = 32'b00000001010000001010001010000011;
        #10;
        $display("LOAD    : immediate = %0d (0x%08h)", immediate, immediate);

        // S-type: SW x5, 20(x1)
        instruction = 32'b00000000010100001010101000100011;
        #10;
        $display("S-type  : immediate = %0d (0x%08h)", immediate, immediate);

        // Unknown instruction
        instruction = 32'b11111111111111111111111111111111;
        #10;
        $display("UNKNOWN : immediate = %0d (0x%08h)", immediate, immediate);

        $finish;

    end

endmodule