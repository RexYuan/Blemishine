
# https://zsh.sourceforge.io/Doc/Release/Conditional-Expressions.html
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Set-By-The-Shell
function mcd
{
    if [[ ! $# -eq 1 ]]; then
        echo "usage: mcd <dirname>"
        return 1
    fi
    if [[ -d $1 ]]; then
        echo "info: $1 exists; cd-ing $1"
        cd $1
        return 0
    fi
    if [[ -a $1 ]]; then
        echo "error: $1 exists and is not a directory"
        return 1
    fi
    echo "info: mkdir-ing $1; cd-ing $1"
    mkdir $1
    cd $1
}

# https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion:~:text=%24%7Bname//pattern/repl%7D
function ls-path
{
    echo "${PATH//:/\n}"
}
