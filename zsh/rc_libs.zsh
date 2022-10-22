
fpath+="$BLEM/zsh/lib/pure"

PURE_PROMPT_SYMBOL="🌸  ❯"
autoload -U promptinit; promptinit
prompt pure

# opam configuration
test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# z jump
source "$BREW_PREFIX/etc/profile.d/z.sh"

# must be sourced last
source "$BLEM/zsh/lib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
