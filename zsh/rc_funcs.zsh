
function mapargs
{
    for arg in ${@:2}
    do
        $1 $arg
    done
}

source "$BLEM/zsh/youtube-dl.zsh"
