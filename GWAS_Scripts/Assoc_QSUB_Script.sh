#### Assoc_QSUB_Script.sh START ####
#!/bin/bash
#$ -cwd
# error = Merged with joblog
#$ -o assoc_samples_error_log.$JOB_ID.$TASK_ID
#$ -j y
## Edit the line below as needed:
#$ -l h_rt=12:00:00,h_data=8G
## Modify the parallel environment
## and the number of cores as needed:
#$ -pe shared 11
# Email address to notify
#$ -M $USER@mail
# Notify when
#$ -m bea
#$ -t 11:1

# echo job info on joblog:
echo "Job $JOB_ID started on:   " `hostname -s`
echo "Job $JOB_ID started on:   " `date `
echo " "

# load the job environment:
. /u/local/Modules/default/init/modules.sh
## Edit the line below as needed:
module load plink

## substitute the command to run your code
## in the two lines below:
echo '/usr/bin/time -v hostname'

./plink2 --bgen ~/project-ukbiobank/data/geno/imp/bgen/ukb_imp_chr"$SGE_TASK_ID"_v3.bgen \
--sample ~/project-ukbiobank/data/geno/imp/bgen/impv3.sample \
--threads 11 \
--memory 88000 \
--extract ~/project-zaitlenlab/dataFolder/info_maf_qc_ukb_mfi_chr"$SGE_TASK_ID"_v3.txt \
--geno 0.05 \
--hwe 1e-10 \
--maf 0.001 \
--glm \
--pheno ~/project-ukbiobank/33127/ukb21970_plink/filter4_pheno_files/height.pheno \
--covar ~/project-ukbiobank/33127/ukb21970_plink/filter4_pheno_files/height.covar \
--covar-name sex,f.22009.0.1,f.22009.0.2,f.22009.0.3,f.22009.0.4,f.22009.0.5,f.22009.0.6,f.22009.0.7,f.22009.0.8,f.22009.0.9,f.22009.0.10 \
--parameters 1 \
--out /u/scratch/t/taykhoom/assoc_chr"$SGE_TASK_ID"_v3

# echo job info on joblog:
echo "Job $JOB_ID ended on:   " `hostname -s`
echo "Job $JOB_ID ended on:   " `date `
echo " "
#### Assoc_QSUB_Script.sh STOP ####