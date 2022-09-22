import numpy as np
# Open files
fp_a = open("pat_a.dat", "w")
fp_g = open("golden.dat", "w") 

# Write pattern to files
for i in range(0,256,1):
    if i !=0:
        out = 1
    else:
        out = 0
    print(bin(i), bin(out),  hex(i)[2:],hex(out)[-1:])
    fp_a.write(f'{hex(i)[2:]}\n')
    fp_g.write(f'{hex(out)[-1:]}\n')

# Close files
fp_a.close()
fp_g.close()