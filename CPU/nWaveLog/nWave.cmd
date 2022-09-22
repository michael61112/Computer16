wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/rduser08/project/Computer16/CPU/tb.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/CPU_tb"
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/CPU_tb/i\[31:0\]} \
{/CPU_tb/i_clk} \
{/CPU_tb/i_data_inM\[15:0\]} \
{/CPU_tb/i_data_instruction\[15:0\]} \
{/CPU_tb/i_data_reset} \
{/CPU_tb/n} \
{/CPU_tb/o_data_addressM\[14:0\]} \
{/CPU_tb/o_data_outM\[15:0\]} \
{/CPU_tb/o_data_pc\[14:0\]} \
{/CPU_tb/o_data_writeM} \
{/CPU_tb/z} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 )} 
wvSetPosition -win $_nWave1 {("G1" 11)}
wvGetSignalClose -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
