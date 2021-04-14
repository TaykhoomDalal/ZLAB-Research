#!/bin/bash

for i in {1..22}; do
    sed '1d' assoc_chr${i}_v3.pheno.glm.linear > tmpfile; mv tmpfile assoc_chr${i}_v3.pheno.glm.linear
    awk {'printf ("%s\t%s\t%s\t%s\n", $1, $2, $9, $12)'} "assoc_chr${i}_v3.pheno.glm.linear" >> assoc_chr_all_betas.txt
    echo done with $i
done