
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
    if grep -v -q -i -e alma -e plow /etc/redhat-release; then
        echo '################################################################################'
        echo '#  WARNING    WARNING    WARNING    WARNING    WARNING    WARNING    WARNING   #'
        echo '#                                                                              #'
        echo "#     !!!!! You are on an old el7 machine named $(echo $(hostname)|awk -F. '{print$1}') !!!!!                #"
        echo '#                                                                              #'
        echo "# JLab is in the process of retiring el7 (RHEL7/centos7) machines at JLab.     #"
        echo "# CLAS12 software builds for el7 stopped being updated in March 2024.          #"
        echo '#                                                                              #'
        echo "# Your options include:                                                        #"
        echo "# 1. Login to an el9 machine                                                   #"
        echo "# 2. Use the old el7 builds via \"source /group/clas12/packages/setup.[c]sh\"    #"
        echo "# 3. Do nothing.  Some things will still work, e.g., \"module load coatjava\"    #"
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
    fi
fi
