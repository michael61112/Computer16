# Open files
fp_a = open("pat_a.dat", "w")
fp_b = open("pat_b.dat", "w")
fp_c = open("pat_c.dat", "w")
fp_g = open("golden_s.dat", "w") 
fp_co = open("golden_c.dat", "w") 

# Write pattern to files
for i in range(0,16,1):
    for j in range(0,16,1):
        for k in range(0,16,1):
            
            sumab = i ^ j
            c_temp0 = i & j
            sum_o = sumab ^ k
            c_temp1 = sumab & k
            cout = c_temp0 | c_temp1
            print(bin(i), bin(j), bin(k),bin(sum_o), bin(cout),hex(i)[-1], hex(j)[-1], hex(k)[-1], hex(sum_o)[-1],hex(cout)[-1])
            fp_a.write(f'{hex(i)[-1]}\n')
            fp_b.write(f'{hex(j)[-1]}\n')
            fp_c.write(f'{hex(k)[-1]}\n')
            fp_g.write(f'{hex(sum_o)[-1]}\n')
            fp_co.write(f'{hex(cout)[-1]}\n')

# Close files
fp_a.close()
fp_b.close()
fp_c.close()
fp_g.close()
fp_co.close()