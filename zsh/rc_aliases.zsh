
alias python=python3
alias pip=pip3

# https://superuser.com/q/183876/372113
alias ls='ls --color=auto'

# https://stackoverflow.com/q/2327191/2448540
alias grep='grep --color=auto'

if command -v bat &> /dev/null; then
	# https://stackoverflow.com/q/7851134/2448540
    alias cat='bat --theme Tomorrow-Night --paging=never --plain'

    # https://superuser.com/q/117841/372113
    alias less='bat --theme Tomorrow-Night --paging=always'

    alias fd='fd --hidden --no-ignore --follow --color=auto'
    alias ag='ag --pager "bat --theme Tomorrow-Night --paging=always" --unrestricted'
    alias h='history 0 | bat'
fi
