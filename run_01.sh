###First step
###use SMRT Link v9.0 convert PacBio raw data into redundant isoforms sequence
###Instruction Manual		https://github.com/PacificBiosciences/IsoSeq/blob/master/isoseq-clustering.md

output=/home/Chinese_fir_CW/output/smrt_v9
Bin=/home/Chinese_fir_CW/bin/smrtlink/install/smrtlink-release_9.0.0.92188/bundles/smrttools/install/smrttools-release_9.0.0.92188/smrtcmds/bin

fir_ck_rep1=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla-CK-Rep1_m64064_201228_145803.subreads.9--9.bam
fir_ck_rep2=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla-CK-Rep2_m64064_201228_145803.subreads.10--10.bam
fir_2h_cw_rep1=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_2h_CW_Rep1_m64082_201231_134211.subreads.1--1.bam
fir_2h_cw_rep2=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_2h_CW_Rep2_m64082_201231_134211.subreads.2--2.bam
fir_2h_ow_rep1=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_2h_OW_Rep1_m64200e_210201_204916.subreads.3--3.bam
fir_2h_ow_rep2=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_2h_OW_Rep2_m64082_201231_134211.subreads.4--4.bam
fir_26h_cw_rep1=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_26h_CW_Rep1_m64082_201231_134211.subreads.5--5.bam
fir_26h_cw_rep2=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_26h_CW_Rep2_m64082_201231_134211.subreads.6--6.bam
fir_26h_ow_rep1=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_26h_OW_Rep1_m64082_201231_134211.subreads.7--7.bam
fir_26h_ow_rep2=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_26h_OW_Rep2_m64082_201231_134211.subreads.8--8.bam
fir_74h_cw_rep1=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_74h_CW_Rep1_m64189e_210323_092200.subreads.4--4.bam
fir_74h_cw_rep2=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_74h_CW_Rep2_m64064_201228_145803.subreads.6--6.bam
fir_74h_ow_rep1=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_74h_OW_Rep1_m64064_201228_145803.subreads.7--7.bam
fir_74h_ow_rep2=/home/Chinese_fir_CW/input/pacbio_rawdata/Cla_74h_OW_Rep2_m64064_201228_145803.subreads.8--8.bam


if [ ! -d "$output/CircularConsensus" ]; then
        echo
        echo
        echo "[`date`] CircularConsensus"
        echo '-----------------------------------------------'
        mkdir -p $output/CircularConsensus
        myvar=0
        for i in fir_ck_rep1 fir_ck_rep2 fir_2h_cw_rep1 fir_2h_cw_rep2 fir_2h_ow_rep1 fir_2h_ow_rep2 fir_26h_cw_rep1 fir_26h_cw_rep2 fir_26h_ow_rep1 fir_26h_ow_rep2 fir_74h_cw_rep1 fir_74h_cw_rep2 fir_74h_ow_rep1 fir_74h_ow_rep2
        do
	#remove [--noPolish]
	$Bin/ccs `eval echo '$'{$i}` $output/CircularConsensus/"$i"_ccs.bam --minPasses 1 --report-file $output/CircularConsensus/${i}_ccs_report.txt > $output/CircularConsensus/${i}.CircularConsensus.log 2>&1
                myvar=$(($myvar + 1 ))
                if [ "$myvar" = "6" ]
                then
                        myvar=0
                        wait
                fi
        done
        wait
	echo "[`date`] finsh"
	echo '-----------------------------------------------'
fi

if [ ! -d "$output/lima" ]; then
        echo
        echo
        echo "[`date`] lima"
        echo '-----------------------------------------------'
        mkdir -p $output/lima
        myvar=0
        for i in fir_ck_rep1 fir_ck_rep2 fir_2h_cw_rep1 fir_2h_cw_rep2 fir_2h_ow_rep1 fir_2h_ow_rep2 fir_26h_cw_rep1 fir_26h_cw_rep2 fir_26h_ow_rep1 fir_26h_ow_rep2 fir_74h_cw_rep1 fir_74h_cw_rep2 fir_74h_ow_rep1 fir_74h_ow_rep2
        do
        $Bin/lima $output/CircularConsensus/"$i"_ccs.bam primer.fa $output/lima/"$i"_demux.ccs.bam --isoseq  -j 15  >$output/lima/"$i"_demux.log 2>&1
                myvar=$(($myvar + 1 ))
                if [ "$myvar" = "6" ]
                then
                        myvar=0
                        wait
                fi
        done
        wait
	echo "[`date`] finsh"
	echo '-----------------------------------------------'
fi
	
if [ ! -d "$output/refine" ]; then
        echo
        echo
        echo "[`date`] refine"
        echo '-----------------------------------------------'
        mkdir -p $output/refine
        myvar=0
        for i in fir_ck_rep1 fir_ck_rep2 fir_2h_cw_rep1 fir_2h_cw_rep2 fir_2h_ow_rep1 fir_2h_ow_rep2 fir_26h_cw_rep1 fir_26h_cw_rep2 fir_26h_ow_rep1 fir_26h_ow_rep2 fir_74h_cw_rep1 fir_74h_cw_rep2 fir_74h_ow_rep1 fir_74h_ow_rep2
        do
        $Bin/isoseq3 refine $output/lima/"$i"_demux.ccs.5p--3p.bam primer.fa $output/refine/"$i"_movie.flnc.bam --require-polya > $output/refine/${i}.refine.log 2>&1
                myvar=$(($myvar + 1 ))
                if [ "$myvar" = "6" ]
                then
                        myvar=0
                        wait
                fi
        done
        wait
	echo "[`date`] finsh"
	echo '-----------------------------------------------'
fi

if [ ! -d "$output/cluster" ]; then
        echo
        echo
        echo "[`date`] cluster"
        echo '-----------------------------------------------'
        mkdir -p $output/cluster
        myvar=0
        for i in fir_ck_rep1 fir_ck_rep2 fir_2h_cw_rep1 fir_2h_cw_rep2 fir_2h_ow_rep1 fir_2h_ow_rep2 fir_26h_cw_rep1 fir_26h_cw_rep2 fir_26h_ow_rep1 fir_26h_ow_rep2 fir_74h_cw_rep1 fir_74h_cw_rep2 fir_74h_ow_rep1 fir_74h_ow_rep2
        do
        $Bin/isoseq3 cluster $output/refine/"$i"_movie.flnc.bam $output/cluster/"$i"_polished.bam --verbose --use-qvs >$output/cluster/"$i"_cluster.log 2>&1
                myvar=$(($myvar + 1 ))
                if [ "$myvar" = "6" ]
                then
                        myvar=0
                        wait
                fi
        done
        wait
	echo "[`date`] finsh"
	echo '-----------------------------------------------'
fi
