wvResizeWindow -win $_nWave1 35 35 1885 990
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/rduser08/project/Computer16/CPU/PC/tb.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/PC_tb"
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/PC_tb/i\[31:0\]} \
{/PC_tb/i_clk} \
{/PC_tb/i_data_in\[15:0\]} \
{/PC_tb/i_data_inc} \
{/PC_tb/i_data_load} \
{/PC_tb/i_data_reset} \
{/PC_tb/o_data\[15:0\]} \
{/PC_tb/tt} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 )} 
wvSetPosition -win $_nWave1 {("G1" 8)}
wvGetSignalClose -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomIn -win $_nWave1
wvZoom -win $_nWave1 184663.116883 247913.116883
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 182124.155844
wvResizeWindow -win $_nWave1 35 35 1885 990
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSetCursor -win $_nWave1 186767.087832
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 118096.310981 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 117050.619869 -snap {("G1" 7)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSetCursor -win $_nWave1 57744.995368 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 56549.919812 -snap {("G1" 7)}
wvBusWaveform -win $_nWave1 -digital
wvBusWaveform -win $_nWave1 -analog
wvSetPosition -win $_nWave1 {("G1" 8)}
wvBusWaveform -win $_nWave1 -digital
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetCursor -win $_nWave1 192041.611051
wvSetCursor -win $_nWave1 186663.771046
