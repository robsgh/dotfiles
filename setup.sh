#!/usr/bin/env bash

if [[ -L ~/.config/nvim ]]; then
  echo "nvim is already symlinked, skipping"
else
  echo "Linking nvim config dir"
  ln -s ~/dotfiles/nvim ~/.config/nvim
fi

if [[ -L ~/.config/ghostty ]]; then
  echo "ghostty is already symlinked, skipping"
else
  echo "Linking ghostty config dir"
  ln -s ~/dotfiles/ghostty ~/.config/ghostty
fi

if [[ -L ~/.zshrc ]]; then
  echo ".zshrc is already a symlink, skipping"
else
  if [[ -f ~/.zshrc ]]; then
    echo "Moving zshrc to a backup"
    mv ~/.zshrc ~/.zshrc.bak
  fi

  echo "Linking zshrc"
  ln -s ~/dotfiles/zshrc ~/.zshrc
  echo "    REMINDER: You should source the new .zshrc now"
fi
