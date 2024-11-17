module RTL_ADD(
    input  logic [31:0] a,    // First input
    input  logic [31:0] b,    // Second input
    output logic [31:0] sum   // Output: a + b
);
    assign sum = a + b;       // Simple adder logic
endmodule
