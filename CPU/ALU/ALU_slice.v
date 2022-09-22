`include "/home/rduser08/project/Computer16/IC/Or8Way/Or8Way.v"
`ifndef not6
    `include "/home/rduser08/project/Computer16/IC/Not6/Not6.v"
`endif
`include "/home/rduser08/project/Computer16/CPU/ALU/ALU4/ALU4.v"
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


module Or16Way(input[15:0] in, output out);
    wire orLow,orHigh;
    wire [3:0] temp_out;
    Or8Way t0(in[7:0],  orLow);
    Or8Way t1(in[15:8], orHigh);
    Or4 o0({3'b0,orLow}, {3'b0,orHigh}, temp_out);
    assign out = temp_out[0];
endmodule;

module ALU(input[15:0] x, y, input zx,nx,zy,ny,f,no, output[15:0] out, output zr, ng);
    wire[15:0] x1, x2, y1, y2, o1, o2;
    wire c0,c1,c2,cout, notzr;
    wire [5:0] temp_zr;
	
    ALU4 alu0(x[3:0], y[3:0], zx,nx,zy,ny,f,no, 1'b0, out[3:0],c0);
    ALU4 alu1(x[7:4], y[7:4], zx,nx,zy,ny,f,no, c0, out[7:4],c1);
    ALU4 alu2(x[11:8], y[11:8], zx,nx,zy,ny,f,no, c1, out[11:8],c2);
    ALU4 alu3(x[15:12], y[15:12], zx,nx,zy,ny,f,no, c2, out[15:12],cout);
    
    
    //And16 g12(o2, o2, out); 
    Or16Way g13(out, notzr);
    Not6   g16({5'b0, notzr}, temp_zr);            // zr = !nzr
    assign ng = out[15];
    assign zr = temp_zr[0];
endmodule;
