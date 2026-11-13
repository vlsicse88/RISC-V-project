
`timescale 1ns/1ps

module pipelined_cpu_bne_tb;

    logic clk;
    logic rst;

    pipelined_cpu #(
        .BNE_TEST(1'b1)
    ) uut (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        $dumpfile("simulation/bne_test.vcd");
        $dumpvars(0, uut);

        #20;
        rst = 0;

        #250;

        $display("--------------------------------");
        $display("BNE TEST RESULTS");
        $display("x1 = %0d (expected 5)", uut.regfile[1]);
        $display("x2 = %0d (expected 3)", uut.regfile[2]);
        $display("x3 = %0d (expected 7)", uut.regfile[3]);
        $display("x4 = %0d (expected 9)", uut.regfile[4]);

        if (uut.regfile[1] == 5 &&
            uut.regfile[2] == 3 &&
            uut.regfile[3] == 7 &&
            uut.regfile[4] == 9)
            $display("PASS: BNE TEST SUCCESSFUL");
        else
            $display("FAIL: BNE TEST FAILED");

        $display("--------------------------------");
        $finish;
    end

endmodule
