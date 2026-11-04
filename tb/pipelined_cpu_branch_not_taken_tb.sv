
`timescale 1ns/1ps

module pipelined_cpu_branch_not_taken_tb;

    logic clk;
    logic rst;

    pipelined_cpu #(
        .BRANCH_NOT_TAKEN_TEST(1'b1)
    ) uut (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        $dumpfile("simulation/branch_not_taken.vcd");
        $dumpvars(0, uut);

        #20;
        rst = 0;

        #250;

        $display("--------------------------------");
        $display("BEQ NOT TAKEN TEST RESULTS");
        $display("x1 = %0d (expected 5)", uut.regfile[1]);
        $display("x2 = %0d (expected 3)", uut.regfile[2]);
        $display("x3 = %0d (expected 7)", uut.regfile[3]);
        $display("x4 = %0d (expected 9)", uut.regfile[4]);

        if (uut.regfile[1] == 5 &&
            uut.regfile[2] == 3 &&
            uut.regfile[3] == 7 &&
            uut.regfile[4] == 9)
            $display("PASS: BEQ NOT TAKEN TEST SUCCESSFUL");
        else
            $display("FAIL: BEQ NOT TAKEN TEST FAILED");

        $display("--------------------------------");
        $finish;
    end

endmodule
