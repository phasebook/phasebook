import sys

'''
 Convert a fastq file to a fasta file and vice versa.
'''

def fq2fa(fq,fa):
    out=[]
    with open(fq,'r') as fr:
        c=0
        for line in fr:
            c+=1
            if (c%4) == 1:
                out.append('>' + line[1:])
            elif (c%4) == 2:
                out.append(line)
    with open(fa,'w') as fw:
        fw.write(''.join(out))
    return

def fa2fq(fa,fq):
    seq=''
    out=[]
    n_reads=0
    with open(fa,'r') as fr:
        for line in fr:
            if line.startswith('>'):
                n_reads+=1
                if seq:
                    score='I'*len(seq)
                    out.append(seq+'\n+\n'+score+'\n')
                    seq=''
                out.append('@'+line[1:])
            else:
                seq+=line.strip()
    #the last one
    score='I'*len(seq)
    out.append(seq+'\n+\n'+score+'\n')
    with open(fq,'w') as fw:
        fw.write(''.join(out))
    return n_reads


def fa2fq_low_memory(fa,fq):
    seq=''
    out=[]
    n_reads=0
    fw=open(fq,'w')
    with open(fa,'r') as fr:
        for line in fr:
            if line.startswith('>'):
                n_reads+=1
                if seq:
                    score='I'*len(seq)
                    out.append(seq+'\n+\n'+score+'\n')
                    seq=''
                    fw.write(''.join(out))
                    out=[]
                out.append('@'+line[1:])
            else:
                seq+=line.strip()
    #the last one
    score='I'*len(seq)
    out.append(seq+'\n+\n'+score+'\n')
    fw.write(''.join(out))
    fw.close()
    return n_reads


def fq2fa_low_memory(fq,fa):
    out=[]
    fw=open(fa,'w')
    with open(fq,'r') as fr:
        c=0
        for line in fr:
            c+=1
            if (c%4) == 1:
                out.append('>' + line[1:])
            elif (c%4) == 2:
                out.append(line)
                fw.write(''.join(out))
                out=[]
    return

def main():

    if len(sys.argv) < 4:
        print('ERROR: please check input parameters.')
        return 1

    infile,outfile,mode = sys.argv[1:4]
    low_memory = False
    if len(sys.argv) == 5:
        low_memory=sys.argv[4]

    if mode =='fq2fa':
        if low_memory:
            fq2fa_low_memory(infile,outfile) 
        else:
            fq2fa(infile,outfile)
    elif mode== 'fa2fq':
        if low_memory:
            fa2fq_low_memory(infile,outfile)
        else:
            fa2fq(infile,outfile)
    else:
        print('mode error')
        return 1


if __name__ == '__main__':
        sys.exit(main())
