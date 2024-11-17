module instruction_fetch (
    input  logic [31:0] branch_target, // Branch or jump target address from execution stage
    input  logic clk,                  // Clock signal
    input  logic reset,                // Reset signal
    input  logic pc_sel,               // Control signal for MUX (1 for branch/jump taken)
    output logic [31:0] pc_curr,       // Current Program Counter
    output logic [31:0] instruction    // Fetched instruction
);

    logic [31:0] pc_plus_4;           // PC + 4
    logic [31:0] selected_pc;         // Output of MUX (selected next PC)

    // Instantiate adder for PC + 4
    RTL_ADD add_pc_plus4 (
        .a(pc_curr),
        .b(32'd4),
        .sum(pc_plus_4)
    );

    // Instantiate multiplexer to select next PC
    RTL_MUX mux (
        .a(pc_plus_4),
        .b(branch_target),
        .sel(pc_sel),
        .y(selected_pc)
    );

    // Instantiate program counter register
    RTL_REG_SYNC pc_reg (
        .clk(clk),
        .reset(reset),
        .D(selected_pc),
        .Q(pc_curr)
    );

    // Instantiate instruction memory
    Inst_Mem inst_mem (
        .reset(reset),
        .pc(pc_curr),
        .instr(instruction)
    );

endmodule
