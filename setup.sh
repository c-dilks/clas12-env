
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
    # system module initialization for non-login shells:
    if [ -e /etc/profile.d/modules.sh ]; then
        source /etc/profile.d/modules.sh
    fi

    # add clas12 modulefiles:
    module use $home/modulefiles
    module config extra_siteconfig $home/util/modulefiles.tcl
fi
