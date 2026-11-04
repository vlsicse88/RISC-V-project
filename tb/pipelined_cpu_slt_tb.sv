`timescale 1ns/1ps
module pipelined_cpu_slt_tb;
    logic clk, rst;
    pipelined_cpu dut (.clk(clk), .rst(rst));
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        #1;
        dut.normal_program.imem.memory[0] = 32'hFFF00093; // ADDI x1,x0,-1
        dut.normal_program.imem.memory[1] = 32'h00100113; // ADDI x2,x0,1
        dut.normal_program.imem.memory[2] = 32'h0020A1B3; // SLT  x3,x1,x2
        repeat (2) @(negedge clk);
        rst = 0;
        repeat (20) @(posedge clk);
        #1;
        $display("x3 = %0d (expected 1, because -1 < 1)", dut.regfile[3]);
        if (dut.regfile[3] === 32'd1)
            $display("PASS: signed SLT is correct.");
        else begin
            $display("FAIL: SLT treats numbers as unsigned.");
            $fatal(1);
        end
        $finish;
    end
endmodule