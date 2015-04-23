#!/bin/bash

sudo apt-get install -y git

if [ -d ~/Dotfiles ]
then
    cd ~/Dotfiles
    git pull origin master
else
    git clone https://github.com/haridas/Dotfiles.git ~/Dotfiles
fi


# Got to Git repo
cd ~/Dotfiles

# Initilize the Reop.
git submodule init
git submodule update

# Got to home.
cd

# Check the file exists or not.
if [ ! -d ~/.vim ]
then
    ln -s ~/Dotfiles/vim-files/vim ~/.vim
fi

if [ ! -e ~/.vimrc ]
then
    ln -s ~/Dotfiles/vim-files/vim/vimrc ~/.vimrc
fi

if [ ! -e ~/.tmux.conf ]
then
    ln -s ~/Dotfiles/tmux.conf ~/.tmux.conf
fi

# Build the command-t

# Intiall vim with all scripting language support.
sudo apt-get install vim-nox ruby-dev

cd ~/Dotfiles/vim-files/vim/bundle/Command-T/ruby/command-t
ruby extconf.rb
make

