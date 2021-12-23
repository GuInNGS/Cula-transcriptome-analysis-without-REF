###Sixth step
###Search homologous genes in Populus_trichocarpa
input=/home/Chinese_fir_CW/input
output=/home/Chinese_fir_CW/output/populus_homologous_gene
#/home/Chinese_fir_CW/bin/formatdb -i $input/blastdatabase/Ptrichocarpa_210_v3.0.protein_primaryTranscriptOnly -n $input/blastdatabase/Ptrichocarpa_210_v3.0.pep -t Ptrichocarpa_210_v3.0.pep -o T -p T
echo "[`date`] blast_fir_populus_pep"
/home/Chinese_fir_CW/bin/blastall -a 40 -p blastp -i  /home/Chinese_fir_CW/output/annotation/pfam/longest_orfs.pep -d $input/blastdatabase/Ptrichocarpa_210_v3.0.pep -F F -e 0.00001 -o $output/fir_populus_pep.out
echo '----------------finsh-------------------------------'
