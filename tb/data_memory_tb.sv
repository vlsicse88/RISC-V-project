`timescale 1ns/1ps

module data_memory_tb;

    logic        clk;
    logic        mem_read;
    logic        mem_write;
    logic [31:0] address;
    logic [31:0] write_data;
    logic [31:0] read_data;

    data_memory uut (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    // 10 ns clock
    always #5 clk = ~clk;

    initial begin

        clk       = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        address   = 32'd0;
        write_data = 32'd0;

        // Write 100 to address 0
        #2;
        address    = 32'd0;
        write_data = 32'd100;
        mem_write  = 1'b1;

        #10;
        mem_write = 1'b0;

        // Read from address 0
        mem_read = 1'b1;

        #2;
        $display("Read address 0 = %0d", read_data);

        // Write 200 to address 4
        mem_read  = 1'b0;
        address   = 32'd4;
        write_data = 32'd200;
        mem_write = 1'b1;

        #10;
        mem_write = 1'b0;

        // Read from address 4
        mem_read = 1'b1;

        #2;
        $display("Read address 4 = %0d", read_data);

        $finish;

    end

endmodule