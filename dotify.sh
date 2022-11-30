#!/usr/bin/env bash

for dirname in `ls .config`; do
    if [ ! -d "$HOME/.config/$dirname" ]; then
        echo "Creating config dir \"$HOME/.config/$dirname\"..."
        mkdir -p "$HOME/.config/$dirname"
    fi
    echo "Copying \".config/$dirname/*\" to \"$HOME/.config/$dirname/\""
    cp -r .config/$dirname/* "$HOME/.config/$dirname/"
done

if [ -d "$HOME/.local/nvim" ]; then
    echo "Bootstrapping packer in neovim..."
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    if [ 0 -eq $? ]; then
	echo "Packer bootstrapped successfully."
    fi
fi
