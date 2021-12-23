###Seventh step 
###Quantification of unigenes expression using RSEM
input=/home/Chinese_fir_CW/input
output=/home/Chinese_fir_CW/output/RSEM

#Build rsem index
#/home/Chinese_fir_CW/bin/rsem-prepare-reference --bowtie2 /home/Chinese_fir_CW/output/unigene/cd_hit3/unigenes.fa $output/fir_rsem_ref
if [ ! -d "$output/rsem_out" ];then
        echo
        echo
        echo "[ `date` ] rsem-align-and-calculate-expression"
        mkdir -p $output/rsem_out
        myvar=0
		for i  in Cla-CK-Rep1_L3_175A75.R1 Cla-CK-Rep2_L3_318X18.R1 Cla-2h-CW-Rep1_L3_319X19.R1 Cla-2h-CW-Rep2_L3_320X20.R1 Cla-2h-OW-Rep1_L3_321X21.R1  Cla-2h-OW-Rep2_L3_322X22.R1  Cla-26h-CW-Rep1_L3_323X23.R1 Cla-26h-CW-Rep2_L3_324X24.R1 Cla-26h-OW-Rep1_L3_325X25.R1 Cla-26h-OW-Rep2_L3_326X26.R1 Cla-74h-CW-Rep1_L3_328X28.R1 Cla-74h-CW-Rep2_L3_329X29.R1 Cla-74h-OW-Rep1_L4_330X30.R1 Cla-74h-OW-Rep2_L4_332X32.R1 
        do
			for j in Cla-CK-Rep1_L3_175A75.R2 Cla-CK-Rep2_L3_318X18.R2 Cla-2h-CW-Rep1_L3_319X19.R2 Cla-2h-CW-Rep2_L3_320X20.R2 Cla-2h-OW-Rep1_L3_321X21.R2 Cla-2h-OW-Rep2_L3_322X22.R2 Cla-26h-CW-Rep1_L3_323X23.R2 Cla-26h-CW-Rep2_L3_324X24.R2 Cla-26h-OW-Rep1_L3_325X25.R2 Cla-26h-OW-Rep2_L3_326X26.R2 Cla-74h-CW-Rep1_L3_328X28.R2 Cla-74h-CW-Rep2_L3_329X29.R2 Cla-74h-OW-Rep1_L4_330X30.R2 Cla-74h-OW-Rep2_L4_332X32.R2
			do
				for k in Cla-CK-Rep1 Cla-CK-Rep2 Cla-2h-CW-Rep1 Cla-2h-CW-Rep2 Cla-2h-OW-Rep1 Cla-2h-OW-Rep2 Cla-26h-CW-Rep1 Cla-26h-CW-Rep2 Cla-26h-OW-Rep1 Cla-26h-OW-Rep2 Cla-74h-CW-Rep1 Cla-74h-CW-Rep2 Cla-74h-OW-Rep1 Cla-74h-OW-Rep2
				do
					/home/Chinese_fir_CW/bin/rsem-calculate-expression -p 10 --paired-end --bowtie2 --estimate-rspd --append-names $input/illuminafq/"$i"_.fastq $input/illuminafq/"$j"_.fastq $output/fir_rsem_ref $output/rsem_out/"$k"rsem &
					myvar=$(($myvar + 1 ))
					if [ "$myvar" = "4" ]
					then
							myvar=0
							wait
					fi
				done	
			done
        done
        wait
        echo
        echo
        echo "[`date`] Run complete"
        echo '-----------------------------------------------'
fi

#generate output_expected_count.matrix file for downstream deseq2 analysis 
mkdir -p $output/ck-2h-cw
/home/Chinese_fir_CW/bin/rsem-generate-data-matrix $output/rsem_out/Cla-CK-Rep1rsem.genes.results $output/rsem_out/Cla-CK-Rep2rsem.genes.results $output/rsem_out/Cla-2h-CW-Rep1rsem.genes.results $output/rsem_out/Cla-2h-CW-Rep2rsem.genes.results > $output/ck-2h-cw/output_expected_count.matrix

mkdir -p $output/ck-2h-ow
/home/Chinese_fir_CW/bin/rsem-generate-data-matrix $output/rsem_out/Cla-CK-Rep1rsem.genes.results $output/rsem_out/Cla-CK-Rep2rsem.genes.results $output/rsem_out/Cla-2h-OW-Rep1rsem.genes.results $output/rsem_out/Cla-2h-OW-Rep2rsem.genes.results > $output/ck-2h-ow/output_expected_count.matrix

mkdir -p $output/ck-26h-cw
/home/Chinese_fir_CW/bin/rsem-generate-data-matrix $output/rsem_out/Cla-CK-Rep1rsem.genes.results $output/rsem_out/Cla-CK-Rep2rsem.genes.results $output/rsem_out/Cla-26h-CW-Rep1rsem.genes.results $output/rsem_out/Cla-26h-CW-Rep2rsem.genes.results > $output/ck-26h-cw/output_expected_count.matrix

mkdir -p $output/ck-26h-ow
/home/Chinese_fir_CW/bin/rsem-generate-data-matrix $output/rsem_out/Cla-CK-Rep1rsem.genes.results $output/rsem_out/Cla-CK-Rep2rsem.genes.results $output/rsem_out/Cla-26h-OW-Rep1rsem.genes.results $output/rsem_out/Cla-26h-OW-Rep2rsem.genes.results > $output/ck-26h-ow/output_expected_count.matrix

mkdir -p $output/ck-74h-cw
/home/Chinese_fir_CW/bin/rsem-generate-data-matrix $output/rsem_out/Cla-CK-Rep1rsem.genes.results $output/rsem_out/Cla-CK-Rep2rsem.genes.results $output/rsem_out/Cla-74h-CW-Rep1rsem.genes.results $output/rsem_out/Cla-74h-CW-Rep2rsem.genes.results > $output/ck-74h-cw/output_expected_count.matrix

mkdir -p $output/ck-74h-ow
/home/Chinese_fir_CW/bin/rsem-generate-data-matrix $output/rsem_out/Cla-CK-Rep1rsem.genes.results $output/rsem_out/Cla-CK-Rep2rsem.genes.results $output/rsem_out/Cla-74h-OW-Rep1rsem.genes.results $output/rsem_out/Cla-74h-OW-Rep2rsem.genes.results > $output/ck-74h-ow/output_expected_count.matrix

#Delete undetected genes
input=/home/lfgu/bigdata/hitseq/rnaseq_Chinese_fir_tension_wood/output/deseq2_05
for i in ck-2h-cw ck-2h-ow ow-2h-cw ck-26h-cw ck-26h-ow ow-26h-cw ck-74h-cw ck-74h-ow ow-74h-cw
	do
	awk 'BEGIN{printf "geneid\ta1\ta2\tb1\tb2\n"}{if($2+$3+$4+$5>0)print $0}' $output/"$i"/output_expected_count.matrix > $output/"$i"/deseq2_input.txt
	done
echo "---------------finish--------------"

#Use the R script for subsequent deseq2 analysis


