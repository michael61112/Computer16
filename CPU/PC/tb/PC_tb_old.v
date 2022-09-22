module PC_tb();
    reg[15:0] in;
    reg load, inc, reset, clock;
    wire[15:0] out;
    
    PC pc(in, clock, load, inc, reset, out);
    
    initial
    begin
        $fsdbDumpfile("PC_tb.fsdb");
        $fsdbDumpvars(0, PC_tb, "+mda");
    end
    
    initial
    begin
      clock = 0;
      $monitor("%4dns clock=%d in=%d reset=%d inc=%d load=%d out=%d", $stime, clock, in, reset, inc, load, out);
    	inc = 0; load = 0; reset=0; in=7;
    	#10 reset=1; inc=1; 
    	#10 reset=0;
    	#10 reset=0;
    	#30 inc = 0; load=1;
    	#30 load = 0; inc=1;
    	in=4'hf;
    	#30 inc = 0; load=1;
    	#30 load = 0; inc=1;
    	in=8'hff;
    	#30 inc = 0; load=1;
    	#30 load = 0; inc=1;
    	in=12'hfff;
    	#30 inc = 0; load=1;
    	#30 load = 0; inc=1;
    	#30	$finish;
    end
    
    always #2 begin
      clock = clock + 1;
    end

endmodule