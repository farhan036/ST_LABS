
`timescale 1ns / 1ps
module tb_cla64bit;
    // Inputs
    reg [63:0] a;
    reg [63:0] b;
    reg cin;
    
    // Outputs
    wire [63:0] sum;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    cla64bit uut (
        .A(a),
        .B(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Initialize Inputs
        a = 64'b0;
        b = 64'b0;
        cin = 0;

        // Apply test vectors
        #10 a = 64'h0000000000000001; b = 64'h0000000000000001; cin = 0; // 1 + 1 = 2
        #10 a = 64'h000000000000FFFF; b = 64'h0000000000000001; cin = 0; // 65535 + 1 = 65536
        #10 a = 64'hFFFFFFFFFFFFFFFF; b = 64'h0000000000000001; cin = 0; // Max + 1 = 0 (carry out 1)
        #10 a = 64'hAAAAAAAAAAAAAAAA; b = 64'h5555555555555555; cin = 0; // Alternating pattern addition
        #10 a = 64'hFFFFFFFFFFFFFF00; b = 64'h00000000000000FF; cin = 1; // Edge case with carry-in
        #10 a = 64'h0000000000000000; b = 64'h0000000000000000; cin = 1; // 0 + 0 + 1 = 1

        // Add more test cases as needed
        #10 $stop; // Stop the simulation
    end

    initial begin
        $monitor("At time %t, a = %h, b = %h, cin = %b, sum = %h, cout = %b",
                 $time, a, b, cin, sum, cout);
    end
endmodule
