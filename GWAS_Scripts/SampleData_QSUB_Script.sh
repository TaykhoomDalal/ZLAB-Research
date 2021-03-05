#### SampleData_QSUB_Script.sh START ####
#!/bin/bash
#$ -cwd
# error = Merged with joblog
#$ -o qc_UKBB_Sample_error_log.$JOB_ID
#$ -j y
## Edit the line below as needed:
#$ -l h_rt=24:00:00,h_data=64G
## Modify the parallel environment
## and the number of cores as needed:
#$ -pe shared 1
# Email address to notify
#$ -M $USER@mail
# Notify when
#$ -m bea

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
plink --sample impv3.sample --hwe 1e-10 --maf 0.001 --out ~/project-zaitlenlab/qc_UKBB_samples/qc_UKBB_samples

# echo job info on joblog:
echo "Job $JOB_ID ended on:   " `hostname -s`
echo "Job $JOB_ID ended on:   " `date `
echo " "
#### SampleData_QSUB_Script.sh STOP ####