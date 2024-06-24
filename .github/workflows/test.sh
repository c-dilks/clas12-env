#!/bin/bash
source /etc/profile.d/modules.sh
module --version
module use $1
module avail
module load clas12
module list
