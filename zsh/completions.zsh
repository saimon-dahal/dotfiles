ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/compdump"
[[ ! -d "${XDG_CACHE_HOME}/zsh" ]] && mkdir -p "${XDG_CACHE_HOME}/zsh"

autoload -Uz compinit
# only rebuild compdump once per day
if [[ -n "${ZSH_COMPDUMP}"(#qN.mh+24) ]]; then
  compinit -d "$ZSH_COMPDUMP"
else
  compinit -C -d "$ZSH_COMPDUMP"
fi

setopt MENU_COMPLETE AUTO_LIST COMPLETE_IN_WORD ALWAYS_TO_END
export LS_COLORS="di=1;34:ln=36:so=35:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=1;34"

zstyle ':completion:*'              matcher-list 'm:{a-z}={A-Z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*'              menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings'     format '%F{red}no matches%f'
