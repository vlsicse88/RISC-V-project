`timescale 1ns/1ps

module id_ex_register_tb;

    logic clk, rst;

    logic [31:0] pc_in, rd1_in, rd2_in, immediate_in;
    logic [4:0] rs1_in, rs2_in, rd_in;
    logic reg_write_in, mem_read_in, mem_write_in;
    logic alu_src_in, mem_to_reg_in, branch_in;
    logic [1:0] alu_op_in;

    logic [31:0] pc_out, rd1_out, rd2_out, immediate_out;
    logic [4:0] rs1_out, rs2_out, rd_out;
    logic reg_write_out, mem_read_out, mem_write_out;
    logic alu_src_out, mem_to_reg_out, branch_out;
    logic [1:0] alu_op_out;

    id_ex_register uut (
        .clk(clk), .rst(rst),
        .pc_in(pc_in), .rd1_in(rd1_in),
        .rd2_in(rd2_in), .immediate_in(immediate_in),
        .rs1_in(rs1_in), .rs2_in(rs2_in), .rd_in(rd_in),
        .reg_write_in(reg_write_in), .mem_read_in(mem_read_in),
        .mem_write_in(mem_write_in), .alu_src_in(alu_src_in),
        .mem_to_reg_in(mem_to_reg_in), .branch_in(branch_in),
        .alu_op_in(alu_op_in),
        .pc_out(pc_out), .rd1_out(rd1_out),
        .rd2_out(rd2_out), .immediate_out(immediate_out),
        .rs1_out(rs1_out), .rs2_out(rs2_out), .rd_out(rd_out),
        .reg_write_out(reg_write_out), .mem_read_out(mem_read_out),
        .mem_write_out(mem_write_out), .alu_src_out(alu_src_out),
        .mem_to_reg_out(mem_to_reg_out), .branch_out(branch_out),
        .alu_op_out(alu_op_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        pc_in = 0;
        rd1_in = 0;
        rd2_in = 0;
        immediate_in = 0;
        rs1_in = 0;
        rs2_in = 0;
        rd_in = 0;
        reg_write_in = 0;
        mem_read_in = 0;
        mem_write_in = 0;
        alu_src_in = 0;
        mem_to_reg_in = 0;
        branch_in = 0;
        alu_op_in = 0;

        // Test 0: Reset
        @(posedge clk);
        #1;

        if (pc_out !== 0 || rd1_out !== 0 ||
            rd2_out !== 0 || immediate_out !== 0 ||
            rs1_out !== 0 || rs2_out !== 0 || rd_out !== 0 ||
            reg_write_out !== 0 || mem_read_out !== 0 ||
            mem_write_out !== 0 || alu_src_out !== 0 ||
            mem_to_reg_out !== 0 || branch_out !== 0 ||
            alu_op_out !== 0)
            $fatal(1, "FAIL: Reset check");

        $display("PASS: Reset");

        // Test 1: R-type instruction
        @(negedge clk);
        rst = 0;

        pc_in = 100;
        rd1_in = 5;
        rd2_in = 10;
        immediate_in = 20;
        rs1_in = 1;
        rs2_in = 2;
        rd_in = 3;
        reg_write_in = 1;
        mem_read_in = 0;
        mem_write_in = 0;
        alu_src_in = 0;
        mem_to_reg_in = 0;
        branch_in = 0;
        alu_op_in = 2'b10;

        @(posedge clk);
        #1;

        if (pc_out !== 100 || rd1_out !== 5 ||
            rd2_out !== 10 || immediate_out !== 20 ||
            rs1_out !== 1 || rs2_out !== 2 || rd_out !== 3 ||
            reg_write_out !== 1 || mem_read_out !== 0 ||
            mem_write_out !== 0 || alu_src_out !== 0 ||
            mem_to_reg_out !== 0 || branch_out !== 0 ||
            alu_op_out !== 2'b10)
            $fatal(1, "FAIL: R-type instruction");

        $display("PASS: R-type data and control signals");

        // Test 2: Load instruction
        @(negedge clk);

        pc_in = 104;
        rd1_in = 15;
        rd2_in = 25;
        immediate_in = 30;
        rs1_in = 3;
        rs2_in = 4;
        rd_in = 5;
        reg_write_in = 1;
        mem_read_in = 1;
        mem_write_in = 0;
        alu_src_in = 1;
        mem_to_reg_in = 1;
        branch_in = 0;
        alu_op_in = 2'b00;

        @(posedge clk);
        #1;

        if (pc_out !== 104 || rd1_out !== 15 ||
            rd2_out !== 25 || immediate_out !== 30 ||
            rs1_out !== 3 || rs2_out !== 4 || rd_out !== 5 ||
            reg_write_out !== 1 || mem_read_out !== 1 ||
            mem_write_out !== 0 || alu_src_out !== 1 ||
            mem_to_reg_out !== 1 || branch_out !== 0 ||
            alu_op_out !== 2'b00)
            $fatal(1, "FAIL: Load instruction");

        $display("PASS: Load instruction data and control signals");
        $display("PASS: All ID/EX register checks succeeded.");

        $finish;
    end

endmodule