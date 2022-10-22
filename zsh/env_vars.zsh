
# https://superuser.com/q/1610587/372113
export SHELL_SESSIONS_DISABLE=1

# https://stackoverflow.com/q/65259300/2448540
arch="$(uname -m)"
if [[ "$arch" == 'arm64' ]]; then
    export BREW_PREFIX="/opt/homebrew"
elif [[ "$arch" == 'x86_64' ]]; then
    export BREW_PREFIX="/usr/local"
else
    exit 1
fi

# https://askubuntu.com/q/1021554/444384
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    export EDITOR="code --wait --new-window"
    export GIT_EDITOR="code --wait --new-window"
elif [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
    export EDITOR="nano"
    export GIT_EDITOR="nano"
else
    exit 1
fi

