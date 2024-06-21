
# get the full path of the directory containing this file:
set ARGS=($_)
set LSOF=`env PATH=/usr/sbin:${PATH} which lsof`
set thisfile="`${LSOF} -w +p $$ | grep -oE '/.*setup.csh'  >& /dev/null`"
if ( "$thisfile" == "" ) then
   set thisfile=/does/not/exist
endif
if ( "$thisfile" != "" && -e ${thisfile} ) then
   set clas12_home="`dirname ${thisfile}`"
else if ("$1" != "") then
    # for scripted "source /path/to/this/script /path/to/this/script":
   if ( -d "$1" ) then
       set clas12_home="$1"
   else if ( -f "$1" ) then
       set clas12_home="`dirname $1`"
   endif
else if ("$ARGS" != "") then
   # for interactive, direct "source /path/to/this/script":
   set thisfile=`echo $ARGS | awk '{print$2}'`
   set clas12_home="`dirname ${thisfile}`"
else
   if ( -e setup.csh ) then
      set clas12_home=${PWD}
   else if ( "$1" != "" ) then
      if ( -e ${1}/setup.csh ) then
         set clas12_home=${1}
      endif
   else
   endif
endif

if ( ($?clas12_home) && (-d $clas12_home/modulefiles) ) then
    module use $clas12_home/modulefiles
    set h=`hostname | awk -F. '{print$1}'`
    grep -q -i -e alma -e plow /etc/redhat-release
    if ( $status ) then
        echo '################################################################################'
        echo '#  WARNING    WARNING    WARNING    WARNING    WARNING    WARNING    WARNING   #'
        echo '#                                                                              #'
        echo "#     \!\!\!\!\! You are on an old el7 machine named $h \!\!\!\!\!                #"
        echo '#                                                                              #'
        echo "# JLab is in the process of retiring el7 (RHEL7/centos7) machines at JLab.     #"
        echo "# CLAS12 software builds for el7 stopped being updated in March 2024.          #"
        echo '#                                                                              #'
        echo "# Your options include:                                                        #"
        echo "# 1. Login to an el9 machine                                                   #"
        echo '# 2. Use the old el7 builds via "source /group/clas12/packages/setup.[c]sh"    #'
        echo '# 3. Do nothing.  Some things will still work, e.g., "module load coatjava"    #'
        echo '#                                                                              #'
        echo '################################################################################'
        echo
    else     
        echo '################################################################################'
        echo '#  WARNING    WARNING    WARNING    WARNING    WARNING    WARNING    WARNING   #'
        echo '#                                                                              #'
        echo '#     The CLAS12 environment setup.*sh scripts are deprecated and will be      #'
        echo '#      removed in the future.  Switch to this equivalent at JLab instead:      #'
        echo '#                                                                              #'
        echo '#           module use /scigroup/cvmfs/hallb/clas12/sw/modulefiles             #'
        echo '#                                                                              #'
        echo '#                           Or, via CVMFS:                                     #'
        echo '#                                                                              #'
        echo '# module use /cvmfs/oasis.opensciencegrid.org/jlab/hallb/clas12/sw/modulefiles #'
        echo '#                                                                              #'
        echo '################################################################################'
    endif
else
    echo 'ERROR: could not find $CLAS12_HOME.  Note, if you are sourcing this'
    echo 'from another tcsh script, you need to either pass the full path as'
    echo 'an additional argument or cd to the directory of setup.csh:'
    echo 'A. source /path/to/setup.csh /path/to/setup.csh'
    echo 'B. cd /path/to && source ./setup.csh'
endif



