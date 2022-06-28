module Mux(input a, b, sel, output out);
    assign out = (sel) ? a : b;
endmodule;

module Mux4(input[3:0] a, b, input sel, output[3:0] out);
  Mux g03(a[3],  b[3],  sel, out[3]);
  Mux g02(a[2],  b[2],  sel, out[2]);
  Mux g01(a[1],  b[1],  sel, out[1]);
  Mux g00(a[0],  b[0],  sel, out[0]);
endmodule