#!/bin/sh

"$SL" "$HERE_PROJECT/zshrc" "$OUT/.zshrc"
"$SL" "$HERE_PROJECT/zsh-autosuggestions" "${ZSH_CUSTOM:-"$OUT/.oh-my-zsh/custom"}/plugins/zsh-autosuggestions"
"$SL" "$HERE_PROJECT/zsh-syntax-highlighting" "${ZSH_CUSTOM:-"$OUT/.oh-my-zsh/custom"}/plugins/zsh-syntax-hightlighting"
