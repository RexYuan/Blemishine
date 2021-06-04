
HISTFILE_DIR="$HOME/.cache/zsh"
[[ -d $HISTFILE_DIR ]] || mkdir -p $HISTFILE_DIR

HISTFILE="$HISTFILE_DIR/.zsh_history"
HISTSIZE=3000
SAVEHIST=3000

setopt INC_APPEND_HISTORY # immediate append
setopt EXTENDED_HISTORY # timestamp
setopt HIST_IGNORE_DUPS # ignore consecutive dups
setopt HIST_FIND_NO_DUPS # don't show dups in search
