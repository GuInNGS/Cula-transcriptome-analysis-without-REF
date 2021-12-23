###Third step 
###database annotation
input=/home/Chinese_fir_CW/input
output=/home/Chinese_fir_CW/output/annotation

###NT Annotation
if [ ! -d "$output/nt" ]; then
        echo
        echo
        echo "[`date`] blast_nt"
        echo '-----------------------------------------------'
        mkdir -p $output/nt
#/home/Chinese_fir_CW/bin/makeblastdb -in $input/blastdatabase/nt.fasta -dbtype nucl -parse_seqids -out DBnt
        /home/Chinese_fir_CW/bin/blastn -query /home/Chinese_fir_CW/output/unigene/cd_hit3/unigenes.fa -out $output/nt/blast.DBnt.out -db $input/blastdatabase/DBnt -max_target_seqs 1 -outfmt 6 -evalue 1e-6 -num_threads 40
        wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'
fi

###NR Annotation
if [ ! -d "$output/nr" ]; then
        echo
        echo
        echo "[`date`] blast_nr"
        echo '-----------------------------------------------'
        mkdir -p $output/nr
#/home/Chinese_fir_CW/bin/makeblastdb -in $input/blastdatabase/nr.fasta -dbtype prot -parse_seqids -out DBnr
        /home/Chinese_fir_CW/bin/blastx -query /home/Chinese_fir_CW/output/unigene/cd_hit3/unigenes.fa -out $output/nr/blast.DBnr.out -db $input/blastdatabase/DBnr -max_target_seqs 1 -outfmt 6 -evalue 1e-6 -num_threads 40
        wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'
fi

###Pfam Annotation
if [ ! -d "$output/pfam" ]; then
        echo
        echo
        echo "[`date`] extract the long open reading frames"
        echo '-----------------------------------------------'
        mkdir -p $output/pfam
		/home/Chinese_fir_CW/bin/TransDecoder.LongOrfs -t /home/Chinese_fir_CW/output/unigene/cd_hit3/unigenes.fa -O $output/pfam
        wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'
        echo
        echo
        echo "[`date`] pfam searches.BlastP Search"
        echo '-----------------------------------------------' 
#/home/Chinese_fir_CW/bin/hmmpress $input/blastdatabase/Pfam-A.hmm
        wait
        /home/Chinese_fir_CW/bin/hmmscan --cpu 40  -o $output/pfam/pfam.txt --tblout $output/pfam/pfam.tbl --domtblout $output/pfam/pfam.domtblout $input/blastdatabase/Pfam-A.hmm $output/pfam/longest_orfs.pep
        wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'

###Swiss-Prot Annotation
if [ ! -d "$output/swissprot" ]; then
        echo
        echo
        echo "[`date`] Swipssprot"
        echo '-----------------------------------------------'
        mkdir -p $output/swissprot
#/home/Chinese_fir_CW/bin/makeblastdb -in $input/blastdatabase/swissprot.fasta -dbtype prot -parse_seqids -out DBswissprot
        /home/Chinese_fir_CW/bin/blastp -query $output/pfam/longest_orfs.pep -out $output/swissprot/blast.DBsw.out -db $input/blastdatabase/DBswissprot -max_target_seqs 1 -outfmt 6 -evalue 1e-6 -num_threads 40
        wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'
fi






