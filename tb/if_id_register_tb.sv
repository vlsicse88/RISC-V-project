`timescale 1ns/1ps

module if_id_register_tb;

    logic        clk;
    logic        rst;

    logic [31:0] pc_in;
    logic [31:0] instruction_in;

    logic [31:0] pc_out;
    logic [31:0] instruction_out;

    // DUT
    if_id_register uut (
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .instruction_in(instruction_in),
        .pc_out(pc_out),
        .instruction_out(instruction_out)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        pc_in = 0;
        instruction_in = 0;

        #12;

        rst = 0;

        // Test 1
        pc_in = 32'd100;
        instruction_in = 32'h00500093;

        #10;

        $display("Test 1:");
        $display("PC          = %0d", pc_out);
        $display("Instruction = %h", instruction_out);

        // Test 2
        pc_in = 32'd104;
        instruction_in = 32'h00A00113;

        #10;

        $display("");
        $display("Test 2:");
        $display("PC          = %0d", pc_out);
        $display("Instruction = %h", instruction_out);

        $display("");
        $display("====================================");
        $display("       IF/ID REGISTER TEST PASSED");
        $display("====================================");

        $finish;

    end

endmodule