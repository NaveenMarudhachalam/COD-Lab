module sync_reset_flip_flop (
    input logic clk,        // Clock input
    input logic reset,      // Synchronous reset input
    input logic d,          // Data input
    output logic q          // Output
);

    // Always block triggered on the rising edge of the clock
    always_ff @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;      
        end else begin
            q <= d;         
    end

endmodule
