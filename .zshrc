# =========================================
# PATH Setup
# =========================================
paths=(
  "$HOME/bin"
  "/usr/local/bin"
  "/usr/local/go/bin"
  "$HOME/go/bin"
)

for p in "${paths[@]}"; do
  [[ ":$PATH:" != *":$p:"* ]] && PATH="$PATH:$p"
done
export PATH

# =========================================
# Zinit Plugin Manager
# =========================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# =========================================
# Shell History
# =========================================
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory sharehistory \
        hist_ignore_space hist_ignore_all_dups \
        hist_save_no_dups hist_ignore_dups \
        hist_find_no_dups hist_expire_dups_first hist_verify

# =========================================
# Keybindings
# =========================================
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
bindkey '^L' autosuggest-accept

# =========================================
# Completion
# =========================================
autoload -U compinit && compinit
zstyle ":completion:*" matcher-list 'm:{a-z}={A-za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

eval "$(dircolors -b)"

# =========================================
# Aliases
# =========================================
alias rm='echo "Running rm -I instead for safety" && rm -I'
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -pv"
alias tmp="cd /tmp"
alias python=python3
alias ..="cd ../"
alias ...="cd ../../"
alias dots="cd ~/dotfiles && nvim ."
alias src="source ~/.zshrc"
alias la='ls -A'
alias ll='ls -A1l'
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias q=exit
alias cl=clear
alias ff=fastfetch
alias y=yazi
alias debug="PYTHONBREAKPOINT=web_pdb.set_trace"
alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"
alias gadd="git add"
alias gst="git status"
alias gcm="git commit -m"
alias gP="git push"
alias gp="git pull"
alias glog='git log --oneline --graph --decorate --all'
alias lg="lazygit"
alias ld="lazydocker"
alias decompress="tar -xzf"

# =========================================
# Functions
# =========================================

# Lazy-load fzf
fzf_lazy() {
  unset -f fzf_lazy
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  fzf "$@"
}

# Basic utilities
calc() { echo "$@" | bc -l; }
mkcd() { mkdir -p "$1" && cd "$1"; }
r() { rg --color=auto --smart-case "$@"; }
rp() { rg --color=auto --smart-case --glob "*.$2" "$1"; }
rf() { rg --color=always --smart-case "$@" | fzf_lazy --ansi --preview 'bat --style=numbers --color=always {}'; }
f() { fd -HI "$@"; }
fdonly() { fd -t d "$@"; }
fr() { fzf_lazy --ansi --preview 'bat --style=numbers --color=always {}'; }
topcpu() { ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -20; }
topmem() { ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%mem | head -20; }

# tmux session picker
sesh-sessions() {
  exec </dev/tty
  exec <&1
  local session=$(sesh list | fzf_lazy --height 40% --reverse --border-label ' open a tmux session ' --border --prompt '⚡  ')
  zle reset-prompt > /dev/null 2>&1 || true
  [[ -z "$session" ]] && return
  sesh connect $session
}
zle -N sesh-sessions
bindkey -M emacs '^F' sesh-sessions
bindkey -M vicmd '^F' sesh-sessions
bindkey -M viins '^F' sesh-sessions

# Smart cd
zd() {
  if [ $# -eq 0 ]; then
    builtin cd ~ && return
  elif [ -d "$1" ]; then
    builtin cd "$1"
  else
    z "$@" && printf " \U000F17A9 " && pwd || echo "Error: Directory not found"
  fi
}
alias cd="zd"

# Open silently
open() { xdg-open "$@" >/dev/null 2>&1 & }

# Compress/decompress
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
zipclean() {
  local zipname="$1"
  local folder="$2"
  [[ "$zipname" != *.zip ]] && zipname="${zipname}.zip"
  zip -r "$zipname" "$folder" \
    --exclude "*/.venv/*" "*/.git/*" "*/.mypy_cache/*" "*/__pycache__/*" "*.lock"
}
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Git helper
gswitch() {
  [[ -z "$1" ]] && echo "Usage: gswitch <branch-name>" && return 1
  if git show-ref --verify --quiet "refs/heads/$1"; then
    git switch "$1"
  else
    git switch -c "$1"
  fi
}

# =========================================
# Python Virtualenv Automation
# =========================================
autoload -U add-zsh-hook
auto_activate_virtualenv() {
  [[ -f ".venv/bin/activate" ]] && [[ -z "$VIRTUAL_ENV" ]] && source .venv/bin/activate
}
auto_deactivate_virtualenv() {
  [[ -n "$VIRTUAL_ENV" ]] && [[ ! -f ".venv/bin/activate" ]] && deactivate
}
add-zsh-hook chpwd auto_activate_virtualenv
add-zsh-hook chpwd auto_deactivate_virtualenv
auto_activate_virtualenv

# mkpyproj: make dir, uv init, venv, activate
mkproj() {
  [[ -z "$1" ]] && echo "Usage: mkpyproj <project_name>" && return 1
  mkdir -p "$1" && cd "$1" || return
  uv init
  uv venv
  source .venv/bin/activate
}

# =========================================
# Lazy-load Starship Prompt
# =========================================
starship_lazy() {
  unset -f starship_lazy
  eval "$(starship init zsh)"
}
add-zsh-hook precmd starship_lazy
export STARSHIP_CONFIG=~/dotfiles/.config/starship/starship.toml

# =========================================
# External Tools
# =========================================
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

# Custom environment
. "$HOME/.local/bin/env"
