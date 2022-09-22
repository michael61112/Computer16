`timescale 1ns/1ps
`define CYCLE   10.0
`define PAT_NUM 92
module CPU_tb ();

    reg  [15:0] i_data_inM;
    reg  [15:0] i_data_instruction;
    reg         i_data_reset;
    reg         i_rst_n;
    wire  [15:0] o_data_outM;
    wire         o_data_writeM;
    wire  [14:0] o_data_addressM;
    wire  [14:0] o_data_pc;
    wire  z;
    wire n;
    
    integer    i;
    reg                i_clk;

    reg  [15:0] pat_inM         [0:`PAT_NUM-1];
    reg  [15:0] pat_instruction [0:`PAT_NUM-1];
    reg  pat_reset              [0:`PAT_NUM-1];
    
    reg  [15:0] gold_outM       [0:`PAT_NUM-1];
    reg  gold_writeM            [0:`PAT_NUM-1];
    reg  [14:0] gold_addressM   [0:`PAT_NUM-1];
    reg  [14:0] gold_pc         [0:`PAT_NUM-1];

    initial begin
        $readmemh("./tb/pat_inM.dat", pat_inM);
        $readmemh("./tb/pat_instruction.dat", pat_instruction);
        $readmemh("./tb/pat_reset.dat", pat_reset);
        $readmemh("./tb/golden_outM.dat", gold_outM);
        $readmemh("./tb/golden_writeM.dat", gold_writeM);
        $readmemh("./tb/golden_addressM.dat", gold_addressM);
        $readmemh("./tb/golden_pc.dat", gold_pc);
    end

    CPU UUT (
        .inM            (i_data_inM         ),
        .instruction    (i_data_instruction ),
        .reset          (i_data_reset       ),
        .clk            (i_clk              ),
        .rst_n          (i_rst_n),

        .outM           (o_data_outM        ),
        .writeM         (o_data_writeM      ),
        .addressM       (o_data_addressM    ),
        .pc             (o_data_pc          )  ,
        .z(z),
        .n(n)
    );

    initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, CPU_tb, "+mda");
    end
    
    initial i_clk = 0;
    always #(`CYCLE/2.0) i_clk = ~i_clk;   
      
    initial begin
        i = -1;
        i_data_reset = 1;
        i_rst_n = 0;
        #15
        i_data_inM = 16'b0;
        i_data_instruction = 16'b0;
        i_data_reset = 0;
        i_rst_n = 1;
        while (i < `PAT_NUM -1) begin
        //    @(o_data_pc) begin
        //        i_data_instruction = pat_instruction [i+1];
        //    end
            @(posedge i_clk or negedge i_clk);
                
                    i = i + 1 ;
                    i_data_inM = pat_inM [i];
                    i_data_instruction = pat_instruction [i];
                    i_data_reset = pat_reset [i];
                    #3
                    if (gold_outM [i] != o_data_outM || gold_writeM [i] != o_data_writeM || gold_addressM [i] != o_data_addressM || gold_pc [i] != o_data_pc) begin
                        $display (
                            "Pattern: %3d, input inM: %b, instruction: %b, reset: %b" , 
                            i,
                            pat_inM[i], 
                            pat_instruction[i],
                            pat_reset[i]
                        );
                        $display (
                            "expect outM: %b, your : %b, expect writeM: %b, your : %b, expect addressM: %b, your : %b,  expect pc: %b, your : %b, %b,%b Failed",
                            gold_outM [i], 
                            o_data_outM,
                            gold_writeM [i], 
                            o_data_writeM,
                            gold_addressM [i], 
                            o_data_addressM,
                            gold_pc [i], 
                            o_data_pc  ,
                            z,
                            n
                        );
                       // $finish;
                    end
                    else begin
    //                    $display (
    //                        "Pattern: %3d, input inM: %b, instruction: %b, reset: %b" , 
    //                        i,
    //                        pat_inM[i], 
    //                        pat_instruction[i],
    //                        pat_reset[i]
    //                    );
                        $display (
                            "expect outM: %b, your : %b, expect writeM: %b, your : %b, expect addressM: %b, your : %b,  expect pc: %b, your : %b, Pass",
                            gold_outM [i], 
                            o_data_outM,
                            gold_writeM [i], 
                            o_data_writeM,
                            gold_addressM [i], 
                            o_data_addressM,
                            gold_pc [i], 
                            o_data_pc
                        );
                    end
                    if (i_clk < 1) begin
                        i_data_instruction = pat_instruction [i+1];
                    end
            end
        $display("Congratulation! You have passed all pattern!");
        $finish;
    end
endmodule