module Inst_Mem (
    input  logic reset,            // Reset signal
    input  logic [31:0] pc,        // Program counter (used as address)
    output logic [31:0] instr      // Fetched instruction
);


    logic [31:0] memory [0:1023];  // Instruction memory with 256 words

    
    initial begin
        // Load instructions from file or initialize 
        $readmemh("instructions.hex", memory);
    end 

    // Instruction fetch process
    always_comb begin
        if (reset) begin
            instr = 32'b0;  
        end
        else begin
            // Fetch instruction from memory based on PC
            instr = memory[pc];  // Using the lower 8 bits of PC as address
        end
    end

endmodule
