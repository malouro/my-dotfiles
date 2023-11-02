#!/bin/sh

# .oh-my-zsh directory location
OMZ="$OUT/.oh-my-zsh"

"$SL" "$HERE_PROFILE/zshrc" "$OUT/.zshrc"
"$SL" "$HERE_PROFILE/zsh-autosuggestions" "$OMZ/custom/plugins/zsh-autosuggestions"
"$SL" "$HERE_PROFILE/zsh-completions" "$OMZ/custom/plugins/zsh-completions"
"$SL" "$HERE_PROFILE/zsh-syntax-highlighting" "$OMZ/custom/plugins/zsh-syntax-highlighting"
