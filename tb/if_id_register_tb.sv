
`timescale 1ns/1ps

module if_id_register_tb;

    logic clk;
    logic rst;
    logic enable;

    logic [31:0] pc_in;
    logic [31:0] instruction_in;

    logic [31:0] pc_out;
    logic [31:0] instruction_out;

    // Device Under Test
    if_id_register uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .pc_in(pc_in),
        .instruction_in(instruction_in),
        .pc_out(pc_out),
        .instruction_out(instruction_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        enable = 1;

        pc_in = 0;
        instruction_in = 0;

        // Reset
        #12;
        rst = 0;

        // Test 1: Capture first instruction
        pc_in = 32'd100;
        instruction_in = 32'h00500093;

        #10;

        $display("Test 1:");
        $display("PC          = %0d", pc_out);
        $display("Instruction = %h", instruction_out);

        if (pc_out !== 32'd100 ||
            instruction_out !== 32'h00500093)
            $fatal(1, "FAIL: Test 1");

        // Test 2: Capture second instruction
        pc_in = 32'd104;
        instruction_in = 32'h00A00113;

        #10;

        $display("");
        $display("Test 2:");
        $display("PC          = %0d", pc_out);
        $display("Instruction = %h", instruction_out);

        if (pc_out !== 32'd104 ||
            instruction_out !== 32'h00A00113)
            $fatal(1, "FAIL: Test 2");

        $display("");
        $display("PASS: IF/ID register captured both instructions.");

        $finish;
    end

endmodule
