`timescale 1ns/1ps

module ex_mem_register_tb;

    logic clk, rst;

    logic [31:0] alu_result_in, write_data_in;
    logic [4:0] rd_in;
    logic reg_write_in, mem_read_in, mem_write_in, mem_to_reg_in;

    logic [31:0] alu_result_out, write_data_out;
    logic [4:0] rd_out;
    logic reg_write_out, mem_read_out, mem_write_out, mem_to_reg_out;

    ex_mem_register uut (
        .clk(clk),
        .rst(rst),
        .alu_result_in(alu_result_in),
        .write_data_in(write_data_in),
        .rd_in(rd_in),
        .reg_write_in(reg_write_in),
        .mem_read_in(mem_read_in),
        .mem_write_in(mem_write_in),
        .mem_to_reg_in(mem_to_reg_in),
        .alu_result_out(alu_result_out),
        .write_data_out(write_data_out),
        .rd_out(rd_out),
        .reg_write_out(reg_write_out),
        .mem_read_out(mem_read_out),
        .mem_write_out(mem_write_out),
        .mem_to_reg_out(mem_to_reg_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        alu_result_in = 0;
        write_data_in = 0;
        rd_in = 0;
        reg_write_in = 0;
        mem_read_in = 0;
        mem_write_in = 0;
        mem_to_reg_in = 0;

        #12;
        rst = 0;

        // Test 1: ALU result and register-write signals
        alu_result_in = 32'd15;
        write_data_in = 32'd10;
        rd_in = 5'd3;
        reg_write_in = 1;
        mem_read_in = 0;
        mem_write_in = 0;
        mem_to_reg_in = 0;

        #10;

        $display("Test 1:");
        $display("ALU Result = %0d", alu_result_out);
        $display("Write Data = %0d", write_data_out);
        $display("RD         = %0d", rd_out);
        $display("RegWrite   = %b", reg_write_out);

        if (alu_result_out !== 15 ||
            write_data_out !== 10 ||
            rd_out !== 3 ||
            reg_write_out !== 1)
            $fatal(1, "Test 1 FAILED");

        // Test 2: Store instruction control signals
        alu_result_in = 32'd100;
        write_data_in = 32'd25;
        rd_in = 0;
        reg_write_in = 0;
        mem_read_in = 0;
        mem_write_in = 1;
        mem_to_reg_in = 0;

        #10;

        $display("");
        $display("Test 2:");
        $display("ALU Result = %0d", alu_result_out);
        $display("Write Data = %0d", write_data_out);
        $display("MemWrite   = %b", mem_write_out);

        if (alu_result_out !== 100 ||
            write_data_out !== 25 ||
            mem_write_out !== 1)
            $fatal(1, "Test 2 FAILED");

        $display("");
        $display("====================================");
        $display("       EX/MEM REGISTER TEST PASSED");
        $display("====================================");

        $finish;
    end

endmodule