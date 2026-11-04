
`timescale 1ns/1ps

module alu_control_tb;

    logic [1:0] ALUOp;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [3:0] ALUControl;

    integer errors = 0;

    alu_control uut (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );

    task check(input [3:0] expected, input [8*30-1:0] test_name);
        begin
            #10;
            if (ALUControl !== expected) begin
                $display("FAIL: %0s expected=%b got=%b",
                         test_name, expected, ALUControl);
                errors = errors + 1;
            end else begin
                $display("PASS: %0s = %b", test_name, ALUControl);
            end
        end
    endtask

    initial begin
        ALUOp = 2'b10; funct3 = 3'b000; funct7 = 7'b0000000;
        check(4'b0000, "R-type ADD");

        ALUOp = 2'b10; funct3 = 3'b000; funct7 = 7'b0100000;
        check(4'b0001, "R-type SUB");

        ALUOp = 2'b10; funct3 = 3'b111; funct7 = 7'b0000000;
        check(4'b0010, "R-type AND");

        ALUOp = 2'b10; funct3 = 3'b110; funct7 = 7'b0000000;
        check(4'b0011, "R-type OR");

        ALUOp = 2'b10; funct3 = 3'b100; funct7 = 7'b0000000;
        check(4'b0100, "R-type XOR");

        ALUOp = 2'b10; funct3 = 3'b010; funct7 = 7'b0000000;
        check(4'b0101, "R-type SLT");

        ALUOp = 2'b00; funct3 = 3'b000; funct7 = 7'b0000000;
        check(4'b0000, "LOAD");

        ALUOp = 2'b01; funct3 = 3'b000; funct7 = 7'b0000000;
        check(4'b0001, "BRANCH");

        if (errors == 0)
            $display("PASS: All ALU control checks succeeded.");
        else
            $display("FAIL: %0d ALU control checks failed.", errors);

        $finish;
    end

endmodule
