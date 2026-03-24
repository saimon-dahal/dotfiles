
command -v atuin &>/dev/null && eval "$(atuin init zsh --disable-up-arrow)"
command -v starship &>/dev/null && eval "$(starship init zsh)"
command -v fzf &>/dev/null && source <(fzf --zsh)
