`timescale 1ns/1ps
`define CYCLE   10.0
`define PAT_NUM 54
module PC_tb ();

    reg  [15:0] i_data_in;
    reg  i_data_reset;
    reg  i_data_load;
    reg  i_data_inc;
    wire [15:0] o_data;
    integer  i;
    reg      i_clk;

    reg  [15:0] pat_in       [0:`PAT_NUM-1];
    reg  pat_reset           [0:`PAT_NUM-1];
    reg  pat_load           [0:`PAT_NUM-1];
    reg  pat_inc           [0:`PAT_NUM-1];
    reg  [15:0] gold              [0:`PAT_NUM-1];
    wire tt;
    initial begin
        $readmemh("./tb/pat_in.dat", pat_in);
        $readmemh("./tb/pat_reset.dat", pat_reset);
        $readmemh("./tb/pat_load.dat", pat_load);
        $readmemh("./tb/pat_inc.dat", pat_inc);
        $readmemh("./tb/golden.dat", gold);
    end
 
    PC UUT (
        .in          (i_data_in      ),
        .clock       (i_clk      ),
        .load        (i_data_load      ),
        .inc        (i_data_inc      ),
        .reset       (i_data_reset      ),
        .out         (o_data    )    ,
        .t (tt)
    );

    initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, PC_tb, "+mda");
    end


    initial i_clk = 0;
    always #(`CYCLE/2.0) i_clk = ~i_clk;   

    initial begin
        i_data_in = 16'b0;
        i_data_inc = 0;
        i_data_load = 1'b0;
        i_data_reset = 1;
        #20
        i_data_reset = 0;
        #5
        i = -1;

            while (i < `PAT_NUM -1) begin
                @(posedge i_clk or negedge i_clk);
                    
                        i = i + 1 ;
                        i_data_in = pat_in [i];
                        i_data_load = pat_load [i];
                        i_data_inc = pat_inc [i];
                        i_data_reset = pat_reset [i];
                        #3
                        if (gold [i] !== o_data) begin
                            $display (
                                "Pattern: %3d, input in: %b, reset: %b, load: %b, inc: %b, expect output: %b, your output: %b, %b Failed",
                                i,
                                pat_in[i],
                                pat_reset[i],
                                pat_load[i],
                                pat_inc[i],
                                gold [i], 
                                o_data,
                                tt
                            );
                       //     $finish;
                        end
                        else begin
                            $display (
                                "Pattern: %3d, input in: %b, reset: %b, load: %b, inc: %b, expect output: %b, your output: %b, Pass",
                                i,
                                pat_in[i],
                                pat_reset[i],
                                pat_load[i],
                                pat_inc[i],
                                gold [i], 
                                o_data
                            );
                        end
                
        end
        $display("Congratulation! You have passed all pattern!");
        $finish;
    end
endmodule