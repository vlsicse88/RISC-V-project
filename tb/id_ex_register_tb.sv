`timescale 1ns/1ps

module id_ex_register_tb;

    logic        clk;
    logic        rst;

    logic [31:0] pc_in;
    logic [31:0] rd1_in;
    logic [31:0] rd2_in;
    logic [31:0] immediate_in;

    logic [4:0]  rs1_in;
    logic [4:0]  rs2_in;
    logic [4:0]  rd_in;

    logic        reg_write_in;
    logic        mem_read_in;
    logic        mem_write_in;
    logic        alu_src_in;
    logic        mem_to_reg_in;
    logic        branch_in;
    logic [1:0]  alu_op_in;

    logic [31:0] pc_out;
    logic [31:0] rd1_out;
    logic [31:0] rd2_out;
    logic [31:0] immediate_out;

    logic [4:0]  rs1_out;
    logic [4:0]  rs2_out;
    logic [4:0]  rd_out;

    logic        reg_write_out;
    logic        mem_read_out;
    logic        mem_write_out;
    logic        alu_src_out;
    logic        mem_to_reg_out;
    logic        branch_out;
    logic [1:0]  alu_op_out;

    id_ex_register uut (
        .clk(clk),
        .rst(rst),

        .pc_in(pc_in),
        .rd1_in(rd1_in),
        .rd2_in(rd2_in),
        .immediate_in(immediate_in),

        .rs1_in(rs1_in),
        .rs2_in(rs2_in),
        .rd_in(rd_in),

        .reg_write_in(reg_write_in),
        .mem_read_in(mem_read_in),
        .mem_write_in(mem_write_in),
        .alu_src_in(alu_src_in),
        .mem_to_reg_in(mem_to_reg_in),
        .branch_in(branch_in),
        .alu_op_in(alu_op_in),

        .pc_out(pc_out),
        .rd1_out(rd1_out),
        .rd2_out(rd2_out),
        .immediate_out(immediate_out),

        .rs1_out(rs1_out),
        .rs2_out(rs2_out),
        .rd_out(rd_out),

        .reg_write_out(reg_write_out),
        .mem_read_out(mem_read_out),
        .mem_write_out(mem_write_out),
        .alu_src_out(alu_src_out),
        .mem_to_reg_out(mem_to_reg_out),
        .branch_out(branch_out),
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

        #12;

        rst = 0;

        // Test 1
        pc_in = 32'd100;
        rd1_in = 32'd5;
        rd2_in = 32'd10;
        immediate_in = 32'd20;

        rs1_in = 5'd1;
        rs2_in = 5'd2;
        rd_in = 5'd3;

        reg_write_in = 1;
        mem_read_in = 0;
        mem_write_in = 0;
        alu_src_in = 0;
        mem_to_reg_in = 0;
        branch_in = 0;
        alu_op_in = 2'b10;

        #10;

        $display("Test 1:");
        $display("PC          = %0d", pc_out);
        $display("RD1         = %0d", rd1_out);
        $display("RD2         = %0d", rd2_out);
        $display("Immediate   = %0d", immediate_out);
        $display("RS1         = %0d", rs1_out);
        $display("RS2         = %0d", rs2_out);
        $display("RD          = %0d", rd_out);
        $display("RegWrite    = %b", reg_write_out);
        $display("ALUOp       = %b", alu_op_out);

        // Test 2
        pc_in = 32'd104;
        rd1_in = 32'd15;
        rd2_in = 32'd25;
        immediate_in = 32'd30;

        rs1_in = 5'd3;
        rs2_in = 5'd4;
        rd_in = 5'd5;

        reg_write_in = 1;
        mem_read_in = 1;
        mem_write_in = 0;
        alu_src_in = 1;
        mem_to_reg_in = 1;
        branch_in = 0;
        alu_op_in = 2'b00;

        #10;

        $display("");
        $display("Test 2:");
        $display("PC          = %0d", pc_out);
        $display("RD1         = %0d", rd1_out);
        $display("RD2         = %0d", rd2_out);
        $display("Immediate   = %0d", immediate_out);
        $display("RS1         = %0d", rs1_out);
        $display("RS2         = %0d", rs2_out);
        $display("RD          = %0d", rd_out);
        $display("RegWrite    = %b", reg_write_out);
        $display("MemRead     = %b", mem_read_out);
        $display("ALUSrc      = %b", alu_src_out);
        $display("MemToReg    = %b", mem_to_reg_out);

        $display("");
        $display("====================================");
        $display("       ID/EX REGISTER TEST PASSED");
        $display("====================================");

        $finish;

    end

endmodule