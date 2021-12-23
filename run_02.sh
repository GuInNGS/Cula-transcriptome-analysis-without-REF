###Sceond step
###Merge, de-redundancy, correct, and de-redundancy to obtain unigenes
input=/home/Chinese_fir_CW/input
output=/home/Chinese_fir_CW/output/unigene

if [ ! -d "$input/pacbiofa" ]; then
        echo
        echo
        echo "[`date`]fa.gz to fa"
        echo '-----------------------------------------------'
        mkdir -p $input/pacbiofa
        
		for i in fir_ck_rep1 fir_ck_rep2 fir_2h_cw_rep1 fir_2h_cw_rep2 fir_2h_ow_rep1 fir_2h_ow_rep2 fir_26h_cw_rep1 fir_26h_cw_rep2 fir_26h_ow_rep1 fir_26h_ow_rep2 fir_74h_cw_rep1 fir_74h_cw_rep2 fir_74h_ow_rep1 fir_74h_ow_rep2
		do
			gunzip -c /home/Chinese_fir_CW/output/smrt_v9/cluster/"$i"_polished.hq.fasta.gz > $input/pacbiofa/"$i"_hq.fasta
		done
        wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'
fi

if [ ! -d "$input/illuminafq" ]; then
        echo
        echo
        echo "[`date`]fq.gz to fq"
        echo '-----------------------------------------------'
        mkdir -p $input/illuminafq 
		for i  in Cla-CK-Rep1_L3_175A75.R1 Cla-CK-Rep1_L3_175A75.R2 Cla-CK-Rep2_L3_318X18.R1 Cla-CK-Rep2_L3_318X18.R2 Cla-2h-CW-Rep1_L3_319X19.R1 Cla-2h-CW-Rep1_L3_319X19.R2 Cla-2h-CW-Rep2_L3_320X20.R1 Cla-2h-CW-Rep2_L3_320X20.R2 Cla-2h-OW-Rep1_L3_321X21.R1 Cla-2h-OW-Rep1_L3_321X21.R2 Cla-2h-OW-Rep2_L3_322X22.R1 Cla-2h-OW-Rep2_L3_322X22.R2 Cla-26h-CW-Rep1_L3_323X23.R1 Cla-26h-CW-Rep1_L3_323X23.R2 Cla-26h-CW-Rep2_L3_324X24.R1 Cla-26h-CW-Rep2_L3_324X24.R2 Cla-26h-OW-Rep1_L3_325X25.R1 Cla-26h-OW-Rep1_L3_325X25.R2 Cla-26h-OW-Rep2_L3_326X26.R1 Cla-26h-OW-Rep2_L3_326X26.R2 Cla-74h-CW-Rep1_L3_328X28.R1 Cla-74h-CW-Rep1_L3_328X28.R2 Cla-74h-CW-Rep2_L3_329X29.R1 Cla-74h-CW-Rep2_L3_329X29.R2 Cla-74h-OW-Rep1_L4_330X30.R1 Cla-74h-OW-Rep1_L4_330X30.R2 Cla-74h-OW-Rep2_L4_332X32.R1 Cla-74h-OW-Rep2_L4_332X32.R2
		do
			gunzip -c $input/illumina_rawdata/"$i".fastq.gz > $input/illuminafq/"$i"_.fastq
		done
		wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'
fi

