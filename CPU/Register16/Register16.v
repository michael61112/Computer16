`ifndef Register4
    `include "/home/rduser08/project/Computer16/IC/Register4/Register4.v"
`endif

module Register16(input[15:0] in, input clock, load, rst_n, output[15:0] out);
    Register4 r3(.in(in[15:12]), .clock(clock), .load(load), .rst_n(rst_n), .out(out[15:12]));
    Register4 r2(.in(in[11:8]), .clock(clock), .load(load), .rst_n(rst_n), .out(out[11:8]));
    Register4 r1(.in(in[7:4]), .clock(clock), .load(load), .rst_n(rst_n), .out(out[7:4]));
    Register4 r0(.in(in[3:0]), .clock(clock), .load(load), .rst_n(rst_n), .out(out[3:0]));
endmodule;