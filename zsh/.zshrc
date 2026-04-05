local files=(
  "$ZDOTDIR/options.zsh"
  "$ZDOTDIR/completions.zsh"
  "$ZDOTDIR/keybindings.zsh"
  "$ZDOTDIR/plugins.zsh"
  "$ZDOTDIR/aliases.zsh"
  "$ZDOTDIR/functions.zsh"
  "$ZDOTDIR/tools.zsh"
)

for f in $files; do
  [[ -f $f ]] && source $f
done
