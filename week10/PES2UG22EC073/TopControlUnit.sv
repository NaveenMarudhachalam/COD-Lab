module TopControlUnit (
    input logic [6:0] opcode,       // 7-bit opcode from the instruction
    output logic alu_src,           // ALU source (immediate or rs2)
    output logic mem_read,          // Memory read signal (for L-type)
    output logic mem_write,         // Memory write signal (for S-type)
    output logic reg_write,         // Register write signal (for R- and L-types)
    output logic memtoreg,         //control signal for write back mux
    output logic branch,            // Branch control signal
    output logic jump               // Jump control signal
);

    always_comb begin
        // Default control signals (no operation)
        alu_src = 0;
        mem_read = 0;
        mem_write = 0;
        reg_write = 0;
        branch = 0;
        jump = 0;
        memtoreg = 0;
        
        case (opcode)
            7'b0110011: begin // R-type instructions
                alu_src = 0;
                reg_write = 1;
                memtoreg = 0;
            end
            7'b0010011: begin // I-type ALU instructions
                alu_src = 1;
                reg_write = 1;
                memtoreg = 0;
            end
            7'b0000011: begin // L-type (Load)
                alu_src = 1;
                mem_read = 1;
                reg_write = 1;
                memtoreg = 1;
            end
            7'b0100011: begin // S-type (Store)
                alu_src = 1;
                mem_write = 1;
                memtoreg = 0;
            end
            7'b1100011: begin // B-type (Branch)
                alu_src = 0;
                branch = 1;
            end
            7'b1101111: begin // JAL (Jump)
                jump = 1;
                memtoreg = 0;
            end
            7'b1100111: begin // JALR (Jump and Link Register)
                jump = 1;
                memtoreg = 0;
            end
            7'b0110111: begin 
                alu_src = 1;
                reg_write = 1;
            end
            7'b0010111: begin 
                alu_src = 1;
                reg_write = 1;
            end
            default: begin
                // Default: no operation
                alu_src = 0;
                mem_read = 0;
                mem_write = 0;
                reg_write = 0;
                branch = 0;
                jump = 0;
                memtoreg = 0;
            end
        endcase
    end

endmodule
