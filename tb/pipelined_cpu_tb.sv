
`timescale 1ns/1ps

module pipelined_cpu_tb;

    logic clk;
    logic rst;

    pipelined_cpu dut (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b1;

        repeat (2) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        // Allow instructions to pass through the pipeline.
        repeat (20) @(posedge clk);
        @(negedge clk);

        $display("--------------------------------");
        $display("Pipelined CPU Test Results");
        $display("--------------------------------");
        $display("x1 = %0d", dut.regfile[1]);
        $display("x2 = %0d", dut.regfile[2]);
        $display("x3 = %0d", dut.regfile[3]);
        $display("x4 = %0d", dut.regfile[4]);
        $display("Memory[0] = %0d", dut.dmem.memory[0]);
        $display("--------------------------------");

        if (dut.regfile[1] == 5 &&
            dut.regfile[2] == 10 &&
            dut.regfile[3] == 15 &&
            dut.regfile[4] == 15 &&
            dut.dmem.memory[0] == 15)
            $display("PASS: All expected values match.");
        else
            $display("FAIL: One or more values do not match.");

        $finish;
    end

endmodule