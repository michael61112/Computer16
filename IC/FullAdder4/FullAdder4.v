module HalfAdder(input a,b, output sum, cout);
	assign sum = a ^ b;
	assign cout = a & b;
endmodule

module FullAdder(input a, b, cin, output sum, cout);
    wire sumab,c_temp0,c_temp1;
    HalfAdder ha0(.a(a), .b(b), .sum(sumab), .cout(c_temp0));
    HalfAdder ha1(.a(sumab), .b(cin), .sum(sum), .cout(c_temp1));
    assign cout = c_temp0 | c_temp1;
endmodule;

module FullAdder4(input[3:0] a, b, cin, output[3:0] sum, cout);
    FullAdder fa3(.a(a[3]), .b(b[3]), .cin(cin[3]), .sum(sum[3]), .cout(cout[3]));
    FullAdder fa2(.a(a[2]), .b(b[2]), .cin(cin[2]), .sum(sum[2]), .cout(cout[2]));
    FullAdder fa1(.a(a[1]), .b(b[1]), .cin(cin[1]), .sum(sum[1]), .cout(cout[1]));
    FullAdder fa0(.a(a[0]), .b(b[0]), .cin(cin[0]), .sum(sum[0]), .cout(cout[0]));  
endmodule;