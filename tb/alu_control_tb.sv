`timescale 1ns/1ps

module alu_control_tb;

    logic [1:0] alu_op;
    logic [2:0] funct3;
    logic       funct7_bit;
    logic [2:0] alu_control;

    alu_control uut (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7_bit(funct7_bit),
        .alu_control(alu_control)
    );

    initial begin

        // R-type ADD
        alu_op = 2'b10;
        funct3 = 3'b000;
        funct7_bit = 1'b0;
        #10;
        $display("R-type ADD : alu_control = %b", alu_control);

        // R-type SUB
        alu_op = 2'b10;
        funct3 = 3'b000;
        funct7_bit = 1'b1;
        #10;
        $display("R-type SUB : alu_control = %b", alu_control);

        // R-type AND
        alu_op = 2'b10;
        funct3 = 3'b111;
        funct7_bit = 1'b0;
        #10;
        $display("R-type AND : alu_control = %b", alu_control);

        // R-type OR
        alu_op = 2'b10;
        funct3 = 3'b110;
        funct7_bit = 1'b0;
        #10;
        $display("R-type OR  : alu_control = %b", alu_control);

        // R-type XOR
        alu_op = 2'b10;
        funct3 = 3'b100;
        funct7_bit = 1'b0;
        #10;
        $display("R-type XOR : alu_control = %b", alu_control);

        // R-type SLT
        alu_op = 2'b10;
        funct3 = 3'b010;
        funct7_bit = 1'b0;
        #10;
        $display("R-type SLT : alu_control = %b", alu_control);

        // ADDI
        alu_op = 2'b11;
        funct3 = 3'b000;
        funct7_bit = 1'b0;
        #10;
        $display("ADDI        : alu_control = %b", alu_control);

        // ANDI
        alu_op = 2'b11;
        funct3 = 3'b111;
        funct7_bit = 1'b0;
        #10;
        $display("ANDI        : alu_control = %b", alu_control);

        // LOAD
        alu_op = 2'b00;
        funct3 = 3'b010;
        funct7_bit = 1'b0;
        #10;
        $display("LOAD        : alu_control = %b", alu_control);

        // STORE
        alu_op = 2'b00;
        funct3 = 3'b010;
        funct7_bit = 1'b0;
        #10;
        $display("STORE       : alu_control = %b", alu_control);

        // BRANCH
        alu_op = 2'b01;
        funct3 = 3'b000;
        funct7_bit = 1'b0;
        #10;
        $display("BRANCH      : alu_control = %b", alu_control);

        $finish;

    end

endmodule