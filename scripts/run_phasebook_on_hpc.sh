
# conda activate phasebook
#
# example:  real data, HG002(ONT)
input=reads.fa
#srcpath=/prj/whatshap-denovo/software/phasebook/scripts
srcpath=/prj/whatshap-denovo/github/phasebook/scripts
threads=48
outdir=`pwd`/out

###############################################
################ Divide stage #################
###############################################

python $srcpath/phasebook_hpc.py -i $input -o $outdir --nsplit 200 -t $threads -g large --min_cov 10 --min_identity 0.0 --min_read_len 1000 --min_sread_len 5000 --min_ovlp_len 1000 --n_correct 1 --n_polish 2 --platform ont --min_cluster_size 10 --level 2 --rm_trans 1 --sort_by_len True --trim_ends True --rename True --sp_min_ovlplen 5000 --sp_min_identity 0.95 --sp_oh 10 --ctg_asm naive --max_het_snps 0 --min_allele_cov 8 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 3 --max_ovlps 1000 --max_cluster_size 1000 --correct_mode msa --super_ovlp_fast True --stage 1


#all-vs-split overlap computation
perl -e 'my@fas;for my$fa( `ls $ARGV[0]/1.split_fastx/`){chomp $fa;push @fas,$fa;} for my$i(0..$#fas){print "/prj/whatshap-denovo/software/miniconda3/bin/minimap2 -x ava-ont -t 48  $ARGV[0]/../reads.fa $ARGV[0]/1.split_fastx/$fas[$i] 2>/dev/null |cut -f 1-12 |awk '\''\$11>=1000 && \$10/\$11 >=0.0 '\'' |/prj/whatshap-denovo/software/miniconda3/bin/fpa drop -i -m   >$ARGV[0]/2.overlap/ovlp.$i.paf\n";  } '  $outdir $input  >compute_overlaps_hpc.sh



#compute read overlaps, assign reads to clusters
#submit to HPC,  submit as 'array' jobs if possible
split -l 1 -a 3 compute_overlaps_hpc.sh  -d sub-ovlp

for i in sub-ovlp*;do qsub -cwd -P fair_share -S /bin/bash -l arch=lx-amd64 -l h_rt=30000:00:00,h_vmem=100G,vf=100G $i;done

#check unfinished jobs
perl -e '%unfinish; for (`ls -lh sub-ovlp*.e*`){chomp;my@a=split;$a[4]=~s/M//;my$job=$a[-1];$job=~s/\.e.*//;print " qsub -cwd -P fair_share -S /bin/bash -l arch=lx-amd64 -l h_rt=40000:00:00,h_vmem=200G,vf=200G $job \n "  if $a[4]; } ' >unfinish.overlap.sh


#generate scripts used to get super reads for each clusters
python $srcpath/phasebook_hpc.py -i $input -o $outdir --nsplit 200 -t $threads -g large --min_cov 10 --min_identity 0.0 --min_read_len 1000 --min_sread_len 5000 --min_ovlp_len 1000 --n_correct 1 --n_polish 2 --platform ont --min_cluster_size 10 --level 2 --rm_trans 1 --sort_by_len True --trim_ends True --rename True --sp_min_ovlplen 5000 --sp_min_identity 0.95 --sp_oh 10 --ctg_asm naive --max_het_snps 0 --min_allele_cov 8 --n_final_polish 1 --polish_tool racon --rm_tmp True --limited_times 3 --max_ovlps 1000 --max_cluster_size 1000 --correct_mode msa --super_ovlp_fast True --stage 2


#submit to HPC, run per cluster, submit as 'array' jobs if possible
split -l 1 -d -a 5 generate_super_reads_hpc.sh sub-sr
for i in `ls sub-sr*`;do qsub -cwd -P fair_share -S /bin/bash -l arch=lx-amd64 -l h_rt=20000:00:00,h_vmem=40G,vf=40G $i;done


#merge super reads
cd $outdir
perl -e 'open O,">unfinished.clusters" or die; my$n=`wc -l clustered_reads.list`;$n=(split/\s/,$n)[0] ;for my$i(1..$n){if(-e "3.cluster/c$i/$i.hap1.supereads.fa" or -e "3.cluster/c$i/$i.hap2.supereads.fa" or -e "3.cluster/c$i/$i.hapUnknown.supereads.fa"){system("cat 3.cluster/c$i/*.supereads.fa");}else{print O "$i\n";} } ' >all.supereads.fa

###############################################
################ Conquer stage ################
###############################################

##use parameter: --super_ovlp_fast True when handling with large genomes such as human genomes

python $srcpath/phasebook.stage2.py -i $input -o $outdir  --nsplit 1 -t $threads -g large  --sp_min_ovlplen 1000 --sp_min_identity 0.85 --sp_oh 50 --ctg_asm naive  --n_final_polish 0 --polish_tool racon --rm_tmp False --super_ovlp_fast True

#If not using final polish step, the final assembly file would be: $outdir/4.asm_supereads/final_contigs.fa
