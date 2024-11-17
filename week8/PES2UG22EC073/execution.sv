module execution (
    input  logic [31:0] pc,          // Current program counter (PC)
    input  logic [31:0] rs1_data,    // Data from rs1 register
    input  logic [31:0] rs2_data,    // Data from rs2 register
    input  logic [31:0] imm,         // Immediate value
    input  logic alu_src,            // ALU source control signal
    input  logic branch,             // Branch control signal for B-type
    input  logic jump,               // Jump control signal for J-type
    input  logic [4:0] alu_op,
    output logic [31:0] result,      // Final ALU result
    output logic [31:0] branch_target // Branch or jump target address
);

    // Internal signals
    logic [31:0] mux_out;            // Output of the MUX
    logic zero;                      // Zero flag from the ALU

    // Instantiate the MUX to select between rs2_data and immediate value
    RTL_MUX u_mux (
        .a(rs2_data),
        .b(imm),
        .sel(alu_src),
        .y(mux_out)
    );

    // Instantiate the ALU for arithmetic and logical operations
    ALU u_alu (
        .a(rs1_data),
        .b(mux_out),
        .alu_op(alu_op),
        .result(result),
        .zero(zero)
    );

    // Determine branch target based on instruction type
    always_comb begin
        // Default value for branch_target
        branch_target = pc; // Default: no branch or jump, so keep the PC unchanged
    
        if (jump) begin
            // For J-type instructions, branch_target is calculated based on the immediate value
            case (alu_op)
                5'b11000: begin
                    result = pc + 4;                  // jal
                    branch_target = pc + imm;         // Target address for jal
                end
                5'b11101:  begin
                    result = pc + 4;                  // jalr
                    branch_target = rs1_data + imm;          // Target address for jalr
                end
                default: begin
                    // Handle other J-type instructions if necessary
                    result = pc + 4;                  // Default action
                    branch_target = pc;               // Default target
                end
            endcase
        end else if (branch && zero) begin
            // For B-type instructions, branch_target is PC + immediate if branch condition is met
            branch_target = pc + imm;
        end
    end
        


endmodule
