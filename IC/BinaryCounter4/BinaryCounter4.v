`ifndef Register4
    `include "/home/rduser08/project/Computer16/IC/Register4/Register4.v"
`endif

// Main module
module BinaryCounter4(input[3:0] in, input clock, load, inc, rst_n, output [3:0] out);
    
    reg [3:0] out_temp;

    assign loadInc = load | inc;

    always@(posedge clock or negedge rst_n) begin
        if (!rst_n) begin
            out_temp <= 4'b0;
        end
        else if (load) begin
            out_temp <= in;
        end
        else if (inc) begin
            out_temp <= out_temp + 1'b1 ;           
        end

        else begin
           out_temp <= out_temp;
        end
    end

    Register4 reg1(out_temp[3:0], clock, loadInc, rst_n, out);
endmodule;

