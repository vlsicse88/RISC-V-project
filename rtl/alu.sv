module alu (
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [2:0] ALUControl,
    output logic [31:0] Result
);

    always_comb begin
        case (ALUControl)

            3'b000: Result = A + B;
            3'b001: Result = A - B;
            3'b010: Result = A & B;
            3'b011: Result = A | B;
            3'b100: Result = A ^ B;
            3'b101: Result = (A < B) ? 32'b1 : 32'b0;

            default: Result = 32'b0;

        endcase
    end

endmodule