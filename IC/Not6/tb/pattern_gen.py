import numpy as np
# Open files
fp_a = open("pat_a.dat", "w")
fp_g = open("golden.dat", "w") 

# Write pattern to files
for i in range(0,64,1):
    print(bin(i)[-6:], bin(~np.uint(i))[-6:],  hex(i)[2:],hex(~np.uint(i))[-2:])
    fp_a.write(f'{hex(i)[2:]}\n')
    fp_g.write(f'{hex(~np.uint(i))[-2:]}\n')

# Close files
fp_a.close()
fp_g.close()