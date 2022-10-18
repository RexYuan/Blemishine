
# read by interactive/non-interactive login/non-login shells
#

export SHELL_SESSIONS_DISABLE=1

# https://stackoverflow.com/q/65259300/2448540
arch="$(uname -m)"
if [[ "$arch" == 'arm64' ]]; then
    BREW_PREFIX="/opt/homebrew"
elif [[ "$arch" == 'x86_64' ]]; then
    BREW_PREFIX="/usr/local"
else
    exit 1
fi
