module immediate_generator (
    input  logic [31:0] instruction,
    output logic [31:0] immediate
);

    assign immediate =
        (instruction[6:0] == 7'b0010011 ||
         instruction[6:0] == 7'b0000011)
        ? {{20{instruction[31]}}, instruction[31:20]}

        : (instruction[6:0] == 7'b0100011)
        ? {{20{instruction[31]}},
           instruction[31:25],
           instruction[11:7]}

        : (instruction[6:0] == 7'b1100011)
        ? {{19{instruction[31]}},
           instruction[31],
           instruction[7],
           instruction[30:25],
           instruction[11:8],
           1'b0}

        : 32'b0;

endmodule