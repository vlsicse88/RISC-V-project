`timescale 1ns/1ps

module register_file_tb;

    logic        clk;
    logic        rst;
    logic [4:0]  rs1;
    logic [4:0]  rs2;
    logic [31:0] rd1;
    logic [31:0] rd2;

    logic        reg_write;
    logic [4:0]  rd;
    logic [31:0] write_data;

    register_file uut (
        .clk(clk),
        .rst(rst),
        .rs1(rs1),
        .rs2(rs2),
        .rd1(rd1),
        .rd2(rd2),
        .reg_write(reg_write),
        .rd(rd),
        .write_data(write_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        write_data = 0;
        reg_write = 0;

        // Reset
        #10;
        rst = 0;

        // Write 100 into register x5
        rd = 5;
        write_data = 100;
        reg_write = 1;
        #10;

        // Stop writing
        reg_write = 0;

        // Read register x5
        rs1 = 5;
        #5;
        $display("Read x5 = %0d", rd1);

        // Write 200 into register x10
        rd = 10;
        write_data = 200;
        reg_write = 1;
        #10;

        reg_write = 0;

        // Read register x10
        rs2 = 10;
        #5;
        $display("Read x10 = %0d", rd2);

        // Test x0 must always be zero
        rs1 = 0;
        #5;
        $display("Read x0 = %0d", rd1);

        $finish;

    end

endmodule