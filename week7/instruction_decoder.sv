module instruction_decoder (
    input  logic [31:0] instruction,   // 32-bit instruction
    output logic [4:0]  rs1_addr,      // Source register 1 address
    output logic [4:0]  rs2_addr,      // Source register 2 address
    output logic [4:0]  rd_addr,       // Destination register address
    output logic [6:0]  funct7,        // Function7 (opcode-specific)
    output logic [2:0]  funct3,        // Function3 (opcode-specific)
    output logic [20:0] imm,           // Immediate value (21-bit for J-type, 13-bit for B-type, 12-bit otherwise)
    output logic [6:0]  opcode         // Instruction opcode
);

    // Extract opcode from the instruction
    assign opcode = instruction[6:0];

    // Decode instruction based on the opcode
    always_comb begin
        case (opcode)
            7'b0110011: begin  // R-type instructions
                rs1_addr = instruction[19:15];
                rs2_addr = instruction[24:20];
                rd_addr  = instruction[11:7];
                funct3   = instruction[14:12];
                funct7   = instruction[31:25];
                imm      = 21'b0;  // No immediate for R-type
            end

            7'b0010011: begin  // I-type instructions (includes JALR)
                rs1_addr = instruction[19:15];
                rd_addr  = instruction[11:7];
                funct3   = instruction[14:12];
                funct7   = 7'b0;  // No funct7 for I-type
                imm      = {9'b0, instruction[31:20]};  // Extend to 21-bit with leading 0 for compatibility
                rs2_addr = 5'b0;  // No rs2 in I-type
            end

            7'b0000011: begin  // L-type (load instructions)
                rs1_addr = instruction[19:15];
                rd_addr  = instruction[11:7];
                funct3   = instruction[14:12];
                funct7   = 7'b0;  // No funct7 for L-type
                imm      = {9'b0, instruction[31:20]};  // Extend to 21-bit with leading 0 for compatibility
                rs2_addr = 5'b0;  // No rs2 in L-type
            end

            7'b0100011: begin  // S-type (store instructions)
                rs1_addr = instruction[19:15];
                rs2_addr = instruction[24:20];
                funct3   = instruction[14:12];
                funct7   = 7'b0;  // No funct7 for S-type
                imm      = {9'b0, instruction[31:25], instruction[11:7]};  // Extend to 21-bit with leading 0
                rd_addr  = 5'b0;  // No destination register
            end

            7'b1100011: begin  // B-type (branch instructions)
                rs1_addr = instruction[19:15];
                rs2_addr = instruction[24:20];
                funct3   = instruction[14:12];
                funct7   = 7'b0;  // No funct7 for B-type
                imm      = {instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};  // 13-bit sign-extended immediate for B-type
                rd_addr  = 5'b0;  // No destination register
            end

            7'b1101111: begin  // J-type (JAL)
                rd_addr  = instruction[11:7];
                imm      = {instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};  // 21-bit sign-extended immediate for J-type
                rs1_addr = 5'b0;
                rs2_addr = 5'b0;
                funct3   = 3'b0;
                funct7   = 7'b0;
            end

            7'b1100111: begin  // JALR (I-type variant)
                rs1_addr = instruction[19:15];
                rd_addr  = instruction[11:7];
                funct3   = instruction[14:12];
                funct7   = 7'b0;  // No funct7 for JALR
                imm      = {9'b0, instruction[31:20]};  // 12-bit immediate, extended to 21-bit with leading 0s
                rs2_addr = 5'b0;  // No rs2 in JALR
            end

            7'b0110111, 7'b0010111: begin  // U-type (LUI and AUIPC)
                rd_addr  = instruction[11:7];
                imm      = {instruction[31:12], 12'b0};  // 20-bit immediate shifted left by 12 bits
                rs1_addr = 5'b0;
                rs2_addr = 5'b0;
                funct3   = 3'b0;
                funct7   = 7'b0;
            end

            default: begin
                rs1_addr = 5'b0;
                rs2_addr = 5'b0;
                rd_addr  = 5'b0;
                funct3   = 3'b0;
                funct7   = 7'b0;
                imm      = 21'b0;
            end
        endcase
    end

endmodule
