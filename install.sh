#!/bin/sh

echo "Setting up Ubuntu"

# Remove .dotfiles directory if exist
rm -rf $HOME/.dotfiles

# Repos
#SpeedTest
#sudo apt-get install gnupg1 apt-transport-https dirmngr
#export INSTALL_KEY=379CE192D401AB61
#export DEB_DISTRO=$(lsb_release -sc)
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
#echo "deb https://ookla.bintray.com/debian ${DEB_DISTRO} main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
#sudo apt-get update

# Install Apps
sudo apt install -y zsh curl git jq speedtest-cli

# ZSH
sudo usermod -s /usr/bin/zsh $(whoami)

# Clone Dotfiles
DOTFILES=$HOME/.dotfiles
git clone https://github.com/tankibaj/dotfiles-ubuntu.git $DOTFILES
cd $DOTFILES

# Backup existing .zshrc before install Oh My Zsh
cp $HOME/.bashrc $HOME/.bashrc.original

# Install Oh My Zsh
ZSH=$HOME/.oh-my-zsh
rm -rf $ZSH
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH

#### Install PowerLeve10K theme
rm -f $HOME/.p10k.zsh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k

#### Download PowerLeve10K Plugins for autosuggestion and syntax highlighting:
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/plugins/zsh-syntax-highlighting

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Load new .zshrc
source $HOME/.zshrc
