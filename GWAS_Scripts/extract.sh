#!/bin/bash

for i in {1..22}; do
   awk {'printf ("%s\t%s\n", $2, $9)'} "assoc_chr${i}_v3.pheno.glm.linear" >> assoc_chr_all_betas.txt
    echo done with $i
done

