#!/usr/bin/env bash
# macOS bootstrap:
#   curl -fsSL https://raw.githubusercontent.com/haridas/Dotfiles/master/mac-setup.sh | bash
set -euo pipefail

# Install Homebrew if missing (Apple Silicon: /opt/homebrew, Intel: /usr/local)
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
for prefix in /opt/homebrew /usr/local; do
    [ -x "$prefix/bin/brew" ] && eval "$("$prefix/bin/brew" shellenv)" && break
done

# Core tools. ncurses provides the tmux-256color terminfo.
# Python linters come from brew: pip3 install into brew's python is blocked (PEP 668).
brew install git tmux vim fish ncurses flake8 pylint

# Ghostty ships its own terminfo; install the app if you want it:
#   brew install --cask ghostty

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Dotfiles}"
if [ -x "$DOTFILES_DIR/install.sh" ]; then
    exec "$DOTFILES_DIR/install.sh"
else
    curl -fsSL https://raw.githubusercontent.com/haridas/Dotfiles/master/install.sh | bash
fi
