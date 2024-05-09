
# get the full path of the directory containing this file:
set ARGS=($_)
set LSOF=`env PATH=/usr/sbin:${PATH} which lsof`
set thisfile="`${LSOF} -w +p $$ | grep -oE '/.*setup.csh'  >& /dev/null`"
if ( "$thisfile" == "" ) then
   set thisfile=/does/not/exist
endif
if ( "$thisfile" != "" && -e ${thisfile} ) then
   set home="`dirname ${thisfile}`"
else if ("$1" != "") then
    # for scripted "source /path/to/this/script /path/to/this/script":
   if ( -d "$1" ) then
       set home="$1"
   else if ( -f "$1" ) then
       set home="`dirname $1`"
   endif
else if ("$ARGS" != "") then
   # for interactive, direct "source /path/to/this/script":
   set thisfile=`echo $ARGS | awk '{print$2}'`
   set home="`dirname ${thisfile}`"
else
   if ( -e setup.csh ) then
      set home=${PWD}
   else if ( "$1" != "" ) then
      if ( -e ${1}/setup.csh ) then
         set home=${1}
      endif
   else
   endif
endif

if ( ($?home) && (-d $home/modulefiles) ) then
    # system module initialization for non-login shells:
    if ( -e /etc/profile.d/modules.csh ) then
        source /etc/profile.d/modules.csh
    endif

    # add scicomp modulefiles:
    if ( -e /etc/redhat-release ) then
        if ( -e /cvmfs/oasis.opensciencegrid.org ) then
            grep -q -i -e Alma -e Plow /etc/redhat-release
            if ( $? == 0 ) then
                module use /cvmfs/oasis.opensciencegrid.org/jlab/scicomp/sw/el9/modulefiles
            endif
        endif
    endif

    # add clas12 modulefiles:
    module use $home/modulefiles
    module config extra_siteconfig $home/util/modulefiles.tcl
else
    echo 'ERROR: could not find $CLAS12_HOME.  Note, if you are sourcing this'
    echo 'from another tcsh script, you need to either pass the full path as'
    echo 'an additional argument or cd to the directory of setup.csh:'
    echo 'A. source /path/to/setup.csh /path/to/setup.csh'
    echo 'B. cd /path/to && source ./setup.csh'
endif


