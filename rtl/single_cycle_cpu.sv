module single_cycle_cpu (
    input logic clk,
    input logic rst
);

    // -------------------------
    // PC
    // -------------------------
    logic [31:0] pc;
    logic [31:0] next_pc;

    assign next_pc = pc + 32'd4;

    // -------------------------
    // Instruction
    // -------------------------
    logic [31:0] instruction;

    // -------------------------
    // Instruction fields
    // -------------------------
    logic [6:0] opcode;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic [2:0] funct3;
    logic       funct7_bit;

    assign opcode     = instruction[6:0];
    assign rd         = instruction[11:7];
    assign funct3     = instruction[14:12];
    assign rs1        = instruction[19:15];
    assign rs2        = instruction[24:20];
    assign funct7_bit = instruction[30];

    // -------------------------
    // Control signals
    // -------------------------
    logic       reg_write;
    logic       mem_read;
    logic       mem_write;
    logic       alu_src;
    logic       mem_to_reg;
    logic       branch;
    logic [1:0] alu_op;

    // -------------------------
    // Register File
    // -------------------------
    logic [31:0] rd1;
    logic [31:0] rd2;

    // -------------------------
    // Immediate
    // -------------------------
    logic [31:0] immediate;

    // -------------------------
    // ALU Control
    // -------------------------
    logic [2:0] alu_control;

    // -------------------------
    // ALU
    // -------------------------
    logic [31:0] alu_input_b;
    logic [31:0] alu_result;

    // -------------------------
    // Data Memory
    // -------------------------
    logic [31:0] memory_read_data;

    // -------------------------
    // Write Back
    // -------------------------
    logic [31:0] write_back_data;

    // =================================================
    // PROGRAM COUNTER
    // =================================================
    program_counter pc_unit (
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .pc(pc)
    );

    // =================================================
    // INSTRUCTION MEMORY
    // =================================================
    instruction_memory instruction_mem (
        .address(pc),
        .instruction(instruction)
    );

    // =================================================
    // CONTROL UNIT
    // =================================================
    control_unit control (
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .alu_op(alu_op)
    );

    // =================================================
    // IMMEDIATE GENERATOR
    // =================================================
    immediate_generator imm_gen (
        .instruction(instruction),
        .immediate(immediate)
    );

    // =================================================
    // ALU CONTROL
    // =================================================
    alu_control alu_ctrl (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7_bit(funct7_bit),
        .alu_control(alu_control)
    );

    // =================================================
    // REGISTER FILE
    // =================================================
    register_file registers (
        .clk(clk),
        .rst(rst),
        .rs1(rs1),
        .rs2(rs2),
        .rd1(rd1),
        .rd2(rd2),
        .reg_write(reg_write),
        .rd(rd),
        .write_data(write_back_data)
    );

    // =================================================
    // ALU INPUT B
    // =================================================
    assign alu_input_b = alu_src ? immediate : rd2;

    // =================================================
    // ALU
    // =================================================
    alu alu_unit (
        .A(rd1),
        .B(alu_input_b),
        .ALUControl(alu_control),
        .Result(alu_result)
    );

    // =================================================
    // DATA MEMORY
    // =================================================
    data_memory data_mem (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(alu_result),
        .write_data(rd2),
        .read_data(memory_read_data)
    );

    // =================================================
    // WRITE BACK
    // =================================================
    assign write_back_data =
        mem_to_reg ? memory_read_data : alu_result;

endmodule