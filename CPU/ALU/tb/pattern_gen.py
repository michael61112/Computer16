filepath = 'ALU.out'
f = open(filepath,'r')


fp_a = open("pat_a.dat", "w")
fp_b = open("pat_b.dat", "w")
fp_s = open("pat_sel.dat", "w")
fp_go = open("golden_o.dat", "w")
fp_gz = open("golden_z.dat", "w")
fp_gn = open("golden_n.dat", "w")

count = len(open(filepath,'r').readlines())

print(f.readline())
patternL=[]
for v in range(1,count,1):
    patternL+=[f.readline().split('|')]

for pat in patternL:
    a = hex(int(pat[1],2))
    b = hex(int(pat[2],2))
    s = hex(int((pat[3]+pat[4]+pat[5]+pat[6]+pat[7]+pat[8]).replace(' ',''),2))
    gold_out = hex(int(pat[9],2))
    gold_zr = hex(int(pat[10],2))
    gold_ng = hex(int(pat[11],2))

    fp_a.write(f'{a[2:]}\n')
    fp_b.write(f'{b[2:]}\n')
    fp_s.write(f'{s[2:]}\n')
    fp_go.write(f'{gold_out[2:]}\n')
    fp_gz.write(f'{gold_zr[2:]}\n')
    fp_gn.write(f'{gold_ng[2:]}\n')

f.close()
fp_a.close()
fp_b.close()
fp_s.close()
fp_go.close()
fp_gz.close()
fp_gn.close()


