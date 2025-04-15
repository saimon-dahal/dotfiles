export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Keybindings
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory 
setopt hist_ignore_space 
setopt hist_ignore_all_dups 
setopt hist_save_no_dups 
setopt hist_ignore_dups
setopt hist_find_no_dups

# Initializations
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/dotfiles/starship/starship.toml

eval "$(atuin init zsh)"

# Completion Styling
zstyle ":completion:*" matcher-list 'm:{a-z}={A-za-z}'
eval "$(dircolors -b)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# aliases
alias ..="cd ../"
alias ...="cd ../../"

alias dotfiles="nvim ~/.config/dotfiles/"
alias dotrefresh="source ~/.zshrc"

alias ls='ls -h --color=auto --group-directories-first'
alias la='ls -A'
alias ll='ls -A1l'

alias q=exit
alias cl=clear
alias ff=fastfetch

# git aliases
alias gst="git status"
alias ga="git add"
alias gp="git push"
