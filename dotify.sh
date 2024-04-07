#!/usr/bin/env bash

PACKAGES=(
	neovim
	hyprland-git
	hyprpaper
	waybar-git
	hyprlock
	hypridle
)

DOTS_DIR="$(realpath -s $(dirname -- "$0"))"

if [[ ! -e "$HOME/.oh-my-zsh" ]]; then
	echo "Installing oh-my-zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Copying .zshrc..."
cp -sf "$DOTS_DIR/.zshrc" "$HOME/.zshrc"

echo "Copying .tmux.conf..."
cp -sf "$DOTS_DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "Installing required packages..."
for package in "${PACKAGES[@]}"; do
	if ! dnf list --installed "$package" >/dev/null; then
		echo "Installing $package..."
		sudo dnf install -y $package
	else
		echo "$package is installed!"
	fi
done

if ! fc-list -q :family="SauceCodePro Nerd Font"; then
	echo "Installing SauceCodePro Nerd Font..."
	curl -fLo "SauceCodePro Nerd Font Complete.ttf" \
		"https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/SourceCodePro.tar.xf" &&
		mv "*.ttf" "$HOME/.local/share/fonts/" &&
		echo "SauceCodePro Nerd Font installed successfully!"
else
	echo "SauceCodePro Nerd Font is already installed... skipping download"
fi

for dirname in $(ls .config); do
	if [[ ! -e "$HOME/.config/$dirname" ]] || [[ ! -d "$HOME/.config/$dirname" ]]; then
		echo "Creating config dir \"$HOME/.config/$dirname\"..."
		mkdir -p "$HOME/.config/$dirname"
	fi

	echo "Copying \".config/$dirname/*\" to \"$HOME/.config/$dirname/\""
	cp -rsf "$DOTS_DIR/.config/$dirname/." "$HOME/.config/$dirname/"
done

if [[ ! -e "$HOME/.tmux/plugins/tpm" ]]; then
	echo "Installing TPM for tmux plugins..."
	git clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"
fi
