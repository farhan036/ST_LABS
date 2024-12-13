module gp (                    //generating propagate and generate module
    input [15:0] A, B,        // 4-bit inputs
    output [15:0]g,p               // g,p output
);
    assign p = A ^ B;         // Propagate = A XOR B
    assign g = A & B;         // Generate = A AND B


endmodule

