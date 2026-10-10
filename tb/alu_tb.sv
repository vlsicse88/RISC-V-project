`timescale 1ns/1ps

module alu_tb;

    logic [31:0] A;
    logic [31:0] B;
    logic [2:0]  ALUControl;
    logic [31:0] Result;

    // Connect our ALU to the testbench
    alu uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result)
    );

    initial begin

        // Test 1: ADD
        A = 10;
        B = 5;
        ALUControl = 3'b000;
        #10;
        $display("ADD: A=%0d B=%0d Result=%0d", A, B, Result);

        // Test 2: SUB
        A = 10;
        B = 5;
        ALUControl = 3'b001;
        #10;
        $display("SUB: A=%0d B=%0d Result=%0d", A, B, Result);

        // Test 3: AND
        A = 8;
        B = 4;
        ALUControl = 3'b010;
        #10;
        $display("AND: A=%0d B=%0d Result=%0d", A, B, Result);

        // Test 4: OR
        A = 8;
        B = 4;
        ALUControl = 3'b011;
        #10;
        $display("OR: A=%0d B=%0d Result=%0d", A, B, Result);

        // Test 5: XOR
        A = 8;
        B = 4;
        ALUControl = 3'b100;
        #10;
        $display("XOR: A=%0d B=%0d Result=%0d", A, B, Result);

        // Test 6: SLT
        A = 5;
        B = 10;
        ALUControl = 3'b101;
        #10;
        $display("SLT: A=%0d B=%0d Result=%0d", A, B, Result);

        $finish;

    end

endmodule