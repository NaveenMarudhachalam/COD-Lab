module mux_3_to_1 (
    input logic [31:0] in0,  // Input 0
    input logic [31:0] in1,  // Input 1
    input logic [31:0] in2,  // Input 2
    input logic [1:0] sel,    // Select signal (2 bits)
    output logic [31:0] out   // Output
);

    // Always block to implement the MUX functionality
    always_comb begin
        case (sel)
            2'b00: out = in0;   
            2'b01: out = in1;   
            2'b10: out = in2;   
            default: out = 32'b0; 
        endcase
    end

endmodule
