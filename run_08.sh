###Eighth step  
###Generate unigene's TPM value summary file based on the results of RSEM

list_csv="/home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-CK-Rep1rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-CK-Rep2rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-2h-CW-Rep1rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-2h-CW-Rep2rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-2h-OW-Rep1rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-2h-OW-Rep2rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-26h-CW-Rep1rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-26h-CW-Rep2rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-26h-OW-Rep1rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-26h-OW-Rep2rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-74h-CW-Rep1rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-74h-CW-Rep2rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-74h-OW-Rep1rsem.genes.results /home/Chinese_fir_CW/output/RSEM/rsem_out/Cla-74h-OW-Rep2rsem.genes.results"
list_name="gene Cla-CK-Rep1 Cla-CK-Rep2 Cla-2h-CW-Rep1 Cla-2h-CW-Rep2 Cla-2h-OW-Rep1 Cla-2h-OW-Rep2 Cla-26h-CW-Rep1 Cla-26h-CW-Rep2 Cla-26h-OW-Rep1 Cla-26h-OW-Rep2 Cla-74h-CW-Rep1 Cla-74h-CW-Rep2 Cla-74h-OW-Rep1 Cla-74h-OW-Rep2"

echo $list_name
echo $list_csv
echo $list_name > /home/Chinese_fir_CW/output/RSEM/TPM_matrix.txt
python /home/Chinese_fir_CW/bin/rsem-count-extract.py $list_csv >> /home/Chinese_fir_CW/output/RSEM/TPM_matrix.txt
