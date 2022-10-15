
fpath+="$BLEM/zsh/lib/pure"

PURE_PROMPT_SYMBOL="🌸  ❯"
autoload -U promptinit; promptinit
prompt pure

# z jump
source /usr/local/etc/profile.d/z.sh

# must be sourced last
source "$BLEM/zsh/lib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"