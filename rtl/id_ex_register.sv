module id_ex_register (
    input  logic        clk,
    input  logic        rst,

    input  logic [31:0] pc_in,
    input  logic [31:0] rd1_in,
    input  logic [31:0] rd2_in,
    input  logic [31:0] immediate_in,

    input  logic [4:0]  rs1_in,
    input  logic [4:0]  rs2_in,
    input  logic [4:0]  rd_in,

    input  logic        reg_write_in,
    input  logic        mem_read_in,
    input  logic        mem_write_in,
    input  logic        alu_src_in,
    input  logic        mem_to_reg_in,
    input  logic        branch_in,
    input  logic [1:0]  alu_op_in,

    output logic [31:0] pc_out,
    output logic [31:0] rd1_out,
    output logic [31:0] rd2_out,
    output logic [31:0] immediate_out,

    output logic [4:0]  rs1_out,
    output logic [4:0]  rs2_out,
    output logic [4:0]  rd_out,

    output logic        reg_write_out,
    output logic        mem_read_out,
    output logic        mem_write_out,
    output logic        alu_src_out,
    output logic        mem_to_reg_out,
    output logic        branch_out,
    output logic [1:0]  alu_op_out
);

    always_ff @(posedge clk) begin

        if (rst) begin
            pc_out          <= 32'b0;
            rd1_out         <= 32'b0;
            rd2_out         <= 32'b0;
            immediate_out   <= 32'b0;

            rs1_out         <= 5'b0;
            rs2_out         <= 5'b0;
            rd_out          <= 5'b0;

            reg_write_out   <= 1'b0;
            mem_read_out    <= 1'b0;
            mem_write_out   <= 1'b0;
            alu_src_out     <= 1'b0;
            mem_to_reg_out  <= 1'b0;
            branch_out      <= 1'b0;
            alu_op_out      <= 2'b00;
        end

        else begin
            pc_out          <= pc_in;
            rd1_out         <= rd1_in;
            rd2_out         <= rd2_in;
            immediate_out   <= immediate_in;

            rs1_out         <= rs1_in;
            rs2_out         <= rs2_in;
            rd_out          <= rd_in;

            reg_write_out   <= reg_write_in;
            mem_read_out    <= mem_read_in;
            mem_write_out   <= mem_write_in;
            alu_src_out     <= alu_src_in;
            mem_to_reg_out  <= mem_to_reg_in;
            branch_out      <= branch_in;
            alu_op_out      <= alu_op_in;
        end

    end

endmodule