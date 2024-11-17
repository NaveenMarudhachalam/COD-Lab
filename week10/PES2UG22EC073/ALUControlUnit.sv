module ALUControl (
    input logic [6:0] opcode,        // Opcode from the instruction
    input logic [2:0] funct3,        // funct3 field from the instruction
    input logic [6:0] funct7,        // funct7 field from the instruction (only for R-type)
    output logic [4:0] alu_control,   // ALU operation to perform
    output logic data_type,           // Data type control (signed/unsigned)
    output logic [1:0] data_size      // Data size control (byte/half-word/word)
);

    always_comb begin
        case (opcode)
            7'b0110011: begin // R-type instructions
                case ({funct7, funct3})
                    10'b0000000_000: alu_control = 5'b00000; // ADD
                    10'b0100000_000: alu_control = 5'b00001; // SUB
                    10'b0000000_001: alu_control = 5'b00010; // SLL
                    10'b0000000_010: alu_control = 5'b00011; // SLT
                    10'b0000000_011: alu_control = 5'b00100; // SLTU
                    10'b0000000_100: alu_control = 5'b00101; // XOR
                    10'b0000000_101: alu_control = 5'b00110; // SRL
                    10'b0100000_101: alu_control = 5'b00111; // SRA
                    10'b0000000_110: alu_control = 5'b01000; // OR
                    10'b0000000_111: alu_control = 5'b01001; // AND
                    default: alu_control = 5'b00000; // Default to ADD
                endcase
            end
            7'b0010011: begin // I-type ALU instructions
                case (funct3)
                    3'b000: alu_control = 5'b00000; // ADDI
                    3'b010: alu_control = 5'b00011; // SLTI
                    3'b011: alu_control = 5'b00100; // SLTIU
                    3'b100: alu_control = 5'b00101; // XORI
                    3'b110: alu_control = 5'b01000; // ORI
                    3'b111: alu_control = 5'b01001; // ANDI
                    default: alu_control = 5'b00000; // Default to ADDI
                endcase
            end
            7'b0000011: begin // L-type (Load)
                alu_control = 5'b00000; // Use ADD for address calculation
                case (funct3)
                    3'b000: data_size = 2'b00; // LB
                    3'b001: data_size = 2'b01; // LH
                    3'b010: data_size = 2'b10; // LW
                    3'b100: begin data_size = 2'b00; data_type = 1; end // LBU
                    3'b101: begin data_size = 2'b01; data_type = 1; end // LHU
                endcase
                
            end
            7'b0100011: begin // S-type (Store)
                alu_control = 5'b00000; // Use ADD for address calculation
                case (funct3)
                    3'b000: data_size = 2'b00; // SB
                    3'b001: data_size = 2'b01; // SH
                    3'b010: data_size = 2'b10; // SW
                endcase
            end
            7'b1100011: begin // B-type (Branch)
                case (funct3)
                    3'b000: alu_control = 5'b01101; // BEQ
                    3'b001: alu_control = 5'b01110; // BNE
                    3'b100: alu_control = 5'b01111; // BLT
                    3'b101: alu_control = 5'b10000; // BGE
                    3'b110: alu_control = 5'b10001; // BLTU
                    3'b111: alu_control = 5'b10010; // BGEU
                    default: alu_control = 5'b01101; // Default to BEQ
                endcase
            end
            7'b1101111: alu_control = 5'b11000; // JAL
            7'b1100111: alu_control = 5'b11101; // JALR
            default: alu_control = 5'b00000;      // Default to ADD
        endcase
    end

endmodule
