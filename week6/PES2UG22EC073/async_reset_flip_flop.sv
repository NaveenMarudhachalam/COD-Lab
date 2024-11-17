module async_reset_flip_flop (
    input logic clk,        // Clock input
    input logic reset,      // Asynchronous reset input
    input logic d,         // Data input
    output logic q         // Output
);

    // Always block triggered on the rising edge of the clock or the asynchronous reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;     
        end else begin
            q <= d;        
        end
    end

endmodule
