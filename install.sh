#!/bin/sh

echo "Setting up Ubuntu"

# Remove .dotfiles directory if exist
rm -rf $HOME/.dotfiles

# Locale
rm -f /etc/default/locale
locale-gen "en_US.UTF-8"
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
source /etc/default/locale

# Sudo without password
echo 'naim ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

# Install Apps
apt install -y zsh curl git jq zip

# SpeedTest
wget https://raw.githubusercontent.com/tankibaj/speedtest/master/speedtest
chmod +x speedtest
mv speedtest /usr/bin/speedtest

# ZSH
usermod -s /usr/bin/zsh $(whoami)

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
