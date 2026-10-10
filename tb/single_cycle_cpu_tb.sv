`timescale 1ns/1ps

module single_cycle_cpu_tb;

    logic clk;
    logic rst;

    // =================================================
    // CPU INSTANCE
    // =================================================
    single_cycle_cpu uut (
        .clk(clk),
        .rst(rst)
    );

    // =================================================
    // 10 ns CLOCK
    // =================================================
    always #5 clk = ~clk;

    // =================================================
    // TEST
    // =================================================
    initial begin

        clk = 1'b0;
        rst = 1'b1;

        // -------------------------
        // Reset CPU
        // -------------------------
        #12;
        rst = 1'b0;

        // -------------------------
        // Let CPU execute
        // -------------------------
        #50;

        // -------------------------
        // Final values
        // -------------------------
        $display("");
        $display("====================================");
        $display("       FINAL CPU VALUES");
        $display("====================================");

        $display("x1 = %0d",
                 uut.registers.registers[1]);

        $display("x2 = %0d",
                 uut.registers.registers[2]);

        $display("x3 = %0d",
                 uut.registers.registers[3]);

        $display("x4 = %0d",
                 uut.registers.registers[4]);

        $display("Memory[0] = %0d",
                 uut.data_mem.memory[0]);

        $display("====================================");

        $finish;

    end

    // =================================================
    // DEBUG EVERY CLOCK
    // =================================================
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