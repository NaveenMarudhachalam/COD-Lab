module tb_ControlUnit();

    // Testbench signals
    logic [31:0] instruction;  // Full instruction input
    logic [4:0] alu_control;   // ALU operation signal
    logic alu_src;             // ALU source control signal
    logic mem_read;            // Memory read control signal
    logic mem_write;           // Memory write control signal
    logic reg_write;           // Register write control signal
    logic memtoreg;            // MUX signal for memory to register
    logic branch;              // Branch control signal
    logic jump;                // Jump control signal
    logic data_type;           // Data type control (signed/unsigned)
    logic [1:0] data_size;     // Data size control (byte/half-word/word)

    // Instantiate ControlUnit
    ControlUnit dut (
        .instruction(instruction),
        .alu_control(alu_control),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .memtoreg(memtoreg),
        .branch(branch),
        .jump(jump),
        .data_type(data_type),
        .data_size(data_size)
    );

    // Test process
    initial begin
        // Test R-type instruction (e.g., ADD)
        instruction = 32'b0000000_00010_00001_000_00011_0110011; // ADD x3, x1, x2
        #10;
        $display("R-type ADD Instruction:");
        $display("alu_control: %b, alu_src: %b, reg_write: %b", alu_control, alu_src, reg_write);

        // Test I-type instruction (e.g., ADDI)
        instruction = 32'b000000000001_00001_000_00010_0010011; // ADDI x2, x1, 1
        #10;
        $display("I-type ADDI Instruction:");
        $display("alu_control: %b, alu_src: %b, reg_write: %b", alu_control, alu_src, reg_write);

        // Test Load instruction (e.g., LW)
        instruction = 32'b000000000100_00001_010_00010_0000011; // LW x2, 4(x1)
        #10;
        $display("Load LW Instruction:");
        $display("mem_read: %b, memtoreg: %b, alu_src: %b", mem_read, memtoreg, alu_src);

        // Test Store instruction (e.g., SW)
        instruction = 32'b0000000_00010_00001_010_00100_0100011; // SW x2, 4(x1)
        #10;
        $display("Store SW Instruction:");
        $display("mem_write: %b, alu_src: %b", mem_write, alu_src);

        // Test Branch instruction (e.g., BEQ)
        instruction = 32'b0000000_00001_00010_000_00000_1100011; // BEQ x1, x2, 0
        #10;
        $display("Branch BEQ Instruction:");
        $display("branch: %b, alu_control: %b", branch, alu_control);

        // Test Jump instruction (e.g., JAL)
        instruction = 32'b000000000001_00000_000_00001_1101111; // JAL x1, 1
        #10;
        $display("Jump JAL Instruction:");
        $display("jump: %b", jump);

        $finish;
    end

endmodule
