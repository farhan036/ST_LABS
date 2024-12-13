module gppara #(
    parameter N = 4  // Parameter for bit width (default 4)
)(
    input [N-1:0] A,  // First input A
    input [N-1:0] B,  // Second input B
    output [N-1:0] g, // Generate output (g)
    output [N-1:0] p  // Propagate output (p)
);
    assign p = A ^ B;  // Propagate = A XOR B
    assign g = A & B;  // Generate = A AND B
endmodule
