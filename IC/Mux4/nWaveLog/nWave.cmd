wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/rduser08/project/Computer16/ALU/Mux4/tb.fsdb}
wvResizeWindow -win $_nWave1 35 32 1885 990
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/Mux4_tb"
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/Mux4_tb/gold\[0:255\]} \
{/Mux4_tb/i\[31:0\]} \
{/Mux4_tb/i_data_a\[3:0\]} \
{/Mux4_tb/i_data_b\[3:0\]} \
{/Mux4_tb/i_sel} \
{/Mux4_tb/o_data\[3:0\]} \
{/Mux4_tb/pat_a\[0:255\]} \
{/Mux4_tb/pat_b\[0:255\]} \
{/Mux4_tb/pat_sel\[0:255\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 )} 
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvSetPosition -win $_nWave1 {("G1" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/Mux4_tb/gold\[0:255\]} \
{/Mux4_tb/i\[31:0\]} \
{/Mux4_tb/i_data_a\[3:0\]} \
{/Mux4_tb/i_data_b\[3:0\]} \
{/Mux4_tb/i_sel} \
{/Mux4_tb/o_data\[3:0\]} \
{/Mux4_tb/pat_a\[0:255\]} \
{/Mux4_tb/pat_b\[0:255\]} \
{/Mux4_tb/pat_sel\[0:255\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 )} 
wvSetPosition -win $_nWave1 {("G1" 9)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvResizeWindow -win $_nWave1 54 237 960 332
wvResizeWindow -win $_nWave1 35 32 1885 990
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvZoom -win $_nWave1 1745.555614 2478.065559
wvZoom -win $_nWave1 1771.068062 1825.119858
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvResizeWindow -win $_nWave1 35 32 1885 990
