
# get the full path of the directory containing this file:
src=${BASH_ARGV[0]}
if [ "x$src" = "x" ]; then
    src=${(%):-%N} # for zsh
fi
if [ "x${src}" = "x" ]; then
    [ -f ./setup.sh ] && home="$PWD" || echo ERROR: could not determine installation path!
else
    x=$(dirname ${src}) && home=$(cd ${x} > /dev/null; pwd)
fi

if [ -z ${home+x} ] && [ -d $home/modulefiles ]; then
    echo 'ERROR:  could not find $CLAS12_HOME.'
else
    module use $home/modulefiles
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
fi

