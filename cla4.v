module cla (                                               //Carry look ahead 4bit module
    input [3:0] g, p,                                     // 4-bit generation,propagation
    input cin,                                           // Carry input
    output c1,c2,c3, 
    output cout,G,P                                     // Carry output, Block generate and propagate signals
);
    wire [3:0] c;                                      // Carry wires    
    // Carry terms calculation
    assign c[0] = cin;              // Carry-in
    assign c[1] = g[0] | (p[0] & c[0]);  // Carry from bit 0 to bit 1
    assign c[2] = g[1] | (p[1] & c[1]);  // Carry from bit 1 to bit 2
    assign c[3] = g[2] | (p[2] & c[2]);  // Carry from bit 2 to bit 3
    assign cout = g[3] | (p[3] & c[3]);  // Final carry-out
    assign c1=c[1];                      //assign wire to outputs
    assign c2=c[2];
    assign c3=c[3];
    assign G = g[3] | (g[2] & p[3]) | (g[1] & p[2] & p[3]) | (g[0] & p[1] & p[2] & p[3]);
    assign P = p[0] & p[1] & p[2] & p[3];
endmodule
