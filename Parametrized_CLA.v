module cla #(
    parameter N = 64  // Parameter for bit width (default 4)
)(
    input [N-1:0] A,   // First input A
    input [N-1:0] B,   // Second input B
    input cin,          // Carry input
    output [N-1:1] c,   // Carry outputs (c1, c2, ..., c(N-1))
    output [N-1:0] sum, // Sum output
    output cout        // Final carry-out
);
    wire [N-1:0] g, p;   // Internal generation and propagation signals

    // Instantiate the gp module to generate g and p signals
    gppara #(.N(N)) gp_inst (
        .A(A),
        .B(B),
        .g(g),
        .p(p)
    );

    wire [N-1:0] carry;  // Internal carry wires

    // Carry terms calculation
    assign carry[0] = cin;  // First carry term
    genvar i;
    generate
        for (i = 1; i < N; i = i + 1) begin : generate_carry
            assign carry[i] = g[i-1] | (p[i-1] & carry[i-1]);  // Carry from bit i-1 to bit i
        end
    endgenerate
    
    // Assign carry outputs (c1 to c(N-1))
    assign c = carry[N-1:1]; 

    // Final carry output (cout)
    assign cout = g[N-1] | (p[N-1] & carry[N-1]);  // Final carry-out
    
    // Sum bits calculation (Sum = Propagate XOR Carry)
    assign sum = p ^ carry; // Sum = Propagate XOR Carry
    
    endmodule
