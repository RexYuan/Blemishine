
# Set PATH, MANPATH, etc., for Homebrew.
eval "$($BREW_PREFIX/bin/brew shellenv)"

# ocaml, frama-c
eval $(opam env)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"

# sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# curl
export PATH="/usr/local/opt/curl/bin:$PATH"

# pipx
export PATH="/Users/rexyuan/.local/bin:$PATH"
