`timescale 1ns/1ps

module tb_execution;

    // Testbench signals
    logic [31:0] pc;                 // Current program counter
    logic [31:0] rs1_data;           // Data from rs1 register
    logic [31:0] rs2_data;           // Data from rs2 register
    logic [31:0] imm;                // Immediate value
    logic alu_src;                   // ALU source control signal
    logic branch;                    // Branch control signal
    logic jump;                      // Jump control signal
    logic [4:0] alu_op;              // ALU operation code
    logic [31:0] result;             // Final ALU result
    logic [31:0] branch_target;      // Branch or jump target address

    // Instantiate the DUT (Device Under Test)
    execution uut (
        .pc(pc),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm(imm),
        .alu_src(alu_src),
        .branch(branch),
        .jump(jump),
        .alu_op(alu_op),
        .result(result),
        .branch_target(branch_target)
    );

    // Stimulus
    initial begin
        // Initialize signals
        pc = 32'h00000000;
        rs1_data = 32'h00000000;
        rs2_data = 32'h00000000;
        imm = 32'h00000000;
        alu_src = 0;
        branch = 0;
        jump = 0;
        alu_op = 5'b00000;

        // Test case 1: R-type instruction (ADD)
        #10;
        rs1_data = 32'h00000010;
        rs2_data = 32'h00000020;
        alu_op = 5'b00000;  // ADD operation
        alu_src = 0;
        #10;

        // Test case 2: I-type instruction (ADDI)
        imm = 32'h00000008;
        alu_src = 1;  // Use immediate
        alu_op = 5'b00000;  // ADD operation
        #10;

        // Test case 3: B-type instruction (BEQ - branch taken)
        rs1_data = 32'h00000010;
        rs2_data = 32'h00000010;
        alu_src = 0;
        branch = 1;
        alu_op = 5'b01101;  // BEQ operation
        imm = 32'h00000004;  // Branch offset
        #10;

        // Test case 4: J-type instruction (JAL)
        branch = 0;
        jump = 1;
        alu_op = 5'b11000;  // JAL operation
        imm = 32'h00000010;
        #10;

        // Test case 5: JALR
        alu_op = 5'b11101;  // JALR operation
        rs1_data = 32'h00000100;
        imm = 32'h00000010;
        #10;

        // Test case 6
        jump = 0;
        branch = 0;
        alu_op = 5'b00000;
        rs1_data = 32'h00000030;
        rs2_data = 32'h00000010;
        alu_src = 0;
        imm = 32'h00000000;
        #10;

        // End simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0t | PC = %h | RS1 = %h | RS2 = %h | IMM = %h | ALU_OP = %b | ALU_SRC = %b | BRANCH = %b | JUMP = %b | RESULT = %h | BRANCH_TARGET = %h",
                 $time, pc, rs1_data, rs2_data, imm, alu_op, alu_src, branch, jump, result, branch_target);
    end

endmodule
