`include "/home/rduser08/project/Computer16/IC/Mux4/Mux4.v"


module Mux16(input[15:0] a, b, input sel, output[15:0] out);
    Mux4 g03(a[15:12],  b[15:12],  sel, out[15:12]);
    Mux4 g02(a[11:8],  b[11:8],  sel, out[11:8]);
    Mux4 g01(a[7:4],  b[7:4],  sel, out[7:4]);
    Mux4 g00(a[3:0],  b[3:0],  sel, out[3:0]);
endmodule;