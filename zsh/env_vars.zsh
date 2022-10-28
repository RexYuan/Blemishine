
# https://superuser.com/q/1610587/372113
export SHELL_SESSIONS_DISABLE=1

# https://stackoverflow.com/q/65259300/2448540
arch="$(uname -m)"
if [[ "$arch" == 'arm64' ]]; then
    export BREW_PREFIX="/opt/homebrew"
elif [[ "$arch" == 'x86_64' ]]; then
    export BREW_PREFIX="/usr/local"
else
    echo "⚠️  BREW_PREFIX not set"
fi

# https://askubuntu.com/q/1021554/444384
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    export EDITOR="code --wait"
    export VISUAL="code --wait"
elif [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
    export EDITOR="nano"
    export VISUAL="nano"
else
    echo "⚠️  EDITOR not set"
    echo "⚠️  VISUAL not set"
fi

export PAGER="less"
export BROWSER="open"
