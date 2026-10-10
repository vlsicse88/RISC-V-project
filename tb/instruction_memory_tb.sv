`timescale 1ns/1ps

module instruction_memory_tb;

    logic [31:0] address;
    logic [31:0] instruction;

    instruction_memory uut (
        .address(address),
        .instruction(instruction)
    );

    initial begin

        // Read instruction at address 0
        address = 32'd0;
        #10;
        $display("Address = %0d  Instruction = %h", address, instruction);

        // Read instruction at address 4
        address = 32'd4;
        #10;
        $display("Address = %0d  Instruction = %h", address, instruction);

        // Read instruction at address 8
        address = 32'd8;
        #10;
        $display("Address = %0d  Instruction = %h", address, instruction);

        // Read instruction at address 12
        address = 32'd12;
        #10;
        $display("Address = %0d  Instruction = %h", address, instruction);

        $finish;

    end

endmodule