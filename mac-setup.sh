# Install brew
#
test -x brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install basic packages
#
brew install python3 tmux git wget

# for python linting.
pip3 install flake8 pylint

# Other parts are same as the linux setup.
wget -q https://raw.githubusercontent.com/haridas/Dotfiles/master/linux-setup.sh -O - | bash
