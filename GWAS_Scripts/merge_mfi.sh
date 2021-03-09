#!/bin/bash

for i in {1..22}; do
    awk -v chr=$i 'BEGIN {FS="\t"; OFS="\t"} {print chr,$0}' "ukb_mfi_chr${i}_v3.txt" >> ukb_mfi_v3.tsv
    echo done with $i
done

gzip ukb_mfi_v3.tsv
exit 0