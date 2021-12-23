###Fourth step 
###lncRNA prediction
output=/home/Chinese_fir_CW/output/lncRNA

###Specify the output length of each line sequence as 60 
/home/Chinese_fir_CW/bin/seqkit seq -j 40 /home/Chinese_fir_CW/output/unigene/cd_hit3/unigenes.fa -w 60 > $output/unigenes_seq60.fa

#nucleotide more than 200
python /home/Chinese_fir_CW/bin/nucleotide_200bp.py $output/unigenes_seq60.fa > $output/unigenes_more_than_200bp.fa 

#ORF.less120aa transcript
/home/Chinese_fir_CW/bin/getorf -sequence $output/unigenes_more_than_200bp.fa -minsize 30 -outseq unigenes_more_than_200bp_ORF.fa
python /home/Chinese_fir_CW/bin/ORF_less_120aa.py $output/unigenes_more_than_200bp_ORF.fa $output/unigenes_seq60.fa select_ORF_less120aa.fa select_ORF_less120aa_nuc.fa

#CPC2 lncRNA online tool http://cpc2.gao-lab.org/
#Filter the result file, only keep noncoding sequences, and finally save it as result_cpc2.txt

#PLEK
python /home/Chinese_fir_CW/bin/PLEK.1.2/PLEK.py -fasta $output/select_ORF_less120aa_nuc.fa -out $output/all_plek.txt -thread 40
cat $output/all_plek.txt | grep 'Non-coding' | cut -f 1,2,3 >> $output/result_plek.txt


#CNCI
python /home/Chinese_fir_CW/bin/CNCI-master/CNCI.py  -f $output/select_ORF_less120aa_nuc.fa -o $output/cnci -m pl -p 40
cat $output/CNCI.index | grep 'noncoding' | cut -f 1,2,3,4,5,6 >> $output/result_cnci.txt

#Take the intersection of the results of CPC2, PLEK, and CNCI, and output their transcript id as lncRNAID.txt

python /home/Chinese_fir_CW/bin/transcriptid2fa.py $output/unigenes_seq60.fa $output/lncRNAID.txt $output/lncRNA.fa

