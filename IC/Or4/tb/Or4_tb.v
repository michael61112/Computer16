`timescale 1ns/1ps
`define CYCLE   10.0
`define PAT_NUM 256
module Or4_tb ();

    reg  [3:0] i_data_a;
    reg  [3:0] i_data_b;
    wire [3:0] o_data;
    integer            i;

    reg  [3:0] pat_a    [0:`PAT_NUM-1];
    reg  [3:0] pat_b    [0:`PAT_NUM-1];
    reg  [3:0] gold     [0:`PAT_NUM-1];

    initial begin
        $readmemh("./tb/pat_a.dat", pat_a);
        $readmemh("./tb/pat_b.dat", pat_b);
        $readmemh("./tb/golden.dat", gold);
    end
     
    Or4 UUT (
        .a          (i_data_a      ),
        .b          (i_data_b    ),
        .out        (o_data    )    
    );

    initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, Or4_tb, "+mda");
    end
    
    initial begin
        i = 0;
        while (i < `PAT_NUM) begin
                i_data_a = pat_a [i];
                i_data_b = pat_b [i];
                //$display(gold [i]);
                //$display(o_data);
                #10
                if (gold [i] !== o_data) begin
                    $display (
                        "Pattern: %3d, input a: %b, input b: %b, expect output: %b, your output: %b, Failed",
                        i,
                        pat_a[i], 
                        pat_b[i],
                        gold [i], 
                        o_data
                    );
                    $finish;
                end
                else begin
                    $display (
                        "Pattern: %3d, input a: %b, input b: %b, expect output: %b, your output: %b, Pass",
                        i,
                        pat_a[i], 
                        pat_b[i], 
                        gold [i],
                        o_data
                    );
                end
                i = i + 1 ;
        end
        $display("Congratulation! You have passed all pattern!");
        $finish;
    end
endmodule