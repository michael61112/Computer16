`include "/home/rduser08/project/Computer16/IC/Mux4/Mux4.v"
`include "/home/rduser08/project/Computer16/IC/FullAdder4/FullAdder4.v"
`include "/home/rduser08/project/Computer16/IC/Or8Way/Or8Way.v"
`include "/home/rduser08/project/Computer16/IC/Not6/Not6.v"
`include "/home/rduser08/project/Computer16/IC/And4/And4.v"
`include "/home/rduser08/project/Computer16/IC/Or4/Or4.v"

//  x[16], y[16],  // 16-bit inputs  
//  zx, // zero the x input?
//  nx, // negate the x input?
//  zy, // zero the y input?
//  ny, // negate the y input?
//  f,  // compute out = x + y (if 1) or x & y (if 0)
//  no; // negate the out output?
//  out[16], zr, ng;  // zr:zero, ng:negative

module Mux16(input[15:0] a, b, input sel, output[15:0] out);
    Mux4 g03(a[15:12],  b[15:12],  sel, out[15:12]);
    Mux4 g02(a[11:8],  b[11:8],  sel, out[11:8]);
    Mux4 g01(a[7:4],  b[7:4],  sel, out[7:4]);
    Mux4 g00(a[3:0],  b[3:0],  sel, out[3:0]);
endmodule;

module Add4(input[3:0] a, b, input cin, output[3:0] sum, output cout);
    wire c0,c1,c2,c3;
    FullAdder4 fa0(.a(a[3:0]), .b(b[3:0]), .cin({c2,c1,c0,cin}), .sum(sum[3:0]), .cout({c3,c2,c1,c0}));
    assign cout = c3;
endmodule;

module Add16(input[15:0] a, b, input cin, output[15:0] sum, output cout);
    wire c0,c1,c2,c3;
    Add4 a3(.a(a[15:12]), .b(b[15:12]), .cin(c2), .sum(sum[15:12]), .cout(c3));
    Add4 a2(.a(a[11:8]), .b(b[11:8]), .cin(c1), .sum(sum[11:8]), .cout(c2));
    Add4 a1(.a(a[7:4]), .b(b[7:4]), .cin(c0), .sum(sum[7:4]), .cout(c1));
    Add4 a0(.a(a[3:0]), .b(b[3:0]), .cin(1'b0), .sum(sum[3:0]), .cout(c0));
    assign cout = c3;
endmodule;

module Or16Way(input[15:0] in, output out);
    wire orLow,orHigh;
    wire [3:0] temp_out;
    Or8Way t0(in[7:0],  orLow);
    Or8Way t1(in[15:8], orHigh);
    Or4 o0({3'b0,orLow}, {3'b0,orHigh}, temp_out);
    assign out = temp_out[0];
endmodule;

module Not16(input[15:0] in, output[15:0] out);
    wire [5:0] temp_out;
    Not6 n2(.in({2'b0,in[15:12]}), .out(temp_out));
    assign out[15:12] = temp_out[3:0];
    Not6 n1(.in(in[11:6]), .out(out[11:6]));
    Not6 n0(.in(in[5:0]), .out(out[5:0]));
endmodule;

module And16(input[15:0] a, b, output[15:0] out);
    And4 a3(.a(a[15:12]), .b(b[15:12]), .out(out[15:12]));
    And4 a2(.a(a[11:8]), .b(b[11:8]), .out(out[11:8]));
    And4 a1(.a(a[7:4]), .b(b[7:4]), .out(out[7:4]));
    And4 a0(.a(a[3:0]), .b(b[3:0]), .out(out[3:0]));
endmodule;

module ALU(input[15:0] x, y, input zx,nx,zy,ny,f,no, output[15:0] out, output zr, ng);
  wire[15:0] x1, notx1, x2, y1, noty1, y2, andxy, addxy, o1, noto1, o2;
    wire orLow, orHigh, notzr,temp;
    wire[5:0] temp_zr;
    wire[3:0] temp_ng;
	
    Mux16 g1(.a(x), .b(16'b0), .sel(zx), .out(x1));   // if (zx == 1) set x = 0  
    Not16 g2(x1, notx1);
    Mux16 g3(x1, notx1, nx, x2);   // if (nx == 1) set x = !x
  
    Mux16 g4(y, 16'b0, zy, y1);   // if (zy == 1) set y = 0
    Not16 g5(y1, noty1);
    Mux16 g6(y1, noty1, ny, y2);   // if (ny == 1) set y = !y

    Add16 g7(x2, y2, 1'b0, addxy, temp);       // addxy = x + y
    And16 g8(x2, y2, andxy);       // andxy = x & y
  
    Mux16 g9(andxy, addxy, f, o1); // if (f == 1)  set out = x + y else set out = x & y
    Not16 g10(o1, noto1);
  
    Mux16 g11(o1, noto1, no, o2);   // if (no == 1) set out = !out
  
    // o2 就是 out, 但必須中間節點才能再次當作輸入，所以先用 o2。
    And16 g12(o2, o2, out); 
    Or16Way g13(o2, notzr);
    Not6   g16({5'b0, notzr}, temp_zr);            // zr = !nzr
    //And4   g17({3'b0, o2[15]}, {3'b0, o2[15]}, temp_ng);   // ng = out[15]
    assign zr = temp_zr[0];
    assign ng = o2[15];
endmodule;
