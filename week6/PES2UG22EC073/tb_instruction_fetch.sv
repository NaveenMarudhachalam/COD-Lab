`timescale 1ns/1ps

module tb_instruction_fetch;

    // Testbench signals
    logic clk;
    logic reset;
    logic pc_sel;
    logic [31:0] branch_target;
    logic [31:0] pc_curr;
    logic [31:0] instruction;

    // Instantiate the instruction_fetch module
    instruction_fetch uut (
        .branch_target(branch_target),
        .clk(clk),
        .reset(reset),
        .pc_sel(pc_sel),
        .pc_curr(pc_curr),
        .instruction(instruction)
    );

    // Clock generation
    initial begin
        clk = 0; // Initialize clock
        forever #10 clk = ~clk;  // Toggle clock every 10 ns (50 MHz)
    end

    // Stimulus
    initial begin
        // Initialize signals
        reset = 1; // Assert reset
        pc_sel = 0;
        branch_target = 32'd0;

        // Apply reset for a short duration
        #20 reset = 0; // Deassert reset after 20 ns

        // Normal fetching (PC + 4)
        #40 pc_sel = 0; // Set pc_sel to normal fetch

        // Simulate branch operation
        #40 pc_sel = 1; 
        branch_target = 32'h00000020; // Set branch target

        // Return to normal fetching
        #40 pc_sel = 0;

        // Simulate another branch
        #40 pc_sel = 1; 
        branch_target = 32'h00000040;

        // End simulation
        #40 $finish;
    end

    // Instruction memory initialization (ensure inst_mem is accessible)
    initial begin
        uut.inst_mem.memory[0]  = 32'h00000001;  // Instruction at PC = 0
        uut.inst_mem.memory[1]  = 32'h00000002;  // Instruction at PC = 4
        uut.inst_mem.memory[8]  = 32'h00000003;  // Instruction at PC = 32
        uut.inst_mem.memory[16] = 32'h00000004;  // Instruction at PC = 64
    end

    // Monitoring signals
    initial begin
        $monitor("Time: %0t | PC: %h | Instruction: %h | Branch Target: %h | PC Sel: %b", 
                 $time, pc_curr, instruction, branch_target, pc_sel);
    end

endmodule