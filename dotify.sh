#!/usr/bin/env bash

for dirname in `ls .config`; do
    if ! [[ -f $HOME/.config/$dirname ]]; then
        echo "Creating config dir \"$HOME/.config/$dirname\"..."
        mkdir -p $HOME/.config/$dirname
    fi
    echo "Copying \".config/$dirname/*\" to \"$HOME/.config/$dirname/\""
    cp -i .config/$dirname/* "$HOME/.config/$dirname/"
done
