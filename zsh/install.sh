#!/bin/sh

# .oh-my-zsh directory location
OMZ="$OUT/.oh-my-zsh"

# If in Arch Linux, use the profile
if [[ -f "/etc/arch-release" ]]; then
	"$SL" "$HERE_PROFILE/zshrc.arch" "$OUT/.zshrc"
else
	"$SL" "$HERE_PROFILE/zshrc" "$OUT/.zshrc"
fi

"$SL" "$HERE_PROFILE/zsh-autosuggestions" "$OMZ/custom/plugins/zsh-autosuggestions"
"$SL" "$HERE_PROFILE/zsh-completions" "$OMZ/custom/plugins/zsh-completions"
"$SL" "$HERE_PROFILE/zsh-npm-scripts-autocomplete" "$OMZ/custom/plugins/zsh-npm-scripts-autocomplete"
"$SL" "$HERE_PROFILE/zsh-syntax-highlighting" "$OMZ/custom/plugins/zsh-syntax-highlighting"

# .oh-my-zsh themes
for theme in "$HERE_PROFILE/themes/"*/; do
	theme_name="$(basename $theme)"
	theme_path="$theme$theme_name.zsh-theme"

	if [ -f "$theme_path" ]; then
		"$SL" "$theme_path" "$OMZ/themes/$theme_name.zsh-theme"
	fi
done