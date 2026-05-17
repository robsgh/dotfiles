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

function link_bin_scripts() {
  mkdir -p ~/.local/bin

  for script in ./bin/*; do
    [[ -f "$script" ]] || continue
    link_maybe_backup "bin/$(basename "$script")" ~/.local/bin/"$(basename "$script")"
  done
}

function setup_walker_elephant() {
  mkdir -p ~/.config/autostart ~/.config/systemd/user/app-walker@autostart.service.d

  link_maybe_backup walker-autostart/walker.desktop ~/.config/autostart/walker.desktop
  link_maybe_backup walker-systemd/restart.conf ~/.config/systemd/user/app-walker@autostart.service.d/restart.conf

  if command -v elephant >/dev/null 2>&1; then
    elephant service enable
    systemctl --user start elephant.service
  fi
}

link_maybe_backup nvim ~/.config/nvim
link_maybe_backup ghostty ~/.config/ghostty
link_maybe_backup bashrc ~/.bashrc
link_maybe_backup tmux ~/.config/tmux
link_maybe_backup hypr ~/.config/hypr
link_maybe_backup elephant ~/.config/elephant
link_maybe_backup fastfetch ~/.config/fastfetch
link_maybe_backup hyprland-preview-share-picker ~/.config/hyprland-preview-share-picker
link_maybe_backup kitty ~/.config/kitty
link_maybe_backup mako ~/.config/mako
link_maybe_backup swayosd ~/.config/swayosd
link_maybe_backup uwsm ~/.config/uwsm
link_maybe_backup walker ~/.config/walker
link_maybe_backup waybar ~/.config/waybar
link_maybe_backup xournalpp ~/.config/xournalpp
link_bin_scripts
setup_walker_elephant
