
filepath = 'CPU.cmp'
f = open(filepath,'r')


fp_inM = open("pat_inM.dat", "w")
fp_instruction = open("pat_instruction.dat", "w")
fp_reset = open("pat_reset.dat", "w")
fp_gold_outM = open("golden_outM.dat", "w")
fp_gold_writeM = open("golden_writeM.dat", "w")
fp_gold_addressM = open("golden_addressM.dat", "w")
fp_gold_pc = open("golden_pc.dat", "w")

count = len(open(filepath,'r').readlines())

print(f.readline())
patternL=[]
for v in range(1,count,1):
    patternL+=[f.readline().split('|')]

for pat in patternL:
    inM = hex(int(pat[2],10))
    instruction = hex(int(pat[3],2))
    reset = hex(int(pat[4],2))
    if pat[5] != '*******':
        if int(pat[5],10) < 0:
            gold_outM = hex(int(pat[5],10)&0xffff)
        else:
            gold_outM = hex(int(pat[5],10))
    else:
        gold_outM = 'xxxx' #'*******'
    
    
    gold_writeM = hex(int(pat[6],2))
    gold_addressM = hex(int(pat[7],10))
    gold_pc = hex(int(pat[8],10))

    fp_inM.write(f'{inM[2:]}\n')
    fp_instruction.write(f'{instruction[2:]}\n')
    fp_reset.write(f'{reset[2:]}\n')
    if gold_outM != 'xxxx' :
        fp_gold_outM.write(f'{gold_outM[2:]}\n')
    else :
        fp_gold_outM.write(f'{gold_outM}\n')
    fp_gold_writeM.write(f'{gold_writeM[2:]}\n')
    fp_gold_addressM.write(f'{gold_addressM[2:]}\n')
    fp_gold_pc.write(f'{gold_pc[2:]}\n')

f.close()

fp_inM.close()
fp_instruction.close()
fp_reset.close()
fp_gold_outM.close()
fp_gold_writeM.close()
fp_gold_addressM.close()
fp_gold_pc.close()
