module instruction_decode (
    
    input  logic reset,
    input  logic regwrite,            // Control signal for writing to registers
    input  logic [31:0] instruction,  // Instruction from the fetch stage
    input  logic [31:0] wr_data,      // Data to write back to the register file
    output logic [31:0] rs1_data,     // Data from source register 1
    output logic [31:0] rs2_data,     // Data from source register 2
    output logic [31:0] imm_ext,       // Sign-extended immediate value
     output logic [6:0] opcode,
    output logic [6:0] funct7,
   output logic [2:0] funct3
);

    // Internal signals for register addresses and function codes
    logic [4:0] rs1_addr, rs2_addr, rd_addr;
    
    logic [12:0] imm;
   

    // Instantiate the instruction decoder
    instruction_decoder decoder (
        .instruction(instruction),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .funct7(funct7),
        .funct3(funct3),
        .imm(imm),
        .opcode(opcode)
    );

    // Instantiate the register file
    register_file regfile (
        .reset(reset),
        .regwrite(regwrite),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .wr_data(wr_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Instantiate the sign extender
    sign_extender sign_ext (
        .imm_in(imm),
        
        .imm_out(imm_ext)
    );

endmodule
