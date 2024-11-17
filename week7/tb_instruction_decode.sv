`timescale 1ns/1ps

module tb_instruction_decode;

    // Testbench signals
    logic reset;
    logic regwrite;
    logic [31:0] instruction;
    logic [31:0] wr_data;
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;
    logic [31:0] imm_ext;
    logic [6:0] opcode;
    logic [6:0] funct7;
    logic [2:0] funct3;


    instruction_decode uut (
        .reset(reset),
        .regwrite(regwrite),
        .instruction(instruction),
        .wr_data(wr_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm_ext(imm_ext),
        .opcode(opcode),
        .funct7(funct7),
        .funct3(funct3)
    );

    // Stimulus
    initial begin
        // Initialize signals
        reset = 1;
        regwrite = 0;
        instruction = 32'b0;
        wr_data = 32'b0;

        // Apply reset
        #10 reset = 0;

        // Test case 1: Simple R-type instruction (ADD)
        instruction = 32'b0000000_00010_00001_000_00011_0110011; // ADD x3, x1, x2
        #20;

        // Test case 2: I-type instruction (ADDI)
        instruction = 32'b000000000101_00001_000_00010_0010011; // ADDI x2, x1, 5
        #20;

        // Test case 3: Write-back to register file
        regwrite = 1;
        wr_data = 32'hDEADBEEF; // Write this value to rd
        #20 regwrite = 0;

        // Test case 4: B-type instruction (BEQ)
        instruction = 32'b0000000_00010_00001_000_0000001010_1100011; // BEQ x1, x2, 10
        #20;

        // Test case 5: S-type instruction (SW)
        instruction = 32'b0000000_00010_00001_010_0000000010_0100011; // SW x2, 2(x1)
        #20;

        // Test case 6: U-type instruction (LUI)
        instruction = 32'b00000000000000000001_00000_0110111; // LUI x1, 0x1
        #20;

        // End simulation
        #20 $finish;
    end

    // Monitor outputs for debugging
    initial begin
        $monitor("Time = %0t | Instruction = %b | Opcode = %h | Funct7 = %h | Funct3 = %h | Imm = %h | RS1 = %h | RS2 = %h | RD Data = %h", 
                 $time, instruction, opcode, funct7, funct3, imm_ext, rs1_data, rs2_data, wr_data);
    end

endmodule
