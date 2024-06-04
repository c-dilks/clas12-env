
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
    echo "WARNING:  This $home/setup.sh script is deprecated and will be removed by 2025."
    echo "WARNING:  This equivalent should be used instead:  'module use $home/modulefiles'"
    module use $home/modulefiles
fi
