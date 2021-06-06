
function mapargs
{
    for arg in ${@:2}
    do
        $1 $arg
    done
}

mapargs source $BLEM/zsh/functions/*
