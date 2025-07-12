
# Set PATH, MANPATH, etc., for Homebrew.
eval "$($BREW_PREFIX/bin/brew shellenv)"

# ruby
export PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"

# sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# ocaml, frama-c
eval $(opam env)

# curl
export PATH="/usr/local/opt/curl/bin:$PATH"

# pipx
export PATH="$PATH:/Users/rexyuan/.local/bin"

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
