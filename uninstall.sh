read -p "Deleteing these files - ~/.vim ~/.tmux.conf  ~/.tmux ~/Dotfiles ~/Dotfiles-master (y/n): " confirm

if [[ $confirm == y ]]
then
    rm -rf ~/.vim ~/.tmux ~/.tmux.conf ~/Dotfiles-master
    echo "Uninstalled the dotfile setup from your machine !"
else
    echo "Exited without cleaning. !"
fi
