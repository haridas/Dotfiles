#!/usr/bin/env bash
# Shared, idempotent dotfiles installer (macOS + GNU/Linux).
# Called by mac-setup.sh / linux-setup.sh after OS packages are installed.
# Safe to re-run: updates existing clones and only replaces our own symlinks;
# any real file in the way is moved aside to <file>.bak-<timestamp>.
set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/haridas/Dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Dotfiles}"
OH_MY_TMUX_REPO="https://github.com/gpakosz/.tmux.git"
OH_MY_TMUX_DIR="$HOME/.tmux"
STAMP="$(date +%Y%m%d%H%M%S)"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarning:\033[0m %s\n' "$*" >&2; }

for cmd in git tmux vim; do
    command -v "$cmd" >/dev/null 2>&1 || { echo "error: '$cmd' is required" >&2; exit 1; }
done

# clone_or_update <repo> <dir>
clone_or_update() {
    if [ -d "$2/.git" ]; then
        info "Updating $2"
        git -C "$2" pull --ff-only -q || warn "could not fast-forward $2; leaving as is"
    elif [ -e "$2" ]; then
        warn "$2 exists but is not a git clone; moving it to $2.bak-$STAMP"
        mv "$2" "$2.bak-$STAMP"
        git clone -q "$1" "$2"
    else
        info "Cloning $1 -> $2"
        git clone -q "$1" "$2"
    fi
}

# link <target> <link_path>
link() {
    if [ -L "$2" ]; then
        ln -sfn "$1" "$2"
    elif [ -e "$2" ]; then
        warn "$2 exists; moving it to $2.bak-$STAMP"
        mv "$2" "$2.bak-$STAMP"
        ln -s "$1" "$2"
    else
        ln -s "$1" "$2"
    fi
    info "Linked $2 -> $1"
}

clone_or_update "$DOTFILES_REPO" "$DOTFILES_DIR"

# -- tmux (Oh my tmux + our local overrides) ----------------------------------
# Keep Oh my tmux current: older versions fail to apply the theme when the
# login shell is fish (tmux >= 3.x runs its `run` snippets via default-shell).
clone_or_update "$OH_MY_TMUX_REPO" "$OH_MY_TMUX_DIR"
link "$OH_MY_TMUX_DIR/.tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES_DIR/tmux.conf.local" "$HOME/.tmux.conf.local"

if ! infocmp tmux-256color >/dev/null 2>&1; then
    warn "terminfo 'tmux-256color' not found; colours inside tmux may be wrong."
    warn "macOS: brew install ncurses | Debian/Ubuntu: sudo apt-get install ncurses-term"
fi

# -- vim -----------------------------------------------------------------------
# vim reads ~/.vim/vimrc directly; vim-plug ships in vim-files/vim/autoload.
link "$DOTFILES_DIR/vim-files/vim" "$HOME/.vim"
info "Installing vim plugins"
vim -E -s -u "$HOME/.vim/vimrc" +PlugInstall +qall </dev/null || warn "PlugInstall reported errors; run :PlugInstall inside vim"

# -- reload a running tmux server ------------------------------------------------
if tmux info >/dev/null 2>&1; then
    tmux source-file "$HOME/.tmux.conf" && info "Reloaded running tmux server"
fi

info "Done. Your dev environment is ready."
if [ "$(basename "${SHELL:-}")" != "fish" ] && command -v fish >/dev/null 2>&1; then
    echo "  fish is installed but not your login shell. To switch:"
    echo "    echo $(command -v fish) | sudo tee -a /etc/shells && chsh -s $(command -v fish)"
fi
