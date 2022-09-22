# Open files
fp_a = open("pat_a.dat", "w")
fp_b = open("pat_b.dat", "w")
fp_s = open("pat_sel.dat", "w")
fp_g = open("golden.dat", "w") 

# Write pattern to files
for i in range(0,16,1):
    for j in range(0,16,1):
        for s in range(0,2,1):
            if s==0:
                out = i
            else:
                out = j
            print(bin(i),bin(j),bin(s),bin(out),  hex(i)[2:],hex(j)[2:],hex(s)[2:],hex(out)[2:])
            #out = (s==1) ? i : j
   
            fp_a.write(f'{hex(i)[2:]}\n')
            fp_b.write(f'{hex(j)[2:]}\n')
            fp_s.write(f'{hex(s)[2:]}\n')
            fp_g.write(f'{hex(out)[2:]}\n')

# Close files
fp_a.close()
fp_b.close()
fp_s.close()
fp_g.close()