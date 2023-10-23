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

update_upgrade

# Window manager
install_packages \
  archlinux-wallpaper \
  mako \
  sway \
  swaybg \
  swayidle \
  swaylock \
  waybar \
  wofi \
  xorg-xwayland

# Fonts
install_packages \
  ttf-dejavu \
  ttf-liberation \
  ttf-nerd-fonts-symbols-2048-em \
  ttf-noto-nerd \
  ttf-hack-nerd \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-extra

install_packages \
  firefox \
  git \
  foot \
  openssh \
  vim \
  zsh

link_xdg_config_files \
  foot \
  mako \
  sway \
  swaylock \
  waybar \
  wofi

link_dotfiles \
  gitconfig \
  oh-my-zsh \
  Xmodmap \
  zprofile \
  zshrc

