export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Plugin Manager

# Set the directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, it it's not there
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

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

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload -U compinit && compinit

# Initializations
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/dotfiles/starship/starship.toml

eval "$(fzf --zsh)"

# Completion Styling
zstyle ":completion:*" matcher-list 'm:{a-z}={A-za-z}'
eval "$(dircolors -b)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no 

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
