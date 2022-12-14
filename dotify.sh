#!/usr/bin/env bash

cp ./.zshrc $HOME/.zshrc
echo "Copied .zshrc"

for dirname in `ls .config`; do
    if [ ! -d "$HOME/.config/$dirname" ]; then
        echo "Creating config dir \"$HOME/.config/$dirname\"..."
        mkdir -p "$HOME/.config/$dirname"
    fi
    echo "Copying \".config/$dirname/*\" to \"$HOME/.config/$dirname/\""
    cp -r .config/$dirname/* "$HOME/.config/$dirname/"
done

echo "Bootstrapping packer in neovim..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' &2>/dev/null

if [ 0 -eq $? ]; then
    echo "Packer bootstrapped successfully."
else
    echo "An error ocurred during Packer bootstrap."
fi
