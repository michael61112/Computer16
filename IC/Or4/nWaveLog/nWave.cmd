wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/rduser08/project/Computer16/ALU/Or4/tb.fsdb}
wvSetCursor -win $_nWave1 94695.548996
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/Or4_tb"
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/Or4_tb/CLK} \
{/Or4_tb/gold\[0:255\]} \
{/Or4_tb/i\[31:0\]} \
{/Or4_tb/i_data_a\[3:0\]} \
{/Or4_tb/i_data_b\[3:0\]} \
{/Or4_tb/o_data\[3:0\]} \
{/Or4_tb/pat_a\[0:255\]} \
{/Or4_tb/pat_b\[0:255\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 )} 
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetCursor -win $_nWave1 15322.904368
wvSetCursor -win $_nWave1 14097.072019
wvSetCursor -win $_nWave1 15476.133412
wvSetCursor -win $_nWave1 15322.904368
wvSetCursor -win $_nWave1 15322.904368
wvExit
