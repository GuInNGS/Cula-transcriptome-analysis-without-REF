import sys,re,os

flag = 0
trans_name = ''
seq = ''
trans = {}
with open(sys.argv[1],'r') as nucleotide:
    for i in nucleotide:
        if i.startswith('>'):
            if flag == 0:
                trans_name = i.strip()
                flag = 1
            else:
                if len(seq) > 200:
                    trans[trans_name] = seq
                trans_name = i.strip()
                seq = ''
        else:
            seq += i.strip()

for i in trans:
    print (i)
    print (trans[i])


