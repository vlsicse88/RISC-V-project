`timescale 1ns/1ps

module control_unit_tb;

    logic [6:0] opcode;

    logic       reg_write;
    logic       mem_read;
    logic       mem_write;
    logic       alu_src;
    logic       mem_to_reg;
    logic       branch;
    logic [1:0] alu_op;

    control_unit uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_op(alu_op)
    );

    initial begin

        // R-type
        opcode = 7'b0110011;
        #10;
        $display("R-type   : reg_write=%b mem_read=%b mem_write=%b alu_src=%b mem_to_reg=%b branch=%b alu_op=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, alu_op);

        // I-type ALU
        opcode = 7'b0010011;
        #10;
        $display("I-type   : reg_write=%b mem_read=%b mem_write=%b alu_src=%b mem_to_reg=%b branch=%b alu_op=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, alu_op);

        // Load
        opcode = 7'b0000011;
        #10;
        $display("LOAD     : reg_write=%b mem_read=%b mem_write=%b alu_src=%b mem_to_reg=%b branch=%b alu_op=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, alu_op);

        // Store
        opcode = 7'b0100011;
        #10;
        $display("STORE    : reg_write=%b mem_read=%b mem_write=%b alu_src=%b mem_to_reg=%b branch=%b alu_op=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, alu_op);

        // Branch
        opcode = 7'b1100011;
        #10;
        $display("BRANCH   : reg_write=%b mem_read=%b mem_write=%b alu_src=%b mem_to_reg=%b branch=%b alu_op=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, alu_op);

        // Unknown opcode
        opcode = 7'b1111111;
        #10;
        $display("UNKNOWN  : reg_write=%b mem_read=%b mem_write=%b alu_src=%b mem_to_reg=%b branch=%b alu_op=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, alu_op);

        $finish;

    end

endmodule