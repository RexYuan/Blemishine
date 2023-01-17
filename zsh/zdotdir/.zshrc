
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
source "$BLEM/zsh/rc_libs.zsh"

source "$HOME/Projects/BlemiSiFive/zsh/include.zsh"
