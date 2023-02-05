#!/usr/bin/env bash

PACKAGES=(
    i3
    neovim
    polybar
    alacritty
    picom
    rofi
    xset
    xinput
    xss-lock
    feh
    i3lock
)

if [[ ! -e "$HOME/.oh-my-zsh" ]]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Copying .zshrc..."
cp -sf "$HOME/dots/.zshrc" "$HOME/.zshrc"

echo "Installing required packages..."
for package in "${PACKAGES[@]}"; do
    if ! dnf list --installed "$package" > /dev/null; then
        echo "Installing $package..."
        sudo dnf install -y $package
    else
        echo "$package is installed!"
    fi
done

if ! fc-list -q :family="SauceCodePro Nerd Font"; then
    echo "Installing SauceCodePro Nerd Font..."
    curl -fLo "SauceCodePro Nerd Font Complete.ttf"\
            "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf"\
            1&> /dev/null \
        && mv "SauceCodePro Nerd Font Complete.ttf" "$HOME/.local/share/fonts/" \
        && echo "SauceCodePro Nerd Font installed successfully!"
else
    echo "SauceCodePro Nerd Font is already installed... skipping download"
fi

for dirname in `ls .config`; do
    if [[ ! -e "$HOME/.config/$dirname" ]] || [[ ! -d "$HOME/.config/$dirname" ]]; then
        echo "Creating config dir \"$HOME/.config/$dirname\"..."
        mkdir -p "$HOME/.config/$dirname"
    fi

    echo "Copying \".config/$dirname/*\" to \"$HOME/.config/$dirname/\""
    cp -rsf "$HOME/dots/.config/$dirname/." "$HOME/.config/$dirname/"
done

echo "Bootstrapping packer in neovim..."
if nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync" 2&> /dev/null; then
    echo "Packer bootstrapped successfully."
else
    echo "An error ocurred during Packer bootstrap."
fi

