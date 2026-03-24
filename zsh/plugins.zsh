_PLUGIN_DIR="${XDG_DATA_HOME}/zsh/plugins"

_load_plugin() {
  local repo="$1" file="$2"
  local dir="${_PLUGIN_DIR}/${repo##*/}"
  if [[ ! -d "$dir" ]]; then
    print -P "%F{yellow}[zsh] plugin missing:%f ${repo##*/}"
    print -P "%F{blue}      git clone https://github.com/${repo} ${dir}%f"
    return 1
  fi
  source "${dir}/${file}"
}

_load_plugin zsh-users/zsh-autosuggestions     zsh-autosuggestions.zsh
_load_plugin zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
