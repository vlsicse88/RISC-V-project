
`timescale 1ns/1ps

module pipelined_cpu_load_hazard_tb;

    logic clk;
    logic rst;

    // Select the load-use test program inside the CPU.
    pipelined_cpu #(
        .LOAD_HAZARD_TEST(1'b1)
    ) dut (
        .clk(clk),
        .rst(rst)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        $display("--------------------------------");
        $display("LOAD-USE HAZARD TEST");
        $display("--------------------------------");

        rst = 1'b1;
        repeat (2) @(negedge clk);
        rst = 1'b0;

        repeat (20) @(posedge clk);
        #1;

        $display("x1 = %0d", dut.regfile[1]);
        $display("x2 = %0d", dut.regfile[2]);
        $display("x3 = %0d", dut.regfile[3]);
        $display("Memory[0] = %0d", dut.dmem.memory[0]);

        if ((dut.regfile[1] === 32'd5) &&
            (dut.regfile[2] === 32'd5) &&
            (dut.regfile[3] === 32'd10) &&
            (dut.dmem.memory[0] === 32'd5)) begin
            $display("PASS: Load-use hazard test successful.");
        end else begin
            $display("FAIL: Load-use hazard test failed.");
            $fatal(1);
        end

        $display("--------------------------------");
        $finish;
    end

endmodule