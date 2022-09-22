`include "/home/rduser08/project/Computer16/IC/Mux4/Mux4.v"
`include "/home/rduser08/project/Computer16/IC/FullAdder4/FullAdder4.v"
`ifndef not6
    `include "/home/rduser08/project/Computer16/IC/Not6/Not6.v"
`endif
`include "/home/rduser08/project/Computer16/IC/And4/And4.v"
`include "/home/rduser08/project/Computer16/IC/Xor4/Xor4.v"
`ifndef or4
    `include "/home/rduser08/project/Computer16/IC/Or4/Or4.v"
`endif

//  x[16], y[16],  // 16-bit inputs  
//  zx, // zero the x input?
//  nx, // negate the x input?
//  zy, // zero the y input?
//  ny, // negate the y input?
//  f,  // compute out = x + y (if 1) or x & y (if 0)
//  no; // negate the out output?
//  out[16], zr, ng;  // zr:zero, ng:negative

//  x3 = x2 + nx & zx    ;    x2 = ~zx & x1    ;    x1 = x ^ nx
//  y3 = y2 + ny & zy    ;    y2 = ~zy & y1    ;    y1 = y ^ ny
//  o1 = x3 + y3         ;    o2 = x3 & y3     ;    o3 = f ? o1 : o2
//  out = o3 ^ no        ;    ng = out[15]     ;    zr = ~(| out) 

module Add4(input[3:0] a, b, input cin, output[3:0] sum, output cout);
    wire c0,c1,c2,c3;
    FullAdder4 fa0(.a(a[3:0]), .b(b[3:0]), .cin({c2,c1,c0,cin}), .sum(sum[3:0]), .cout({c3,c2,c1,c0}));
    assign cout = c3;
endmodule;

module ALU4(input[3:0] x, y, input zx,nx,zy,ny,f,no, input cin, output[3:0] out, output cout);
    wire[3:0] x1, x2, x3, y1, y2, y3, o1, o2, o3;
	wire notzx, notzy, nxandzx, nxandzy;
	wire[3:0] and_temp;
	wire[5:0] not_temp;


	And4  a0({0,0,nx,ny}, {0,0,zx,zy}, and_temp);  //  nx & zx, ny & zy
	Not6  n0({4'b0,zx,zy}, not_temp);           // notzx = ~zx , notzy = ~zy
	assign nxandzx = and_temp[1];
	assign nxandzy = and_temp[0];
	assign notzx = not_temp[1];
	assign notzy = not_temp[0];
	
	
    Xor4  xor1(.a(x), .b({nx,nx,nx,nx}), .out(x1));                   // x1 = x ^ nx
    And4  a1(.a(x1), .b({notzx,notzx,notzx,notzx}), .out(x2));    // x2 = x1 & ~zx
    Or4   or1(.a(x2), .b({nxandzx,nxandzx,nxandzx,nxandzx}), .out(x3));//  x3 = x2 + nx & zx 
    
    Xor4  xor2(.a(y), .b({ny,ny,ny,ny}), .out(y1));                   // y1 = y ^ yx
    And4  a2(.a(y1), .b({notzy,notzy,notzy,notzy}), .out(y2));    // y2 = y1 & ~zy
    Or4   or2(.a(y2), .b({nxandzy,nxandzy,nxandzy,nxandzy}), .out(y3));//  y3 = y2 + ny & zy 

    Add4  add1(.a(x3), .b(y3), .cin(cin), .sum(o1), .cout(cout)); //  o1 = x3 + y3 
    And4  and1(.a(x3), .b(y3), .out(o2)); // o2 = x3 & y3 
    Mux4  m1(.a(o2), .b(o1), .sel(f), .out(o3)); // o3 = f ? o1 : o2

    Xor4  xor3(.a(o3), .b({no,no,no,no}), .out(out));//  out = o3 ^ no

endmodule;
