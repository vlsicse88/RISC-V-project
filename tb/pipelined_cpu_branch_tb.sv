`timescale 1ns/1ps

module pipelined_cpu_branch_tb;
    logic clk;
    logic rst;

    pipelined_cpu #(.BRANCH_TEST(1'b1)) dut (
        .clk(clk),
        .rst(rst)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        rst = 1'b1;
        repeat (2) @(posedge clk);
        rst = 1'b0;

        repeat (15) @(posedge clk);
        #1;

        $display("BRANCH TEST RESULTS");
        $display("x1 = %0d (expected 5)", dut.regfile[1]);
        $display("x2 = %0d (expected 0; wrong path flushed)", dut.regfile[2]);
        $display("x3 = %0d (expected 7)", dut.regfile[3]);

        if (dut.regfile[1] == 5 && dut.regfile[2] == 0 && dut.regfile[3] == 7)
            $display("PASS: Branch test successful.");
        else
            $display("FAIL: Branch test did not match expected values.");

        $finish;
    end
endmodule
