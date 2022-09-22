`timescale 1ns/1ps
`define CYCLE   10.0
`define PAT_NUM 36
module ALU_tb ();

    reg  [15:0] i_data_a;
    reg  [15:0] i_data_b;
    reg  [5:0] i_data_sel;
    wire [15:0] o_data;
    wire o_data_z;
    wire o_data_n;
    integer    i;

    reg  [15:0] pat_a    [0:`PAT_NUM-1];
    reg  [15:0] pat_b    [0:`PAT_NUM-1];
    reg  [5:0] pat_sel    [0:`PAT_NUM-1];
    reg  [15:0] gold_o   [0:`PAT_NUM-1];
    reg  gold_z   [0:`PAT_NUM-1];
    reg  gold_n   [0:`PAT_NUM-1];

    initial begin
        $readmemh("./tb/pat_a.dat", pat_a);
        $readmemh("./tb/pat_b.dat", pat_b);
        $readmemh("./tb/pat_sel.dat", pat_sel);
        $readmemh("./tb/golden_o.dat", gold_o);
        $readmemh("./tb/golden_z.dat", gold_z);
        $readmemh("./tb/golden_n.dat", gold_n);
    end

    ALU UUT (
        .x          (i_data_a      ),
        .y          (i_data_b    ),
        .zx         (i_data_sel[5]),
        .nx         (i_data_sel[4]),
        .zy         (i_data_sel[3]),
        .ny         (i_data_sel[2]),
        .f          (i_data_sel[1]),
        .no         (i_data_sel[0]),
        .out        (o_data    ),
        .zr        (o_data_z    ),
        .ng        (o_data_n    )    
    );

    initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, ALU_tb, "+mda");
    end
    
    initial begin
        i = 0;
        while (i < `PAT_NUM) begin
                i_data_a = pat_a [i];
                i_data_b = pat_b [i];
                i_data_sel = pat_sel [i];
                //$display(gold [i]);
                //$display(o_data);
                #10
                if (gold_o [i] !== o_data || gold_z [i] !== o_data_z || gold_n [i] !== o_data_n) begin
                    $display (
                        "Pattern: %3d, input a: %b, input b: %b, input |zx|nx|zy|ny|f|no|: %b, expect output: %b, your output: %b, expect zr: %b, your zr: %b, expect nr: %b, your nr: %b, Failed",
                        i,
                        pat_a[i], 
                        pat_b[i],
                        pat_sel[i],
                        gold_o [i], 
                        o_data,
                        gold_z [i], 
                        o_data_z,
                        gold_n [i], 
                        o_data_n
                    );
                    $finish;
                end
                else begin
                    $display (
                        "Pattern: %3d, input a: %b, input b: %b, input |zx|nx|zy|ny|f|no|: %b, expect output: %b, your output: %b, expect zr: %b, your zr: %b, expect nr: %b, your nr: %b, Pass",
                        i,
                        pat_a[i], 
                        pat_b[i],
                        pat_sel[i],
                        gold_o [i], 
                        o_data,
                        gold_z [i], 
                        o_data_z,
                        gold_n [i], 
                        o_data_n
                    );
                end
                i = i + 1 ;
        end
        $display("Congratulation! You have passed all pattern!");
        $finish;
    end
endmodule