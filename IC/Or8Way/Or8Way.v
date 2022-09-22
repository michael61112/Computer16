module Or8Way(input[7:0] in, output out);
  assign out = in[7] | in[6] | in[5] | in[4] | in[3] | in[2] | in[1] | in[0];
endmodule