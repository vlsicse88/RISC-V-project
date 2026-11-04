`timescale 1ns/1ps

module single_cycle_cpu_tb;

    logic clk;
    logic rst;
    integer errors;

    single_cycle_cpu uut (
        .clk(clk),
        .rst(rst)
    );

    // 10 ns clock
    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        errors = 0;

        // Reset CPU
        #12;
        rst = 1'b0;

        // Allow CPU to execute the program
        #50;

        $display("");
        $display("====================================");
        $display("   SINGLE-CYCLE CPU TEST RESULTS");
        $display("====================================");

        // Check register x1
        if (uut.registers.registers[1] !== 32'd5) begin
            $display("FAIL: x1 expected 5, got %0d",
                     uut.registers.registers[1]);
            errors = errors + 1;
        end else begin
            $display("PASS: x1 = 5");
        end

        // Check register x2
        if (uut.registers.registers[2] !== 32'd10) begin
            $display("FAIL: x2 expected 10, got %0d",
                     uut.registers.registers[2]);
            errors = errors + 1;
        end else begin
            $display("PASS: x2 = 10");
        end

        // Check register x3
        if (uut.registers.registers[3] !== 32'd15) begin
            $display("FAIL: x3 expected 15, got %0d",
                     uut.registers.registers[3]);
            errors = errors + 1;
        end else begin
            $display("PASS: x3 = 15");
        end

        // Check register x4
        if (uut.registers.registers[4] !== 32'd15) begin
            $display("FAIL: x4 expected 15, got %0d",
                     uut.registers.registers[4]);
            errors = errors + 1;
        end else begin
            $display("PASS: x4 = 15");
        end

        // Check data memory
        if (uut.data_mem.memory[0] !== 32'd15) begin
            $display("FAIL: Memory[0] expected 15, got %0d",
                     uut.data_mem.memory[0]);
            errors = errors + 1;
        end else begin
            $display("PASS: Memory[0] = 15");
        end

        $display("------------------------------------");

        if (errors == 0) begin
            $display("PASS: All single-cycle CPU checks succeeded.");
        end else begin
            $display("FAIL: %0d check(s) failed.", errors);
        end

        $display("====================================");

        $finish;
    end

    // Debug signals at every rising clock edge
    always @(posedge clk) begin
        #1;
        $display(
            "TIME=%0t | PC=%0d | INSTR=%h | rs1=%0d | rs2=%0d | rd=%0d | reg_write=%b | mem_read=%b | mem_write=%b | rd1=%0d | rd2=%0d | WB=%0d | ALU=%0d | MEM=%0d",
            $time,
            uut.pc,
            uut.instruction,
            uut.rs1,
            uut.rs2,
            uut.rd,
            uut.reg_write,
            uut.mem_read,
            uut.mem_write,
            uut.rd1,
            uut.rd2,
            uut.write_back_data,
            uut.alu_result,
            uut.memory_read_data
        );
    end

endmodule