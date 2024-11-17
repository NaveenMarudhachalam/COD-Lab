module register_file (
    input  logic reset,                // Reset signal
    input  logic regwrite,             // Register write enable
    input  logic [4:0] rs1_addr,       // Address for source register 1
    input  logic [4:0] rs2_addr,       // Address for source register 2
    input  logic [4:0] rd_addr,        // Address for destination register
    input  logic [31:0] wr_data,       // Data to write to destination register
    output logic [31:0] rs1_data,      // Data read from source register 1
    output logic [31:0] rs2_data       // Data read from source register 2
);

    logic [31:0] regfile [31:0];  // Register file with 32 registers

    // Initialize registers (optional)
    initial begin
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            regfile[i] = 32'b0;
        end
    end

    // Read registers
    always_comb begin
        if (!reset) begin
            if(regwrite) begin
			 regfile[rd_addr] = wr_data;
            end
            rs1_data = regfile[rs1_addr];  // Read from rs1
            rs2_data = regfile[rs2_addr];  // Read from rs2
        end
        else begin
            rs1_data = 32'b0;
            rs2_data = 32'b0;
        end
    end

endmodule
