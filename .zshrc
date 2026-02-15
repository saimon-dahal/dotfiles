# =========================================
# SHELL OPTIONS
# =========================================
# Directory navigation
setopt autocd extendedglob interactivecomments
setopt auto_pushd pushd_ignore_dups pushd_minus

# History
setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_all_dups
setopt hist_save_no_dups hist_find_no_dups
setopt hist_expire_dups_first hist_verify
setopt hist_reduce_blanks

# Interaction
setopt noflowcontrol
setopt no_beep
setopt correct

# Completion
setopt always_to_end
setopt complete_in_word

# =========================================
# PLUGIN MANAGER (ZINIT)
# =========================================
[[ ! -d "$XDG_DATA_HOME/zsh" ]] && mkdir -p "$XDG_DATA_HOME/zsh"
[[ ! -d "$XDG_CACHE_HOME/zsh" ]] && mkdir -p "$XDG_CACHE_HOME/zsh"
[[ ! -d "$XDG_STATE_HOME/less" ]] && mkdir -p "$XDG_STATE_HOME/less"

if [[ ! -d "$ZINIT_HOME" ]]; then
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# =========================================
# COMPLETION SYSTEM
# =========================================
autoload -Uz compinit

# Smart completion cache: only regenerate once per day
typeset -i updated_at=$(date +'%j' -r "$XDG_CACHE_HOME/zsh/zcompdump" 2>/dev/null || stat -f '%Sm' -t '%j' "$XDG_CACHE_HOME/zsh/zcompdump" 2>/dev/null)
if [[ $(date +'%j') != $updated_at ]]; then
  compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
else
  compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump"
fi

# Completion styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select  # Arrow key driven menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'

# FZF-tab
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# =========================================
# KEYBINDINGS
# =========================================
# History search
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^R' history-incremental-search-backward

# Autosuggestions
bindkey '^L' autosuggest-accept      # Accept full suggestion
bindkey '^F' forward-word           # Alt+F: Accept one word at a time


# =========================================
# HISTORY
# =========================================
HISTSIZE=50000
SAVEHIST=50000

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
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'

# Shell
alias q='exit'
alias cl='clear'
alias src='exec zsh'
alias y='yazi'
alias h='history'
alias j='jobs -l'

# Quick edits
alias zshrc='$EDITOR ~/.zshrc'
alias zshenv='$EDITOR ~/.zshenv'

# =========================================
# FUNCTIONS
# =========================================
# Calculator
calc() {
  if (( $# == 0 )); then
    bc -l
  else
    echo "$*" | bc -l
  fi
}

# Make directory and cd into it
mkcd() {
  if [[ -z "$1" ]]; then
    echo "Usage: mkcd <directory>" >&2
    return 1
  fi
  mkdir -p "$1" && cd "$1"
}

# Extract various archive types
extract() {
  if [[ -z "$1" ]]; then
    echo "Usage: extract <archive>" >&2
    return 1
  fi
  
  if [[ ! -f "$1" ]]; then
    echo "Error: '$1' is not a valid file" >&2
    return 1
  fi
  
  case "$1" in
    *.tar.bz2|*.tbz2) tar xjf "$1" ;;
    *.tar.gz|*.tgz)   tar xzf "$1" ;;
    *.tar.xz)         tar xJf "$1" ;;
    *.tar)            tar xf "$1" ;;
    *.bz2)            bunzip2 "$1" ;;
    *.gz)             gunzip "$1" ;;
    *.zip)            unzip "$1" ;;
    *.Z)              uncompress "$1" ;;
    *.7z)             7z x "$1" ;;
    *.rar)            unrar x "$1" ;;
    *) echo "Error: '$1' - unknown archive format" >&2; return 1 ;;
  esac
}

# Quick backup of a file
backup() {
  if [[ -z "$1" ]]; then
    echo "Usage: backup <file>" >&2
    return 1
  fi
  cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)"
}

# =========================================
# PYTHON VENV AUTO-ACTIVATE
# =========================================
autoload -Uz add-zsh-hook

auto_activate_venv() {
  local venv_path="$PWD/.venv"
  
  if [[ -f "$venv_path/bin/activate" ]]; then
    if [[ "$VIRTUAL_ENV" != "$venv_path" ]]; then
      source "$venv_path/bin/activate" 2>/dev/null
    fi
  fi
}

auto_deactivate_venv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_dir="${VIRTUAL_ENV:h}"
    case "$PWD/" in
      "$venv_dir/"*) ;;
      *) deactivate 2>/dev/null ;;
    esac
  fi
}

add-zsh-hook chpwd auto_activate_venv
add-zsh-hook chpwd auto_deactivate_venv
auto_activate_venv

# =========================================
# EXTERNAL TOOLS
# =========================================
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
command -v atuin &>/dev/null && eval "$(atuin init zsh)"
command -v starship &>/dev/null && eval "$(starship init zsh)"
command -v fzf &>/dev/null && source <(fzf --zsh)
