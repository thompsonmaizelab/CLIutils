#!/bin/bash

# index the source file
bcftools index widiv_942g_757652SNPs_imputed_chr1-10_AGPv4_complete_noNA_noHet.vcf.gz

# get SNPs between 0.2 and 0.8 allele frequency
bcftools view \
    -Oz \
    -q0.2 \
    -Q0.8 \
    -o widiv_imputed_chr1-10_APGv4_noNA_noHet_q0.1_Q0.2.vcf.gz \
    widiv_942g_757652SNPs_imputed_chr1-10_AGPv4_complete_noNA_noHet.vcf.gz

# randomly sample 2000 SNPs
bcftools query \
    -f'%CHROM\t%POS\t%REF,%ALT\n' \
    widiv_imputed_chr1-10_APGv4_noNA_noHet_q0.1_Q0.2.vcf.gz | \
  shuf | \
  head \
    -n 2000 | \
  sort \
    -k1,1g \
    -k2,2g | \
  bgzip \
    -c > rnd_2000_snps.tsv.gz && \
  tabix \
    -s1 \
    -b2 \
    -e2 \
    rnd_2000_snps.tsv.gz

# select the 2000 SNPs and put into file
bcftools view \
    -Oz \
    -T rnd_2000_snps.tsv.gz \
    -o widiv_2000SNPs_imputed_chr1-10_APGv4_noNA_noHet_q0.2_Q0.8.vcf.gz \
    widiv_imputed_chr1-10_APGv4_noNA_noHet_q0.1_Q0.2.vcf.gz

