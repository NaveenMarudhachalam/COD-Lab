module RTL_MUX(
    input  logic [31:0] a,    // Input 1 (PC + 4)
    input  logic [31:0] b,    // Input 2 (branch target)
    input  logic sel,         // Select signal
    output logic [31:0] y     // Output: selected input
);
    assign y = sel ? b : a;   // If sel = 1, choose b, else choose a
endmodule
