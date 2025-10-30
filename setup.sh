#!/usr/bin/env bash
set -e

function link_maybe_backup() {
  local config="$(realpath ./$1)"
  local filename="$2"

  if [[ -L "$filename" ]]; then
    echo "$filename is already symlinked, skipping"
    return
  fi

  if [[ -e "$filename" ]]; then
    echo "$filename already exists, but is not symlinked. Moving to $filename.bak"
    mv "$filename" "$filename.bak"
  fi

  ln -sv "$config" "$filename"
}

link_maybe_backup nvim ~/.config/nvim
link_maybe_backup ghostty ~/.config/ghostty
link_maybe_backup zshrc ~/.zshrc
link_maybe_backup tmux.conf ~/.tmux.conf
link_maybe_backup i3 ~/.config/i3
link_maybe_backup hypr ~/.config/hypr
link_maybe_backup waybar ~/.config/waybar

if grep "Arch Linux" /etc/os-release>/dev/null; then
  echo "Installing arch packages"
  mapfile -t PKGS < ./packages.x86_64.pacman
  sudo pacman -Syu --needed "${PKGS[@]}"
fi
