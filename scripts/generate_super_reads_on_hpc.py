import sys
import os

from assembly import get_superead



if __name__ == "__main__":
    i, outdir, type, min_cov, max_tip_len, n_correct, n_polish, rm_trans, trim_ends,polish_tool,rm_tmp,correct_mode,binpath=sys.argv[1:]
    i = int(i)
    min_cov=float(min_cov)
    max_tip_len=int(max_tip_len)
    n_correct=int(n_correct)
    n_polish=int(n_polish)
    rm_trans=int(rm_trans)
    if trim_ends=='False':
        trim_ends=False
    else:
        trim_ends=True
    if rm_tmp=='False':
        rm_tmp=False
    else:
        rm_tmp=True
    get_superead([i, outdir, type, min_cov, max_tip_len, n_correct, n_polish, rm_trans, trim_ends,polish_tool,rm_tmp,correct_mode,binpath])
    logfile=outdir+"/../generate_super_reads.log"
    with open(logfile,'a') as fw:
        print("{} cluster is finished.".format(i),file=fw,flush=True)
