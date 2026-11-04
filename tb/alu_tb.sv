
`timescale 1ns/1ps

module alu_tb;

    logic [31:0] A;
    logic [31:0] B;
    logic [2:0]  ALUControl;
    logic [31:0] Result;

    integer errors = 0;

    alu uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result)
    );

    task check(
        input string name,
        input logic [31:0] got,
        input logic [31:0] expected
    );
        begin
            if (got !== expected) begin
                $display("FAIL: %s got=%0d expected=%0d",
                         name, got, expected);
                errors = errors + 1;
            end else begin
                $display("PASS: %s = %0d", name, got);
            end
        end
    endtask

    initial begin
        A = 10; B = 5; ALUControl = 3'b000;
        #10; check("ADD", Result, 32'd15);

        A = 10; B = 5; ALUControl = 3'b001;
        #10; check("SUB", Result, 32'd5);

        A = 8; B = 4; ALUControl = 3'b010;
        #10; check("AND", Result, 32'd0);

        A = 8; B = 4; ALUControl = 3'b011;
        #10; check("OR", Result, 32'd12);

        A = 8; B = 4; ALUControl = 3'b100;
        #10; check("XOR", Result, 32'd12);

        A = 5; B = 10; ALUControl = 3'b101;
        #10; check("SLT", Result, 32'd1);

        if (errors == 0) begin
            $display("PASS: All ALU checks succeeded.");
            $finish;
        end else begin
            $display("FAIL: %0d ALU check(s) failed.", errors);
            $fatal(1, "ALU test failed");
        end
    end

endmodule
