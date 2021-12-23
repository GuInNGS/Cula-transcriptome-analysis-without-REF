# Transcriptome-analysis-without-REF

The pipelines were constructed to analyze the Chinese fir transcriptome without a reference genome. We use PacBio full-length transcriptome data to obtain unigene, and use Illumina short-read transcriptome data for quantification.

**run_01.sh:**	Use SMRT Link v9.0 convert PacBio raw data into redundant isoforms sequence.

**run_02.sh:** Obtain Unigenes.

**run_03.sh:** Database (NT, NR, Pfam, Swiss-Prot) annotation.

**run_04.sh:** LncRNA prediction.

**run_05.sh:** TF prediction.

**run_06.sh:** Search homologous genes in Populus_trichocarpa.

**run_07.sh:** Quantification of unigenes expression using RSEM. And generate output_expected_count.matrix file for downstream DESeq2 analysis.

**run_08.sh:** Generate unigene's TPM value summary file based on the results of RSEM.

**nucleotide_200bp.py:** Use for run_04.

**ORF_less_120aa.py:** Use for run_04.

**transcriptid2fa.py:** Use for run_04.

**deseq2.r:** For the follow-up DESeq2 analysis of run_07.

**rsem-count-extract.py:** Use for run_08.
