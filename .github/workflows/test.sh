#!/bin/bash
echo DOGGY
echo $1
ls -l
pwd
source /etc/profile.d/modules.sh
module use $1/modulefiles
module avail
module load clas12
module list
