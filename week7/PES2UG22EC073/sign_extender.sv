module sign_extender (
    input  logic [12:0] imm_in,       // Immediate input (either 12-bit or 13-bit)
    output logic [31:0] imm_out       // 32-bit sign-extended output
);

    // Sign-extend the immediate value to 32 bits based on the input size
    always_comb begin
        if (imm_in[12] == 1'b0) begin
            imm_out = {{20{imm_in[11]}}, imm_in[11:0]};  // 12-bit sign extension
        end else begin
            imm_out = {{19{imm_in[12]}}, imm_in};  // 13-bit sign extension for B-type
        end
    end

endmodule
