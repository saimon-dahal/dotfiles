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
setopt noflowcontrol no_beep correct

# Completion
setopt always_to_end complete_in_word
#
# Download Znap, if it's not there yet.
[[ -r ~/gitpkgs/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/gitpkgs/znap
source ~/gitpkgs/znap/znap.zsh
# =========================================
# PLUGIN MANAGER (ZNAP)
# =========================================
[[ ! -d "$XDG_DATA_HOME/zsh" ]]   && mkdir -p "$XDG_DATA_HOME/zsh"
[[ ! -d "$XDG_CACHE_HOME/zsh" ]]  && mkdir -p "$XDG_CACHE_HOME/zsh"
[[ ! -d "$XDG_STATE_HOME/less" ]] && mkdir -p "$XDG_STATE_HOME/less"

# =========================================
# PLUGINS
# =========================================
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source Aloxaf/fzf-tab
znap source zdharma-continuum/fast-syntax-highlighting

# Autosuggestion strategy: history first, then fall back to completions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# =========================================
# COMPLETION SYSTEM
# =========================================
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'

# FZF-tab
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:cd:*'    fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*:*'     fzf-preview 'bat --color=always --style=numbers $realpath 2>/dev/null || eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*:options' fzf-preview ''

# =========================================
# KEYBINDINGS
# =========================================
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^R' history-incremental-search-backward
bindkey '^E' autosuggest-accept   # Accept full suggestion
bindkey '^F' forward-word         # Accept one word of suggestion

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

# Eza (ls replacement)
alias ls='eza -lh --group-directories-first --icons=auto'
alias la='eza -lhA --group-directories-first --icons=auto'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias l='eza -1'

# Bat (cat replacement)
alias cat='bat --pager=never'

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

# Python / uv (mise handles the python version, uv handles the rest)
alias venv='uv venv'
alias pi='uv pip install'
alias pu='uv pip uninstall'
alias pf='uv pip freeze'

# Shell
alias q='exit'
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
# Calculator (uses Python for full math support)
calc() {
  if (( $# == 0 )); then
    python3 -q
  else
    python3 -c "from math import *; print($*)"
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
    *.tar.zst)        tar --zstd -xf "$1" ;;
    *.tar)            tar xf "$1" ;;
    *.bz2)            bunzip2 "$1" ;;
    *.gz)             gunzip "$1" ;;
    *.zip)            unzip "$1" ;;
    *.Z)              uncompress "$1" ;;
    *.7z)             7z x "$1" ;;
    *.rar)            unrar x "$1" ;;
    *.zst)            zstd -d "$1" ;;
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
# EXTERNAL TOOLS
# =========================================
# Mise (Python version manager) — must come before starship/fzf
command -v mise &>/dev/null && eval "$(mise activate zsh)"

# Cache init scripts to avoid subprocess overhead on every shell start
_cache_init() {
  local cmd="$1" cache="$XDG_CACHE_HOME/zsh/${1}_init.zsh"
  shift
  if command -v "$cmd" &>/dev/null; then
    if [[ ! -f "$cache" || "$commands[$cmd]" -nt "$cache" ]]; then
      "$cmd" "$@" >| "$cache"
    fi
    source "$cache"
  fi
}

_cache_init starship init zsh
_cache_init zoxide init zsh
_cache_init atuin  init zsh --disable-up-arrow
source <(fzf --zsh)  # fzf doesn't support output to file cleanly

unfunction _cache_init
