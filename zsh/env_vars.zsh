
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
    export PAGER="code"
    export GIT_PAGER="code --wait --reuse-window"
    export EDITOR="code"
    export GIT_EDITOR="code --wait --reuse-window"
    export VISUAL="code"
elif [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
    export PAGER="less"
    export GIT_PAGER="less"
    export EDITOR="nano"
    export GIT_EDITOR="nano"
    export VISUAL="nano"
else
    echo "⚠️  PAGER not set"
    echo "⚠️  GIT_PAGER not set"
    echo "⚠️  EDITOR not set"
    echo "⚠️  GIT_EDITOR not set"
    echo "⚠️  VISUAL not set"
fi

export BROWSER="open"
