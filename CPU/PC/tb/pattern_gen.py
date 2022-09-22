filepath = 'PC.cmp'
f = open(filepath,'r')
# Open files
fp_in = open("pat_in.dat", "w")
fp_reset = open("pat_reset.dat", "w")
fp_load = open("pat_load.dat", "w")
fp_inc = open("pat_inc.dat", "w")
fp_golden = open("golden.dat", "w") 

# Write pattern to files
count = len(open(filepath,'r').readlines())

print(f.readline())
patternL=[]
for v in range(1,count,1):
    patternL+=[f.readline().split('|')]

for pat in patternL:
    
    if int(pat[2],10) < 0 :
        inp = hex(int(pat[2],10)&0xffff)
    else:
        inp = hex(int(pat[2],10))
    reset = hex(int(pat[3],2))
    load = hex(int(pat[4],10))
    inc = hex(int(pat[5],2))
    if int(pat[6],10) < 0 :
        out = hex(int(pat[6],10)&0xffff)
    else:
        out = hex(int(pat[6],10))
    
    if int(pat[2],10) < 0 :
        fp_in.write(f'{inp[3:]}\n')
    else:
        fp_in.write(f'{inp[2:]}\n')
    fp_reset.write(f'{reset[2:]}\n')
    fp_load.write(f'{load[2:]}\n')
    fp_inc.write(f'{inc[2:]}\n')

    if int(pat[6],10) < 0 :
        fp_golden.write(f'{out[3:]}\n')
    else:
        fp_golden.write(f'{out[2:]}\n')
    

# Close files
fp_in.close()
fp_reset.close()
fp_load.close()
fp_inc.close()
fp_golden.close()