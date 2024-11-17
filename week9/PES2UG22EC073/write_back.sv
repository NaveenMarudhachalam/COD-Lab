module WB_MUX(
    input logic  sel,      
    input logic [31:0] a, b,   // 2 inputs: ALU result, memory data
    output logic [31:0] y        // output
);
    assign y = (sel == 1'b0) ? a : b ;     // ALU result
                            // Default output is 0
endmodule

module write_back_stage(
    input  logic [31:0] alu_result,     // Result from the ALU
    input  logic [31:0] mem_data,       // Data read from memory
    input  logic [1:0] sel,             // Select signal for WB_MUX
    output logic [31:0] write_back_data // Data to be written to the register file
);

    // MUX to select between ALU result, memory data, and PC current value
    WB_MUX write_back_mux (
        .a(alu_result),      // ALU result
        .b(mem_data),        // Data from memory
        .sel(sel),           // Control signal to select source
        .y(write_back_data)  // Data to be written back to register file
    );

endmodule
