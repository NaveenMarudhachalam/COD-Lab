module memory_stage (
    input logic reset,                // Reset signal
    input logic [31:0] address,       // Memory address
    input logic [31:0] write_data,    // Data to write to memory
    input logic mem_read,             // Control signal: Memory Read
    input logic mem_write,            // Control signal: Memory Write
    input logic data_type,            // Signed/Unsigned data type (0 for unsigned, 1 for signed)
    input logic [1:0] data_size,      // Data size (00: byte, 01: half-word, 10: word)
    output logic [31:0] read_data     // Data read from memory
);

    // Memory definition
    logic [7:0] memory [0:255]; // 256 bytes of memory (1 KB)

    // Reset Logic (Combinational)
    always_comb begin
        if (reset) begin
            for (int i = 0; i < 256; i++) memory[i] = 8'b0;
        end
    end

    // Read and Write Logic (Combinational)
    always_comb begin
        // Default values
        read_data = 32'b0;

        // Memory Read
        if (mem_read) begin
            case ({data_type, data_size})
                3'b000: read_data = {24'b0, memory[address]};                    // Unsigned Byte
                3'b001: read_data = {16'b0, memory[address + 1], memory[address]}; // Unsigned Half-Word
                3'b100: read_data = {{24{memory[address][7]}}, memory[address]}; // Signed Byte
                3'b101: read_data = {{16{memory[address + 1][7]}}, memory[address + 1], memory[address]}; // Signed Half-Word
                3'b010: read_data = {memory[address + 3], memory[address + 2], memory[address + 1], memory[address]}; // Word
                default: read_data = 32'b0; // Default to zero
            endcase
        end

        // Memory Write
        if (mem_write) begin
            case (data_size)
                2'b00: memory[address] = write_data[7:0];                      // Byte Write
                2'b01: {memory[address + 1], memory[address]} = write_data[15:0]; // Half-Word Write
                2'b10: {memory[address + 3], memory[address + 2], memory[address + 1], memory[address]} = write_data; // Word Write
            endcase
        end
    end

endmodule
