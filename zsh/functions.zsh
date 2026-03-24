
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
