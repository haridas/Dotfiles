#!/usr/bin/env bash
# GNU/Linux (Debian/Ubuntu) bootstrap:
#   curl -fsSL https://raw.githubusercontent.com/haridas/Dotfiles/master/linux-setup.sh | bash
set -euo pipefail

# Core tools. ncurses-term provides the tmux-256color terminfo;
# xclip lets Oh my tmux copy to the system clipboard.
sudo apt-get update -q
sudo apt-get install -y git curl tmux vim fish ncurses-term xclip flake8 pylint

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Dotfiles}"
if [ -x "$DOTFILES_DIR/install.sh" ]; then
    exec "$DOTFILES_DIR/install.sh"
else
    curl -fsSL https://raw.githubusercontent.com/haridas/Dotfiles/master/install.sh | bash
fi
