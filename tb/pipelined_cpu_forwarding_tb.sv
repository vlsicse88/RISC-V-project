
`timescale 1ns/1ps

module pipelined_cpu_forwarding_tb;

    logic clk;
    logic rst;

    pipelined_cpu #(
        .FORWARDING_TEST(1'b1)
    ) dut (
        .clk(clk),
        .rst(rst)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1'b1;
        repeat (2) @(negedge clk);
        rst = 1'b0;

        repeat (15) @(posedge clk);
        #1;

        $display("DATA FORWARDING TEST RESULTS");
        $display("x1 = %0d", dut.regfile[1]);
        $display("x2 = %0d", dut.regfile[2]);
        $display("x3 = %0d", dut.regfile[3]);

        if (dut.regfile[1] == 5 &&
            dut.regfile[2] == 8 &&
            dut.regfile[3] == 13) begin
            $display("PASS: Forwarding test successful.");
        end else begin
            $display("FAIL: Check forwarding logic.");
            $fatal(1);
        end

        $finish;
    end

endmodule