module cla16bit (                  //Carry look ahead adder 16 bit
    input [15:0] A, B,            // 16-bit inputs
    input cin,                   // Carry input
    output [15:0] sum,          // 16-bit sum output
    output gen,pro,            //final generate and propagate signals o cla16bit
    output cout               // Carry output
);
    wire [15:0] c;                  // Carry wires
    wire [3:0] G, P;               // Generate and Propagate signals for each CLA stage
    wire [15:0] g, p;             // Generate, propagate signals for each bit
    assign c[0]=cin;     
    gp gp0 (                    //using  propagate and generate module
        .A(A),
        .B(B),
        .p(p),
        .g(g)
    );

    // CLA modules for each 4-bit segment
    cla ca0 (
        .g(g[3:0]),
        .p(p[3:0]),
        .cin(cin),                                 // Initial carry-in (cin)
        .cout(),                                  // Carry-out for cla ca0 4bit 
        .G(G[0]),               
        .P(P[0]),
        .c1(c[1]),                             //assign carry wires for using to get sum
        .c2(c[2]),
        .c3(c[3])
    );
cla ca1 (
        .g(g[7:4]),
        .p(p[7:4]),
        .cin(c[4]),       // Carry-in from final cla caf 4bit block 
        .cout(),         // Carry-out for cla ca1 4bit
        .G(G[1]),
        .P(P[1]),
        .c1(c[5]),            
        .c2(c[6]),
        .c3(c[7])
        
    );

    cla ca2 (
        .g(g[11:8]),
        .p(p[11:8]),
        .cin(c[8]),       // Carry-in from final cla caf 4bit block
        .cout(),         // Carry-out for cla ca2 4bit
        .G(G[2]),
        .P(P[2]),
        .c1(c[9]),
        .c2(c[10]),
        .c3(c[11])
    );

    cla ca3 (
        .g(g[15:12]),
        .p(p[15:12]),
        .cin(c[12]),      // Carry-in from final cla caf 4bit block
        .cout(),         // Carry-out for cla ca2 4bit
        .G(G[3]),
        .P(P[3]),
        .c1(c[13]),
        .c2(c[14]),
        .c3(c[15])
    );
    cla caf (                //module to get Cout of each CLA and enter it to To the next block CLA
        .g(G),
        .p(P),
        .cin(cin),                        // Initial carry-in (cin)
        .cout(cout),                     // Carry-out of 16 bit CLA
        .G(gen),                        //final generate of 16 bit CLA
        .P(pro),                       //final propagate of 16 bit CLA
        .c1(c[4]),                    //to create cout of block one of CLA 4 bit
        .c2(c[8]),                   //to create cout of block two of CLA 4 bit
        .c3(c[12])                  //to create cout of block three of CLA 4 bit
    );
    assign sum= p ^ c; //sum of 16 bit CLA 

endmodule

