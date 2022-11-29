#!/usr/bin/env bash

for dirname in `ls .config`; do
    if [ ! -d "$HOME/.config/$dirname" ]; then
        echo "Creating config dir \"$HOME/.config/$dirname\"..."
        mkdir -p "$HOME/.config/$dirname"
    fi
    echo "Copying \".config/$dirname/*\" to \"$HOME/.config/$dirname/\""
    cp .config/$dirname/* "$HOME/.config/$dirname/"
done
