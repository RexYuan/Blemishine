
# Set PATH, MANPATH, etc., for Homebrew.
eval "$($BREW_PREFIX/bin/brew shellenv)"

# rustup
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
else
    echo "🟠 Rust not set up. Run \"rustup-init\""
fi

# ruby
export PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"

# coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# python c extension
export C_INCLUDE_PATH="/usr/local/Cellar/python@3.11/3.11.3/Frameworks/Python.framework/Versions/3.11/include/python3.11/:$C_INCLUDE_PATH"

# nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ocaml, frama-c
eval $(opam env)

# flex, bison
export PATH="/usr/local/opt/flex/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"

# curl
export PATH="/usr/local/opt/curl/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# java
export JAVA_HOME="/usr/local/opt/openjdk@11"

# >>> coursier install directory >>>
export PATH="$PATH:/Users/rexyuan/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
