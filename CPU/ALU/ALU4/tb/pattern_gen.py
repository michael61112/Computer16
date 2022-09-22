filepath = 'ALU.out'
ff = open(filepath,'r')


fp_a = open("pat_a.dat", "w")
fp_b = open("pat_b.dat", "w")
fp_s = open("pat_sel.dat", "w")
fp_go = open("golden_o.dat", "w")
fp_gz = open("golden_z.dat", "w")
fp_gn = open("golden_n.dat", "w")

count = len(open(filepath,'r').readlines())

print(ff.readline())
patternL=[]
for v in range(1,count,1):
    patternL+=[ff.readline().split('|')]

for pat in patternL:
    
    a_in = int(pat[1],2)&0xf
    b_in = int(pat[2],2)&0xf
    
    zx = pat[3].replace(' ','')
    nx = pat[4].replace(' ','')
    zy = pat[5].replace(' ','')
    ny = pat[6].replace(' ','')
    f = pat[7].replace(' ','')
    no = pat[8].replace(' ','')

    """
    a_in = 0
    b_in = 15
    zx='1'
    nx='0'
    zy='1'
    ny='0'
    f='1'
    no='0'
    """
    if (zx == '1') :
        zx_in = 0
    else :
        zx_in = a_in
    
    if (nx == '1') :
        nzx_in = (~zx_in & 0xf) 
    else:
        nzx_in = zx_in
    
    if (zy == '1') :
        zy_in = 0 
    else:
        zy_in = b_in
    
    if (ny == '1') :
        nzy_in = (~zy_in & 0xf) 
    else:
        nzy_in = zy_in
    
    if (f == '1'):
        f_out = (nzx_in + nzy_in)& 0xf 
    else:
        f_out = (nzx_in & nzy_in)& 0xf
    
    
    if (no == '1'):
        out = (~f_out & 0xf) 
    else :
        out = f_out
    
    a = hex(a_in)
    b = hex(b_in)
    s = hex(int((zx+nx+zy+ny+f+no),2))
    gold_out = hex(out & 0xf)
    gold_zr = hex(1 if (out ==0) else 0)
    gold_ng = hex(out & 0x8)

    fp_a.write(f'{a[2:]}\n')
    fp_b.write(f'{b[2:]}\n')
    fp_s.write(f'{s[2:]}\n')
    fp_go.write(f'{gold_out[2:]}\n')
    fp_gz.write(f'{gold_zr[2:]}\n')
    fp_gn.write(f'{gold_ng[2:]}\n')

ff.close()
fp_a.close()
fp_b.close()
fp_s.close()
fp_go.close()
fp_gz.close()
fp_gn.close()


