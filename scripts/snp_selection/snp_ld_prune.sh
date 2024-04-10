#!/usr/bin/env bash

# Usage: snpprune.sh

# export plugin directory so bcftools can find our plugins
export BCFTOOLS_PLUGINS=/usr/libexec/bcftools/

# first filter by taxa
# second filter by MAF < 0.05
# third do LD prune
bcftools view -Ou -S tarspot_taxa.txt ../unfiltered/widiv_942g_757652SNPs_imputed_chr1-10_AGPv4_complete_noNA_noHet.vcf.gz | \
  bcftools view -Ou -e'MAF<0.05' | \
  bcftools +prune -Oz -o tarspot_2019_geno_maf0.05_ld0.8_50kb.vcf.gz --max-LD 0.8 --window 50000bp

