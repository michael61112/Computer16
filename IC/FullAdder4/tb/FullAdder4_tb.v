`timescale 1ns/1ps
`define CYCLE   10.0
`define PAT_NUM 4096
module FullAdder4_tb();

    reg  [3:0] i_data_a;
    reg  [3:0] i_data_b;
    reg  [3:0] i_data_c;
    wire [3:0] o_data_s;
    wire [3:0] o_data_c;
    integer            i;

    reg  [3:0] pat_a    [0:`PAT_NUM-1];
    reg  [3:0] pat_b    [0:`PAT_NUM-1];
    reg  [3:0] pat_c    [0:`PAT_NUM-1];
    reg  [3:0] gold_s     [0:`PAT_NUM-1];
    reg  [3:0] gold_c     [0:`PAT_NUM-1];

    initial begin
        $readmemh("./tb/pat_a.dat", pat_a);
        $readmemh("./tb/pat_b.dat", pat_b);
        $readmemh("./tb/pat_c.dat", pat_c);
        $readmemh("./tb/golden_s.dat", gold_s);
        $readmemh("./tb/golden_c.dat", gold_c);
    end
     
    FullAdder4 UUT (
        .a      (i_data_a      ),
        .b      (i_data_b    ),
        .cin    (i_data_c    ),
        .sum     (o_data_s    ),
        .cout    (o_data_c    )    
    );

    initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, FullAdder4_tb, "+mda");
    end
    
    initial begin
        i = 0;
        while (i < `PAT_NUM) begin
                i_data_a = pat_a [i];
                i_data_b = pat_b [i];
                i_data_c = pat_c [i];
                //$display(gold [i]);
                //$display(o_data);
                #10
                if (gold_s [i] !== o_data_s || gold_c [i] !== o_data_c) begin
                    $display (
                        "Pattern: %3d, input a: %b, input b: %b, input cin: %b, expect sum: %b, your sum: %b, expect cout: %b, your cout: %b, Failed",
                        i,
                        pat_a[i], 
                        pat_b[i], 
                        pat_c[i],
                        gold_s [i], 
                        o_data_s,
                        gold_c [i], 
                        o_data_c
                    );
                    $finish;
                end
                else begin
                    $display (
                        "Pattern: %3d, input a: %b, input b: %b, input cin: %b, expect sum: %b, your sum: %b, expect cout: %b, your cout: %b, Pass",
                        i,
                        pat_a[i], 
                        pat_b[i], 
                        pat_c[i],
                        gold_s [i], 
                        o_data_s,
                        gold_c [i], 
                        o_data_c
                    );
                end
                i = i + 1 ;
        end
        $display("Congratulation! You have passed all pattern!");
        $finish;
    end
endmodule