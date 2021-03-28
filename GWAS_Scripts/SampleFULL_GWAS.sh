#!/bin/bash

for i in {1..22}; do
   ./plink2 --bgen ~/project-ukbiobank/data/geno/imp/bgen/ukb_imp_chr${i}_v3.bgen \
	--sample ~/project-ukbiobank/data/geno/imp/bgen/impv3.sample \
	--keep ~/project-zaitlenlab/dataFolder/info_maf_qc_ukb_mfi_chr${i}_v3.txt \
	--geno 0.05 \
	--hwe 1e-10 \
	--glm \
	--pheno ~/project-ukbiobank/33127/ukb21970_plink/filter4_pheno_files/height.pheno \
	--covar ~/project-ukbiobank/33127/ukb21970_plink/filter4_pheno_files/height.covar \
	--covar-name sex,f.22009.0.1,f.22009.0.2,f.22009.0.3,f.22009.0.4,f.22009.0.5,f.22009.0.6,f.22009.0.7,f.22009.0.8,f.22009.0.9,f.22009.0.10 \
	--out /u/scratch/t/taykhoom/assoc_chr${i}_v3
done

echo done