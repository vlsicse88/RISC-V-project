module alu_control (
    input  logic [1:0] alu_op,
    input  logic [2:0] funct3,
    input  logic       funct7_bit,

    output logic [2:0] alu_control
);

    always_comb begin

        case (alu_op)

            // Load / Store → ADD
            2'b00: begin
                alu_control = 3'b000;
            end

            // Branch → SUB
            2'b01: begin
                alu_control = 3'b001;
            end

            // R-type instructions
            2'b10: begin
                case (funct3)

                    3'b000: begin
                        if (funct7_bit)
                            alu_control = 3'b001; // SUB
                        else
                            alu_control = 3'b000; // ADD
                    end

                    3'b111: alu_control = 3'b010; // AND
                    3'b110: alu_control = 3'b011; // OR
                    3'b100: alu_control = 3'b100; // XOR
                    3'b010: alu_control = 3'b101; // SLT

                    default: alu_control = 3'b000;

                endcase
            end

            // I-type ALU instructions
            2'b11: begin
                case (funct3)

                    3'b000: alu_control = 3'b000; // ADDI
                    3'b111: alu_control = 3'b010; // ANDI
                    3'b110: alu_control = 3'b011; // ORI
                    3'b100: alu_control = 3'b100; // XORI
                    3'b010: alu_control = 3'b101; // SLTI

                    default: alu_control = 3'b000;

                endcase
            end

            default: begin
                alu_control = 3'b000;
            end

        endcase
    end

endmodule