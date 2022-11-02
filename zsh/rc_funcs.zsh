
function mapargs
{
    if [[ $# -lt 2 ]]; then
        echo $#
        echo "usage: mapargs <function> <arg1>..."
        return 1
    fi
    for arg in ${@:2}
    do
        $1 $arg
    done
}

mapargs source $BLEM/zsh/functions/*
