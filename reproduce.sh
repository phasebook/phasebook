#!/bin/bash
set -u

######### Run phasebook #########

srcpath=/root/capsule/code/scripts
threads=16

# simulated data, MHC pacbio hifi
input=/root/capsule/data/simulated/pbsim/hifi/mhc/15x/PGF_COX.pbsim.hifi.15x.fasta.gz 
python $srcpath/phasebook.py -i $input -o out --nsplit 1 -t $threads --min_cov 4 --min_identity 0.95 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 1000 --n_correct 0 --n_polish 1 --platform hifi --min_cluster_size 4 --level 8 --rm_trans 1 --sort_by_len False --trim_ends False --rename False --sp_min_ovlplen 1000 --sp_min_identity 0.99 --sp_oh 10 --ctg_asm rb --max_het_snps 0 --min_allele_cov 4 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 100000000 --max_ovlps 100000000 --max_cluster_size 100000000


## Note: the following code may cannot be run on 'Code Ocean' because of limited computational resources and storges ##

if false
then 
# simulated data,MHC pacbio clr
input=/root/capsule/data/simulated/pbsim/clr/mhc/25x/PGF_COX.pbsim.clr.25x.fasta.gz
## For other different sequencing coverage data (15x,25x,35x,45x)
#input=/root/capsule/data/simulated/pbsim/clr/mhc/*/PGF_COX.pbsim.clr.*.fasta.gz
python $srcpath/phasebook.py -i $input  --nsplit 1 -t $threads --min_cov 3 --min_identity 0.75 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform pb --min_cluster_size 8 --level 1 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 2000 --sp_min_identity 0.85 --sp_oh 500 --ctg_asm rb --max_het_snps 0 --min_allele_cov 6 --n_final_polish 2 --polish_tool racon --rm_tmp False --limited_times 100000000 --max_ovlps 100000000 --max_cluster_size 100000000

# simulated data, MHC ONT
input=/root/capsule/data/simulated/nanosim/mhc/25x/PGF_COX.reads.fa.gz
python $srcpath/phasebook.py -i $input  --nsplit 1 -t $threads --min_cov 10 --min_identity 0.75 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform ont --min_cluster_size 10 --level 1 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 1000 --sp_min_identity 0.85 --sp_oh 400 --ctg_asm rb --max_het_snps 0 --min_allele_cov 6 --n_final_polish 2 --polish_tool racon --rm_tmp False --limited_times 100000000 --max_ovlps 100000000 --max_cluster_size 100000000

# real data, HG00733_chr6, hifi
input=/root/capsule/data/real/hifi_HG00733/chr6.reads.fa.gz
python $srcpath/phasebook.py -i $input  --nsplit 1 -t $threads -g large --min_cov 3 --min_identity 0.9 --min_read_len 1000 --min_ovlp_len 900 --n_correct 0 --n_polish 1 --platform hifi --min_cluster_size 3 --level 3 --rm_trans 1 --sort_by_len False --trim_ends True --rename False --sp_min_ovlplen 1000 --sp_min_identity 0.98 --sp_oh 10 --ctg_asm rb --max_het_snps 0 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 100000000 --max_ovlps 100000000 --max_cluster_size 100000000 

# real data,  HG00733_chr6, clr
input=/root/capsule/data/real/clr_HG00733/chr6.reads.fa.gz
python $srcpath/phasebook.py -i $input  --nsplit 1 -t $threads -g large --min_cov 10 --min_identity 0.0 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform pb --min_cluster_size 10 --level 2 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 5000 --sp_min_identity 0.998 --sp_oh 2 --ctg_asm naive --max_het_snps 0 --min_allele_cov 8 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 3 --max_ovlps 1000 --max_cluster_size 1000 --correct_mode msa 

# real data, NA19240_chr6, ont
input=/root/capsule/data/real/ont_NA19240/chr6.reads.fa.gz
python $srcpath/phasebook.py -i $input  --nsplit 1 -t $threads -g large --min_cov 10 --min_identity 0.0 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform ont --min_cluster_size 10 --level 2 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 5000 --sp_min_identity 0.998 --sp_oh 2 --ctg_asm naive --max_het_snps 0 --min_allele_cov 8 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 3 --max_ovlps 1000 --max_cluster_size 1000 --correct_mode msa
fi 



######### Run other tools #########

## simulated datasets ##
# ls /root/capsule/result/*/*/*/*/work.sh
## real datasets ##
# ls /root/capsule/result/*/*/*/work.sh

## Note: the output assemblies of simulated datasets are located here ##
# ls /root/capsule/result/*/*/*/*/final_contigs.fa.gz
## Note: the output assemblies of real datasets are located here ##
# ls /root/capsule/result/*/*/*/final_contigs.fa.gz


######### Evaluation #########

## Note: the evaluation from QUAST of simulated datasets are located here ##
# For 'WhatsHap & HapCut2', use quast/contig_uniq/report.tsv 
# ls */*/*/*/quast/contig*/report.tsv

## Note: the evaluation from QUAST of real datasets are located here ##
# ls*/*/*/quast/contig*/report.tsv
