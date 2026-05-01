#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function install_packages {
    sudo pacman -S --needed --noconfirm "$@"
}

install_packages \
    emacs-wayland \
    git \
    openssh \
    stow \
    zsh

cd "$SCRIPT_DIR"

# Initialize submodules (oh-my-zsh, plugins, doom emacs)
git submodule update --init --recursive

# Stow zsh config — creates ~/.zshenv and ~/.config/zsh -> dotfiles symlink
stow -v -t "$HOME" zsh

# Stow doom emacs — creates ~/.config/emacs -> dotfiles symlink
stow -v -t "$HOME" emacs

# Stow git config — creates ~/.gitconfig
stow -v -t "$HOME" git

# Stow doom user config — creates ~/.config/doom/
stow -v -t "$HOME" doom

# Stow pop-shell config — creates ~/.config/pop-shell/
stow -v -t "$HOME" pop-shell


echo ""
echo "====================================================="
echo " Doom Emacs setup — run the following in order:"
echo "====================================================="
echo " 1. ~/.config/emacs/bin/doom install"
echo "    (interactive: installs fonts and packages)"
echo " 2. ~/.config/emacs/bin/doom sync"
echo "    (syncs your config modules)"
echo "====================================================="
echo ""
