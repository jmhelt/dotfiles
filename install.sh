#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function update_upgrade {
  sudo pacman -Syu --noconfirm
}

function install_packages {
  sudo pacman -S --noconfirm "$@"
}

update_upgrade

# sway window manager
install_packages \
  foot \
  sway \
  swaybg \
  swayidle \
  swaylock \
  waybar \
  wmenu \
  xorg-xwayland

# fonts
install_packages \
  ttf-dejavu \
  ttf-liberation \
  ttf-nerd-fonts-symbols-2048-em \
  ttf-noto-nerd \
  ttf-hack-nerd \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-extra

# basics
install_packages \
  emacs-wayland \
  firefox \
  git \
  openssh \
  stow \
  vim \
  zsh