if [ ! -d "$output/fqmerge0" ]; then
        echo
        echo
        echo "[`date`].fastq Merging"
        echo '-----------------------------------------------'
        mkdir -p $output/fqmerge0
		for i  in Cla-CK-Rep1_L3_175A75.R1 Cla-CK-Rep1_L3_175A75.R2 Cla-CK-Rep2_L3_318X18.R1 Cla-CK-Rep2_L3_318X18.R2 Cla-2h-CW-Rep1_L3_319X19.R1 Cla-2h-CW-Rep1_L3_319X19.R2 Cla-2h-CW-Rep2_L3_320X20.R1 Cla-2h-CW-Rep2_L3_320X20.R2 Cla-2h-OW-Rep1_L3_321X21.R1 Cla-2h-OW-Rep1_L3_321X21.R2 Cla-2h-OW-Rep2_L3_322X22.R1 Cla-2h-OW-Rep2_L3_322X22.R2 Cla-26h-CW-Rep1_L3_323X23.R1 Cla-26h-CW-Rep1_L3_323X23.R2 Cla-26h-CW-Rep2_L3_324X24.R1 Cla-26h-CW-Rep2_L3_324X24.R2 Cla-26h-OW-Rep1_L3_325X25.R1 Cla-26h-OW-Rep1_L3_325X25.R2 Cla-26h-OW-Rep2_L3_326X26.R1 Cla-26h-OW-Rep2_L3_326X26.R2 Cla-74h-CW-Rep1_L3_328X28.R1 Cla-74h-CW-Rep1_L3_328X28.R2 Cla-74h-CW-Rep2_L3_329X29.R1 Cla-74h-CW-Rep2_L3_329X29.R2 Cla-74h-OW-Rep1_L4_330X30.R1 Cla-74h-OW-Rep1_L4_330X30.R2 Cla-74h-OW-Rep2_L4_332X32.R1 Cla-74h-OW-Rep2_L4_332X32.R2
		do
				cat $input/illuminafq/"$i"_.fastq
				#Output a blank line after each fasta output
				echo
		done > $output/fqmerge0/all.fastq
		wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'
fi

if [ ! -d "$output/famerge1" ]; then
        echo
        echo
        echo "[`date`].fasta Merging and de-redundancy"
        echo '-----------------------------------------------'
        mkdir -p $output/famerge1
        for i in fir_ck_rep1 fir_ck_rep2 fir_2h_cw_rep1 fir_2h_cw_rep2 fir_2h_ow_rep1 fir_2h_ow_rep2 fir_26h_cw_rep1 fir_26h_cw_rep2 fir_26h_ow_rep1 fir_26h_ow_rep2 fir_74h_cw_rep1 fir_74h_cw_rep2 fir_74h_ow_rep1 fir_74h_ow_rep2
        do
                cat $input/pacbiofa/"$i"_hq.fasta
                #Output a blank line after each fasta output
                echo
        done > $output/famerge1/all.fasta
        wait
#   -M  memory limit (in MB) for the program, default 800; 0 for unlimitted;
#   -T  number of threads, default 1; with 0, all CPUs will be used
#   -d: When it is 0, use the full name of the fasta file
        /home/Chinese_fir_CW/bin/cd-hit -i $output/famerge1/all.fasta -o $output/famerge1/all_hit.fa -c 0.99 -M 0 -T 0 -G 0 -aL 0.90 -AL 100 -aS 0.99 -AS 30
        wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'
fi

if [ ! -d "$output/correct2" ]; then
        echo
        echo
        echo "[`date`] lordec-correct"
        echo '-----------------------------------------------'
        mkdir -p $output/correct2
        /home/Chinese_fir_CW/bin/lordec-correct -2 $output/fqmerge0/all.fastq -t 5 -b 200 -e 0.4 -T 40 -k 21 -s 3 -S $output/correct2/statistics.log -i $output/famerge1/all_hit.fa -o $output/correct2/corrected.fasta >$output/correct2/correct.log 2>&1
        wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'
fi

if [ ! -d "$output/cd-hit3" ]; then
        echo
        echo
        echo "[`date`] second de-redundancy"
        echo '-----------------------------------------------'
        mkdir -p $output/cd_hit3
        /home/Chinese_fir_CW/bin/cd-hit -i $output/correct2/corrected.fasta -o $output/cd_hit3/unigenes_raw.fa -c 0.95 -M 0 -T 0 
        wait
        echo "[`date`] finsh"
        echo '----------------------------------------------'
fi
#Rename the sequence name of the fa file (transcript_1, transcript_2, transcript_3...)
awk 'BEGIN{i=0 ; FS="," ; OFS=","}{ if(/>/){gsub($1,">transcript_"++i,$1);print $0}else{print $0}}' $output/cd_hit3/unigenes_raw.fa > $output/cd_hit3/unigenes.fa
