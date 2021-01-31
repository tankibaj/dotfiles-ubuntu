#!/usr/bin/env bash


red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

isSupportedOS() {
    if [ "$(cat /etc/issue | grep Ubuntu | awk '{ print $1}')" = "Ubuntu" ] && [ "$(cat /etc/issue | grep Debian | awk '{ print $1}')" = "Debian" ]; then
        return 0
    else
        return 1
    fi
}


isSupportedOS ||
  {
    echo "[${red}Error${plain}] This script can be run only on Ubuntu | Debian OS"
    exit 1
  }


echo
echo
echo
echo "${green}Setting up Ubuntu${plain}"

# Sudo without password
sudo sh -c "echo 'naim ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers"

# Locale
sudo rm -f /etc/default/locale && \
sudo locale-gen "en_US.UTF-8" && \
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
source /etc/default/locale

# Remove .dotfiles directory if exist
sudo rm -rf $HOME/.dotfiles

# Install Apps
sudo apt install -y zsh curl git jq zip ntp

# Set TimeZone
sudo timedatectl set-timezone Europe/Berlin

# SpeedTest
wget https://raw.githubusercontent.com/tankibaj/speedtest/master/speedtest
sudo chmod +x speedtest
sudo mv speedtest /usr/bin/speedtest

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
sudo rm -rf $ZSH
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH

#### Install PowerLeve10K theme
sudo rm -f $HOME/.p10k.zsh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k

#### Download PowerLeve10K Plugins for autosuggestion and syntax highlighting:
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/plugins/zsh-syntax-highlighting

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
sudo rm $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Load new .zshrc
source $HOME/.zshrc


echo
echo
echo
echo "${green}Setup has been completed!!! Please restart your terminal${plain}"
