#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function update_upgrade {
  sudo pacman -Syu --noconfirm
}

function install_packages {
  sudo pacman -S --noconfirm "$@"
}

function makedirs {
  for dir in "$@"; do
    mkdir -p "$dir"
  done
}

function link_dotfile {
  ln -sf "$SCRIPT_DIR/$1" "$HOME/.$1"
}

function link_dotfiles {
  for f in "$@"; do
    link_dotfile "$f"
  done
}

function link_xdg_config_file {
  [[ ! -e "$HOME/.config" ]] && mkdir "$HOME/.config"
  ln -sf "$SCRIPT_DIR/config/$1" "$HOME/.config/$1"
}

function link_xdg_config_files {
  for f in "$@"; do
    link_xdg_config_file "$f"
  done
}

function link_xdg_data_file {
  [[ ! -e "$HOME/.local/share" ]] && mkdir -p "$HOME/.local/share"
  ln -sf "$SCRIPT_DIR/local/share/$1" "$HOME/.local/share/$1"
}

function link_xdg_data_files {
  for f in "$@"; do
    link_xdg_data_file "$f"
  done
}

update_upgrade

# Window manager
install_packages \
  sway \
  swaybg \
  swayidle \
  swaylock \
  waybar \
  wofi \
  mako

# Fonts
install_packages \
  ttf-dejavu \
  ttf-liberation \
  ttf-nerd-fonts-symbols-2048-em \
  noto-fonts \
  noto-fonts-extra

install_packages \
  firefox \
  git \
  kitty \
  openssh \
  vim \
  zsh

link_xdg_config_files \
  kitty \
  sway \
  swaylock \
  waybar \
  wofi

link_xdg_data_files \
  fonts \
  icons \
  themes

link_dotfiles \
  gitconfig \
  oh-my-zsh \
  Xmodmap \
  zprofile \
  zshrc

