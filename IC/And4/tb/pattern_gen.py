# Open files
fp_a = open("pat_a.dat", "w")
fp_b = open("pat_b.dat", "w")
fp_g = open("golden.dat", "w") 

# Write pattern to files
for i in range(0,16,1):
    for j in range(0,16,1):
        print(bin(i),bin(j),bin(i&j),  hex(i)[2:],hex(j)[2:],hex(i&j)[2:])
        fp_a.write(f'{hex(i)[2:]}\n')
        fp_b.write(f'{hex(j)[2:]}\n')
        fp_g.write(f'{hex(i&j)[2:]}\n')

# Close files
fp_a.close()
fp_b.close()
fp_g.close()