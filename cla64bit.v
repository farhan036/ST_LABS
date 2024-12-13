module cla64bit (          //CLA 64 bit by (4) 16bit CLA and (1) 4 bit CLA 
    input [63:0] A, B,        // 64-bit inputs
    input cin,                // Carry input
    output [63:0] sum,        // 64-bit sum output
    output cout               // Carry output
);
    wire [3:0] gg,pp;       // Generate and Propagate signals for each CLA 16bit stage
    wire [63:0] c;         // Carry wires
    wire GFF, PFF;        // final generate , propagate  of 64 bit CLA
    wire c16, c32, c48, c64;  // Carryout wires for CLA stages from 4 bit CLA  

    // CLA modules for each 16-bit segment
    cla16bit cb0 (
        .A(A[15:0]),
        .B(B[15:0]),
        .cin(cin),          // Initial carry-in (cin)
        .cout(),
        .sum(sum[15:0]),
        .pro(pp[0]),
        .gen(gg[0]) 
    );
    
    cla16bit cb1 (
        .A(A[31:16]),
        .B(B[31:16]),
        .cin(c16),            // Carry-in from final cla caf 4bit block 
        .cout(),
        .sum(sum[31:16]),
        .pro(pp[1]),
        .gen(gg[1])
    );
    
    cla16bit cb2 (
        .A(A[47:32]),
        .B(B[47:32]),
        .cin(c32),        // Carry-in from final cla caf 4bit block 
        .cout(),
        .sum(sum[47:32]),
        .pro(pp[2]),
        .gen(gg[2])
    );
    
    cla16bit cb3 (
        .A(A[63:48]),
        .B(B[63:48]),
        .cin(c48),         // Carry-in from final cla caf 4bit block 
        .cout(),
        .sum(sum[63:48]), 
        .pro(pp[3]),
        .gen(gg[3])
    );
    cla caf (                         //module to get Cout of each CLA and enter it to To the next block CLA
        .g(gg),
        .p(pp),
        .cin(cin),                     // Initial carry-in (cin)
        .cout(c64),                   // Carry-out of 16 bit CLA
        .G(GFF),                     //final generate of 16 bit CLA
        .P(PFF),                    //final propagate of 16 bit CLA
        .c1(c16),                  //to create cout of block one of CLA 16 bit
        .c2(c32),                 //to create cout of block two of CLA 16 bit
        .c3(c48)                 //to create cout of block three of CLA 16 bit
    );

    
    assign cout = c64;  // The final carry-out is assigned to cout

endmodule

