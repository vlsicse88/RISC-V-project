`timescale 1ns/1ps

module mem_wb_register_tb;

    logic clk, rst;

    logic [31:0] alu_result_in;
    logic [31:0] memory_data_in;
    logic [4:0] rd_in;
    logic reg_write_in, mem_to_reg_in;

    logic [31:0] alu_result_out;
    logic [31:0] memory_data_out;
    logic [4:0] rd_out;
    logic reg_write_out, mem_to_reg_out;

    mem_wb_register uut (
        .clk(clk),
        .rst(rst),
        .alu_result_in(alu_result_in),
        .memory_data_in(memory_data_in),
        .rd_in(rd_in),
        .reg_write_in(reg_write_in),
        .mem_to_reg_in(mem_to_reg_in),
        .alu_result_out(alu_result_out),
        .memory_data_out(memory_data_out),
        .rd_out(rd_out),
        .reg_write_out(reg_write_out),
        .mem_to_reg_out(mem_to_reg_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        alu_result_in = 0;
        memory_data_in = 0;
        rd_in = 0;
        reg_write_in = 0;
        mem_to_reg_in = 0;

        #12;
        rst = 0;

        // Test 1: ALU result write-back
        alu_result_in = 32'd15;
        memory_data_in = 32'd0;
        rd_in = 5'd3;
        reg_write_in = 1;
        mem_to_reg_in = 0;

        #10;

        $display("Test 1: ALU write-back");
        $display("ALU Result = %0d", alu_result_out);
        $display("Memory Data = %0d", memory_data_out);
        $display("RD = %0d", rd_out);
        $display("RegWrite = %b", reg_write_out);
        $display("MemToReg = %b", mem_to_reg_out);

        if (alu_result_out !== 15 ||
            rd_out !== 3 ||
            reg_write_out !== 1 ||
            mem_to_reg_out !== 0)
            $fatal(1, "Test 1 FAILED");

        // Test 2: Load instruction write-back
        alu_result_in = 32'd100;
        memory_data_in = 32'd25;
        rd_in = 5'd5;
        reg_write_in = 1;
        mem_to_reg_in = 1;

        #10;

        $display("");
        $display("Test 2: Load write-back");
        $display("ALU Result = %0d", alu_result_out);
        $display("Memory Data = %0d", memory_data_out);
        $display("RD = %0d", rd_out);
        $display("RegWrite = %b", reg_write_out);
        $display("MemToReg = %b", mem_to_reg_out);

        if (alu_result_out !== 100 ||
            memory_data_out !== 25 ||
            rd_out !== 5 ||
            reg_write_out !== 1 ||
            mem_to_reg_out !== 1)
            $fatal(1, "Test 2 FAILED");

        $display("");
        $display("====================================");
        $display("       MEM/WB REGISTER TEST PASSED");
        $display("====================================");

        $finish;
    end

endmodule