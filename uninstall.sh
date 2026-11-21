#!/usr/bin/env bash
# Remove the dotfiles setup. Only symlinks are removed from $HOME;
# real files at those paths are left untouched.
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Dotfiles}"
OH_MY_TMUX_DIR="$HOME/.tmux"

echo "This removes:"
echo "  symlinks ~/.vim ~/.tmux.conf ~/.tmux.conf.local"
echo "  directories $OH_MY_TMUX_DIR $DOTFILES_DIR ~/Dotfiles-master"
read -r -p "Continue? (y/n): " confirm </dev/tty

if [[ $confirm != y ]]; then
    echo "Exited without cleaning."
    exit 0
fi

for l in "$HOME/.vim" "$HOME/.tmux.conf" "$HOME/.tmux.conf.local"; do
    if [ -L "$l" ]; then
        rm "$l"
    elif [ -e "$l" ]; then
        echo "Skipping $l: not a symlink"
    fi
done
rm -rf "$OH_MY_TMUX_DIR" "$DOTFILES_DIR" "$HOME/Dotfiles-master"
echo "Uninstalled the dotfile setup from your machine."
