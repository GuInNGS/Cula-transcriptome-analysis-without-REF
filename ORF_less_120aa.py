import sys,re,os

ORF_more_120aa = []
ORF_seq = {}
ORF_gene_name = ''
ORF_name = ''
seq = ''
flag = 0

with open(sys.argv[1],'r') as ORF:
    for i in ORF:
        if i.startswith('>'):
           ent = re.split('>|_|\[|\]|\s',i.strip())
           if flag == 0:
#                ORF_gene_name = ent[1]
                ORF_gene_name = ent[1]+'_'+ent[2]
#                ORF_name = ent[1]+'_'+ent[2]
                ORF_name = ent[1]+'_'+ent[2]+'_'+ent[3]
                flag = 1
           else:
               if ORF_gene_name not in ORF_seq:
                   ORF_seq[ORF_gene_name] = {}
                   ORF_seq[ORF_gene_name][ORF_name] = seq
                   seq = ''
               else:
                   ORF_seq[ORF_gene_name][ORF_name] = seq
                   seq = ''
#               ORF_gene_name = ent[1]
#               ORF_name = ent[1]+'_'+ent[2]
               ORF_gene_name = ent[1]+'_'+ent[2]
               ORF_name = ent[1]+'_'+ent[2]+'_'+ent[3]
        else:
            seq += i.strip()
ORF_seq[ORF_gene_name][ORF_name] = seq

ORF_more_120 = []
for i in ORF_seq:
    max_ORF = 0
    for j in ORF_seq[i]:
        if len(ORF_seq[i][j]) > 120:
            ORF_more_120.append(i)

with open(sys.argv[3],'w') as ORF_more_120_ORF_seq:
    for i in ORF_seq:
        if i in ORF_more_120:
            continue
        else:
            for j in ORF_seq[i]:
                ORF_more_120_ORF_seq.write('>'+j+'\n')
                ORF_more_120_ORF_seq.write(ORF_seq[i][j]+'\n')

nucleotide_flag = 0
nucleotide_name = ''
nucleotide_seq = ''
nucleotide_seq_dict = {}


with open(sys.argv[2],'r') as sequence_nucleotide:
    for i in sequence_nucleotide:
        if i.startswith('>'):
            if nucleotide_flag == 0:
                nucleotide_name = i.strip().split('>')[1]
                nucleotide_flag = 1
            else:
                nucleotide_seq_dict[nucleotide_name] = nucleotide_seq
                nucleotide_seq = ''
                nucleotide_name = i.strip().split('>')[1]
        else:
            nucleotide_seq += i.strip()
nucleotide_seq_dict[nucleotide_name] = nucleotide_seq

with open(sys.argv[4],'w') as nucleotide_seq_dict_seq:
    for i in nucleotide_seq_dict:
        if i in ORF_more_120:
            continue
        else:
            nucleotide_seq_dict_seq.write('>'+i+'\n')
            nucleotide_seq_dict_seq.write(nucleotide_seq_dict[i]+'\n')
