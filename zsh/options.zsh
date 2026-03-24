
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt SHARE_HISTORY EXTENDED_HISTORY HIST_VERIFY

setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT

if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  source /opt/homebrew/opt/fzf/shell/completion.zsh
elif command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

export FZF_DEFAULT_OPTS='
  --height 40% --layout reverse --border rounded
  --bind "ctrl-/:toggle-preview"
'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --line-range :100 {} 2>/dev/null || cat {}"'
export FZF_ALT_C_OPTS='--preview "ls -lAh {}"'
