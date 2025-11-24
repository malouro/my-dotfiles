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
for theme_path in "$HERE_PROFILE/themes/"*/; do
	theme_name="$(basename $theme_path)"

	if [ $theme_name == "powerlevel10k" ]; then
		echo "Found theme: $theme_path --> installing into '$OMZ/themes/$theme_name'"
		
		"$SL" "$theme_path" "$OMZ/themes/$theme_name"
	elif [ -f "$theme_path/$theme_name.zsh-theme" ]; then
		echo "Found theme: $theme_path/$theme_name.zsh-theme --> installing into '$OMZ/themes/$theme_name.zsh-theme'"
		"$SL" "$theme_path/$theme_name.zsh-theme" "$OMZ/themes/$theme_name.zsh-theme"
	fi
done