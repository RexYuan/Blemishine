
# read by interactive login/non-login shells
#
# interactive login shells read in order
#   1. zprofile
#   2. zshrc
#   3. zlogin

source "$BLEM/zsh/rc_paths.zsh"
source "$BLEM/zsh/rc_aliases.zsh"
source "$BLEM/zsh/rc_funcs.zsh"
source "$BLEM/zsh/rc_history.zsh"

# opam configuration
test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

source "$BLEM/zsh/rc_libs.zsh"
