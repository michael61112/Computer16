`include "/home/rduser08/project/Computer16/IC/BinaryCounter4/BinaryCounter4.v"

module PC(input[15:0] in, input clock, load, inc, reset, output[15:0] out);
  wire c0,c1,c2,c3;
    assign c0 = inc;
    assign c1 = (out[3:0] == 4'hf) ? 1'b1 : 1'b0;
    assign c2 = (out[7:0] == 8'hff) ? 1'b1 : 1'b0;
    assign c3 = (out[11:0] == 12'hfff) ? 1'b1 : 1'b0;
	
    BinaryCounter4 bc3(.in(in[15:12]), .clock(clock), .load(load), .inc(c3), .reset(reset), .out(out[15:12]));
    BinaryCounter4 bc2(.in(in[11:8]), .clock(clock), .load(load), .inc(c2), .reset(reset), .out(out[11:8]));
    BinaryCounter4 bc1(.in(in[7:4]), .clock(clock), .load(load), .inc(c1), .reset(reset), .out(out[7:4]));
    BinaryCounter4 bc0(.in(in[3:0]), .clock(clock), .load(load), .inc(c0), .reset(reset), .out(out[3:0]));
endmodule

