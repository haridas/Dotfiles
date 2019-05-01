#!/bin/bash
DOT_PROJECT_HOME=~/Dotfiles-master
DOT_PROJECT_HOME_ZIP=~/Dotfiles-master.zip

if [ ! -d $DOT_PROJECT_HOME ]
then
    wget https://github.com/haridas/Dotfiles/archive/master.zip -O $DOT_PROJECT_HOME_ZIP
    mkdir $DOT_PROJECT_HOME
    unzip $DOT_PROJECT_HOME_ZIP -d ~/
    rm $DOT_PROJECT_HOME_ZIP
fi


# Check the file exists or not.
if [ ! -d ~/.vim ]
then
    ln -s $DOT_PROJECT_HOME/vim-files/vim ~/.vim
fi

if [ ! -e ~/.tmux.conf ]
then
    ln -s $DOT_PROJECT_HOME/tmux.conf ~/.tmux.conf
fi

# Install plugins.
vim -c :PlugInstall -c :qa

echo "Congrats !, your Dev environment is ready."
