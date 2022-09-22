`timescale 1ns/1ps
`define CYCLE   10.0
`define PAT_NUM 148
module Register16_tb ();

    reg  [15:0] i_data_in;
    reg  i_data_load;
    reg  rst_n;
    wire [15:0] o_data;
    integer  i;
    reg                i_clk;

    reg  [15:0] pat_in       [0:`PAT_NUM-1];
    reg  pat_load           [0:`PAT_NUM-1];
    reg  [15:0] gold              [0:`PAT_NUM-1];

    initial begin
        $readmemh("./tb/pat_in.dat", pat_in);
        $readmemh("./tb/pat_load.dat", pat_load);
        $readmemh("./tb/golden.dat", gold);
    end
     
    Register16 UUT (
        .in          (i_data_in      ),
        .clock       (i_clk      ),
        .load        (i_data_load      ),
        .rst_n       (rst_n      ),
        .out         (o_data    )    
    );

    initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, Register16_tb, "+mda");
    end


    initial i_clk = 0;
    always #(`CYCLE/2.0) i_clk = ~i_clk;   

    initial begin
        i_data_in = 16'b0;
        i_data_load = 1'b0;
        rst_n = 0;
        #20
        rst_n = 1;
        #5
        i = -1;
        //@(negedge i_clk or posedge i_clk);
        //if (rst_n == 1) begin
            while (i < `PAT_NUM -1) begin
                @(posedge i_clk or negedge i_clk);
                    if (rst_n == 1) begin
                        i = i + 1 ;
                        i_data_in = pat_in [i];
                        i_data_load = pat_load [i];
                        //$display(gold [i]);
                        //$display(o_data);
                        
                        #3
                        if (gold [i] !== o_data) begin
                            $display (
                                "Pattern: %3d, input in: %b, load: %b, expect output: %b, your output: %b, Failed",
                                i,
                                pat_in[i],
                                pat_load[i],
                                gold [i], 
                                o_data
                            );
                            $finish;
                        end
                        else begin
                            $display (
                                "Pattern: %3d, input a: %b, load: %b, expect output: %b, your output: %b, Pass",
                                i,
                                pat_in[i],
                                pat_load[i],
                                gold [i],
                                o_data
                            );
                        end
                end
        end
        $display("Congratulation! You have passed all pattern!");
        $finish;
    end
endmodule