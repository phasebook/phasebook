#!/bin/bash
set -u

######### Run phasebook #########
# MHC hifi
srcpath=

python $srcpath/phasebook.py -i input.fq --nsplit 1 -t 48 --min_cov 4 --min_identity 0.95 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 1000 --n_correct 0 --n_polish 1 --platform hifi --min_cluster_size 4 --level 8 --rm_trans 1 --sort_by_len False --trim_ends False --rename False --sp_min_ovlplen 1000 --sp_min_identity 0.99 --sp_oh 10 --ctg_asm rb --max_het_snps 0 --min_allele_cov 4 --n_final_polish 1 --polish_tool racon --rm_tmp False --limited_times 300000 --max_ovlps 2700000000 --max_cluster_size 100000000
# MHC clr
/export/scratch3/vincent/project/TGS_assembly/whatshapDenovo/mhc/clr/25x
$ cat work.sh

timef python /export/scratch3/vincent/project/bitbucket/long_reads/whatshapdenovo/whatshapdenovo2.py -i input.fq -p s1_s1.paf --nsplit 1 -t 48 --min_cov 10 --min_identity 0.75 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform pb --min_cluster_size 10 --level 1 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 1000 --sp_min_identity 0.85 --sp_oh 400 --ctg_asm rb --max_het_snps 0 --min_allele_cov 6 --n_final_polish 2 --polish_tool racon --rm_tmp False --limited_times 300000 --max_ovlps 2700000000 --max_cluster_size 100000000


#timef python /export/scratch3/vincent/project/bitbucket/long_reads/whatshapdenovo/whatshapdenovo2.stage2.py -i input.fq -p s1_s1.paf --nsplit 1 -t 48 --min_cov 3 --min_identity 0.75 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform pb --min_cluster_size 8 --level 1 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 2000 --sp_min_identity 0.85 --sp_oh 500 --ctg_asm rb --max_het_snps 0 --min_allele_cov 6 --n_final_polish 2 --polish_tool racon --rm_tmp False --limited_times 300000 --max_ovlps 2700000000 --max_cluster_size 100000000
mhc/ont
/export/scratch3/vincent/project/TGS_assembly/whatshapDenovo/mhc/ont/25x
$ cat work.sh

conda activate whatshap

#run from scratch
timef python /export/scratch3/vincent/project/bitbucket/long_reads/whatshapdenovo/whatshapdenovo2.py -i input.fa --nsplit 1 -t 48 --min_cov 10 --min_identity 0.75 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform ont --min_cluster_size 10 --level 1 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 1000 --sp_min_identity 0.85 --sp_oh 400 --ctg_asm rb --max_het_snps 0 --min_allele_cov 6 --n_final_polish 2 --polish_tool racon --rm_tmp False --limited_times 300000 --max_ovlps 2700000000 --max_cluster_size 100000000




timef python /export/scratch3/vincent/project/bitbucket/long_reads/whatshapdenovo/whatshapdenovo2.py -i input.fa -p s1_s1.paf --nsplit 1 -t 48 --min_cov 10 --min_identity 0.75 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform ont --min_cluster_size 10 --level 1 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 1000 --sp_min_identity 0.85 --sp_oh 400 --ctg_asm rb --max_het_snps 0 --min_allele_cov 6 --n_final_polish 2 --polish_tool racon --rm_tmp False --limited_times 300000 --max_ovlps 2700000000 --max_cluster_size 100000000

HG00733_chr6/hifi/
cat /export/scratch3/vincent/project/TGS_assembly/whatshapDenovo/HG00733_chr6/hifi/work.sh
#conda activate whatshap

ln -fs /export/scratch3/vincent/project/TGS_assembly/7.real_data/HG00733/hifi/chr6.reads.fa reads.fa

python /export/scratch3/vincent/project/bitbucket/long_reads/whatshapdenovo/whatshapdenovo2.py -i reads.fa --nsplit 1 -t 48 --min_cov 3 --min_identity 0.9 --min_read_len 1000 --min_ovlp_len 900 --n_correct 0 --n_polish 1 --platform hifi --min_cluster_size 3 --level 3 --rm_trans 1 --sort_by_len False --trim_ends True --rename False --sp_min_ovlplen 1000 --sp_min_identity 0.98 --sp_oh 10 --ctg_asm rb --max_het_snps 0 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 300000 --max_ovlps 2700000000 --max_cluster_size 100000000

HG00733_chr6/clr
/prj/whatshap-denovo/project/diploid/result/HG00733_chr6/clr/naive
$ cat work.sh

#from scratch, compute read overlaps without -c
#python /prj/whatshap-denovo/github/whatshapdenovo/scripts/whatshapdenovo2.py -i input.fa --nsplit 1 -t 100 --min_cov 10 --min_identity 0.0 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform pb --min_cluster_size 10 --level 2 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 5000 --sp_min_identity 0.995 --sp_oh 2 --ctg_asm naive --max_het_snps 0 --min_allele_cov 8 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 3 --max_ovlps 1000 --max_cluster_size 1000 --correct_mode msa



#from overlap, use rb method


#stage2
python /prj/whatshap-denovo/github/whatshapdenovo/scripts/whatshapdenovo2.stage2.py -i input.fa --nsplit 1 -p s1_s1.paf -t 100 --min_cov 10 --min_identity 0.0 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform pb --min_cluster_size 10 --level 2 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 5000 --sp_min_identity 0.998 --sp_oh 2 --ctg_asm naive --max_het_snps 0 --min_allele_cov 8 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 3 --max_ovlps 1000 --max_cluster_size 1000 --correct_mode msa


NA19240_chr6/ont
/prj/whatshap-denovo/project/diploid/result/NA19240_chr6/ont

$ cat work.sh

#from scratch, compute read overlaps without -c
#python /prj/whatshap-denovo/github/whatshapdenovo/scripts/whatshapdenovo2.py -i input.fa --nsplit 1 -t 100 --min_cov 10 --min_identity 0.0 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform ont --min_cluster_size 10 --level 2 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 5000 --sp_min_identity 0.98 --sp_oh 2 --ctg_asm naive --max_het_snps 0 --min_allele_cov 8 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 3 --max_ovlps 1000 --max_cluster_size 1000 --correct_mode msa

#from overlap, use rb method
#stage2
python /prj/whatshap-denovo/github/whatshapdenovo/scripts/whatshapdenovo2.stage2.py -i input.fa --nsplit 1 -t 100 --min_cov 10 --min_identity 0.0 --min_read_len 1000 --min_sread_len 1000 --min_ovlp_len 900 --n_correct 2 --n_polish 2 --platform ont --min_cluster_size 10 --level 2 --rm_trans 1 --sort_by_len True --trim_ends True --rename False --sp_min_ovlplen 5000 --sp_min_identity 0.998 --sp_oh 2 --ctg_asm naive --max_het_snps 0 --min_allele_cov 8 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 3 --max_ovlps 1000 --max_cluster_size 1000 --correct_mode msa
