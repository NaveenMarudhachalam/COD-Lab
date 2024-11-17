module ALU (
    input logic [31:0] a,             // First operand
    input logic [31:0] b,             // Second operand
    input logic [4:0] alu_op,         // 5-bit ALU operation code
    output logic [31:0] result,       // ALU result
    output logic zero                 // Zero flag for branch evaluation
);

    always_comb begin
       
        case (alu_op)
            5'b00000: result = a + b;                       // ADD
            5'b00001: result = a - b;                       // SUB
            5'b00010: result = a << b[4:0];                 // SLL (Shift Left Logical)
            5'b00011: result = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0; // SLT (Set Less Than, signed)
            5'b00100: result = (a < b) ? 32'b1 : 32'b0;     // SLTU (Set Less Than Unsigned)
            5'b00101: result = a ^ b;                       // XOR
            5'b00110: result = a >> b[4:0];                 // SRL (Shift Right Logical)
            5'b00111: result = $signed(a) >>> b[4:0];       // SRA (Shift Right Arithmetic)
            5'b01000: result = a | b;                       // OR
            5'b01001: result = a & b;                       // AND
            5'b01010: result = a;                           // LUI (Load Upper Immediate, simply pass immediate)
            5'b01011: result = a + b;                       // AUIPC (Add Upper Immediate to PC)
            5'b01101: result = (a == b) ? 32'b1 : 32'b0;    // BEQ (Branch if Equal)
            5'b01110: result = (a != b) ? 32'b1 : 32'b0;    // BNE (Branch if Not Equal)
            5'b01111: result = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0; // BLT (Branch if Less Than)
            5'b10000: result = ($signed(a) >= $signed(b)) ? 32'b1 : 32'b0; // BGE (Branch if Greater or Equal)
            5'b10001: result = (a < b) ? 32'b1 : 32'b0;     // BLTU (Branch if Less Than Unsigned)
            5'b10010: result = (a >= b) ? 32'b1 : 32'b0;    // BGEU (Branch if Greater or Equal Unsigned)
           
            default: result = 32'b0;                         // Default case
        endcase
    end

    // Zero flag is set if result is zero, useful for branch conditions
    assign zero = !(result == 32'b0);

endmodule
