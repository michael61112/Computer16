`define Register4 1
// 4 bits D-type Register
// SN74LS173

module DFF (input in, clock, rst_n, output reg out);
    always @(negedge clock)
        if (!rst_n)
            out <= 0;
        else
            out <= in;
endmodule;

module Bit(input in, clock, load, rst_n, output out);
    
    wire muxout, dffout;
    assign muxout = (load)? in : dffout;
	assign out = dffout;
	
	DFF dff1(muxout, clock, rst_n, dffout);
	
endmodule;

module Register4(input[3:0] in, input clock, load, rst_n, output[3:0] out);

    Bit g13(in[3],  clock, load, rst_n, out[3]);
    Bit g14(in[2],  clock, load, rst_n, out[2]);
    Bit g15(in[1],  clock, load, rst_n, out[1]);
    Bit g16(in[0],  clock, load, rst_n, out[0]);
    
endmodule;