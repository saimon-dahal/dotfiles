

# =========================================
# ALIASES
# =========================================
# Navigation
alias c='z'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

# Directory operations
alias mkdir='mkdir -pv'
alias md='mkdir -pv'

# Python
alias python='python3'
alias pip='pip3'

# Eza
alias ls='eza -lh --group-directories-first --icons=auto'
alias ll='ls'
alias la='ls -A'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias l='eza -1'

# Git
alias lg='lazygit'
alias g='git'
alias gst='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'

# Shell
alias q='exit'
alias cl='clear'
alias y='yazi'
alias h='history'
alias j='jobs -l'

# Quick edits
alias zshrc='$EDITOR ~/.zshrc'
alias zshenv='$EDITOR ~/.zshenv'
alias dots='$EDITOR $HOME/personal/dotfiles'

# source
alias src='source $ZDOTDIR/.zshrc'

