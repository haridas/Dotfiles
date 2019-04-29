

# Install brew
#
test -x brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# install basic packages
#
brew install python3 tmux git



# Initialize the vim and other environments.
#
cd
test -d ~/Dotfiles || git clone https://github.com/haridas/Dotfiles.git

test -f ~/.vim/vimrc || ln -s ~/Dotfiles/vim-files/vim ~/.vim
test -f ~/.tmux.conf || ln -s ~/Dotfiles/tmux.conf ~/.tmux.conf

# Install vim plugins.
#
vim -c :PlugInstall -c :qa



echo "Done !"
