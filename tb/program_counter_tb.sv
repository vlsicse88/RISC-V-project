`timescale 1ns/1ps

module program_counter_tb;

    logic        clk;
    logic        rst;
    logic [31:0] next_pc;
    logic [31:0] pc;

    program_counter uut (
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .pc(pc)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin

        clk = 1'b0;
        rst = 1'b1;
        next_pc = 32'd0;

        // Reset
        #10;
        $display("After reset : PC = %0d", pc);

        // First next PC
        rst = 1'b0;
        next_pc = 32'd4;
        #10;
        $display("Step 1      : PC = %0d", pc);

        // Second next PC
        next_pc = 32'd8;
        #10;
        $display("Step 2      : PC = %0d", pc);

        // Third next PC
        next_pc = 32'd12;
        #10;
        $display("Step 3      : PC = %0d", pc);

        $finish;

    end

endmodule