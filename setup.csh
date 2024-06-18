
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
    echo '################################################################################'
    echo '#  WARNING    WARNING    WARNING    WARNING    WARNING    WARNING    WARNING   #'
    echo '#                                                                              #'
    echo '#     The CLAS12 environment setup.*sh scripts are deprecated and will be      #'
    echo '#        removed in the future.  Switch to this equivalent instead:            #'
    echo '#                                                                              #'
    echo '# module use /cvmfs/oasis.opensciencegrid.org/jlab/hallb/clas12/sw/modulefiles #'
    echo '#                                                                              #'
    echo '#   Or, at JLab only, we can instead use the local filesystem without CVMFS:   #'
    echo '#                                                                              #'
    echo '#           module use /scigroup/cvmfs/hallb/clas12/sw/modulefiles             #'
    echo '################################################################################'
else
    echo 'ERROR: could not find $CLAS12_HOME.  Note, if you are sourcing this'
    echo 'from another tcsh script, you need to either pass the full path as'
    echo 'an additional argument or cd to the directory of setup.csh:'
    echo 'A. source /path/to/setup.csh /path/to/setup.csh'
    echo 'B. cd /path/to && source ./setup.csh'
endif



