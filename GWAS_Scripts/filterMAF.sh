#!/bin/bash

for i in {1..22}; do
    awk -v chr=$i '{if($6 > 0.001 && $8 > 0.8) {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $8}}' "ukb_mfi_chr${i}_v3.txt" >> info_maf_qc_ukb_mfi_chr${i}_v3.txt
    echo done with $i
done

echo done