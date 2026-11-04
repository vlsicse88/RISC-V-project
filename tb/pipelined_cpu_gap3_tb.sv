`timescale 1ns/1ps
module pipelined_cpu_gap3_tb;
    logic clk, rst;
    pipelined_cpu dut (.clk(clk), .rst(rst));
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        #1;
        dut.normal_program.imem.memory[0] = 32'h00500093; // ADDI x1,x0,5
        dut.normal_program.imem.memory[1] = 32'h00000013; // NOP
        dut.normal_program.imem.memory[2] = 32'h00000013; // NOP
        dut.normal_program.imem.memory[3] = 32'h001081B3; // ADD x3,x1,x1
        repeat (2) @(negedge clk);
        rst = 0;
        repeat (20) @(posedge clk);
        #1;
        $display("x1 = %0d", dut.regfile[1]);
        $display("x3 = %0d (expected 10)", dut.regfile[3]);
        if (dut.regfile[1] === 32'd5 && dut.regfile[3] === 32'd10)
            $display("PASS: gap-of-3 read is correct.");
        else begin
            $display("FAIL: gap-of-3 read is stale.");
            $fatal(1);
        end
        $finish;
    end
endmodule