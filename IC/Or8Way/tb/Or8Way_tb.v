`timescale 1ns/1ps
`define CYCLE   10.0
`define PAT_NUM 256
module Or8Way_tb ();

    reg  [7:0] i_data_a;
    wire o_data;
    integer  i;

    reg  [7:0] pat_a    [0:`PAT_NUM-1];
    reg   gold     [0:`PAT_NUM-1];

    initial begin
        $readmemh("./tb/pat_a.dat", pat_a);
        $readmemh("./tb/golden.dat", gold);
    end
     
    Or8Way UUT (
        .in          (i_data_a      ),
        .out        (o_data    )    
    );

    initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, Or8Way_tb, "+mda");
    end
    
    initial begin
        i = 0;
        while (i < `PAT_NUM) begin
                i_data_a = pat_a [i];
                //$display(gold [i]);
                //$display(o_data);
                #10
                if (gold [i] !== o_data) begin
                    $display (
                        "Pattern: %3d, input a: %b, expect output: %b, your output: %b, Failed",
                        i,
                        pat_a[i],
                        gold [i], 
                        o_data
                    );
                    $finish;
                end
                else begin
                    $display (
                        "Pattern: %3d, input a: %b, expect output: %b, your output: %b, Pass",
                        i,
                        pat_a[i],
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