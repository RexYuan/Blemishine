
# usage: usage
function usage
{
    for fun_file in $BLEM/zsh/functions/*.zsh; do
        grep '^function' -B 1 $fun_file | grep -v '^function' | grep -v '\-\-' | sed 's/usage: //'
    done
}

# https://zsh.sourceforge.io/Doc/Release/Conditional-Expressions.html
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Set-By-The-Shell
# usage: mcd <dirname>
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
# usage: ls-path
function ls-path
{
    echo "${PATH//:/\n}"
}

# https://stackoverflow.com/a/30247099/2448540
# intent: behaves like Python's String's title method
# usage: title <string>
function title
{
    ret=()
    for word in $@; do
        hd=$(echo $word | cut -c 1 | tr "[:lower:]" "[:upper:]")
        tl=$(echo $word | cut -c 2- | tr "[:upper:]" "[:lower:]")
        ret+=("$hd$tl")
    done
    echo $ret
}

# flush dns
# usage: flush-dns
function flush-dns
{
    sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
    sudo killall -HUP mDNSResponder
}

# keep sudo session alive while running a command
# usage: with-sudo-keepalive <command> [args...]
function with-sudo-keepalive {
    sudo -v
    while true; do sudo -n true; sleep 60; done 2>/dev/null &
    local KEEP_SUDO_PID=$!
    trap "kill $KEEP_SUDO_PID" EXIT
    "$@"
}
