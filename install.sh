#!/usr/bin/env bash

DOTFILES=$HOME/.dotfiles # dotfiles path
ZSH=$HOME/.oh-my-zsh     # ZSH path
NANORC=$HOME/.nano       # nanorc path

targetOS() {
  local firstTargetOS=$1
  local secondTargetOS=$2
  local os=""

  if [[ "$(uname -s)" == "Darwin" ]]; then
    os="macos"
  elif [[ "$(uname -s)" == "Linux" ]]; then
    if [[ -f /etc/issue ]]; then
      if [[ "$(cat /etc/issue | grep Ubuntu | awk '{ print $1}')" = "Ubuntu" ]]; then
        os="ubuntu"
      elif [[ "$(cat /etc/issue | grep Debian | awk '{ print $1}')" = "Debian" ]]; then
        os="debian"
      fi
    fi
  fi

  if [[ $# = 1 ]]; then
    if [[ "${firstTargetOS}" == "${os}" ]]; then
      return 0
    else
      return 1
    fi
  elif [[ $# = 2 ]]; then
    if [[ "${firstTargetOS}" == "${os}" || "${secondTargetOS}" == "${os}" ]]; then
      return 0
    else
      return 1
    fi
  else
    return 1
  fi
}

userSettings() {
  sudo sh -c "echo '$1 ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers" # sudo without password
  if [[ -d /home/$1/.ssh ]]; then
    sudo rm -rf /home/$1/.ssh
  fi
  sudo mkdir /home/$1/.ssh
  sudo wget -q --no-check-certificate 'https://raw.githubusercontent.com/tankibaj/ssh/master/id_rsa.pub' -O /home/$1/.ssh/authorized_keys
  sudo chmod 700 /home/$1/.ssh/
  sudo chmod 644 /home/$1/.ssh/authorized_keys
  sudo sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config
  sudo chown -R $1:$1 /home/$1/
}

installDotfiles() {
  echo
  echo
  echo "[INFO] Setting up dotfiles....."
  echo
  echo

  # SSH KEY | SUDO without pass | Permission
  userSettings $USER

  # Update apt and install apps
  sudo apt update
  sudo apt install -qq -y zsh curl git jq zip ntp

  # SpeedTest
  wget -q https://raw.githubusercontent.com/tankibaj/speedtest/master/speedtest
  sudo chmod +x speedtest
  sudo mv speedtest /usr/bin/speedtest

  # Locale
  sudo rm -f /etc/default/locale
  sudo locale-gen "en_US.UTF-8"
  sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
  source /etc/default/locale

  # Set TimeZone
  sudo timedatectl set-timezone Europe/Berlin

  # Remove old files directories if exist
  if [[ -d $DOTFILES ]]; then
    sudo rm -rf $DOTFILES
  fi

  if [[ -d $ZSH ]]; then
    sudo rm -rf $ZSH
  fi

  if [[ -e $HOME/.p10k.zsh ]]; then
    sudo rm -f $HOME/.p10k.zsh
  fi

  if [[ -L $HOME/.zshrc ]]; then
    sudo rm -f $HOME/.zshrc
  fi

  if [[ -d $NANORC ]]; then
    sudo rm -rf $NANORC
  fi

  # ZSH
  sudo usermod -s /usr/bin/zsh $(whoami)

  # Clone dotfiles repo
  git clone https://github.com/tankibaj/dotfiles-ubuntu.git $DOTFILES

  # Backup existing .bashrc before install Oh My Zsh
  if [[ -e $HOME/.bashrc ]]; then
    sudo cp $HOME/.bashrc $HOME/.bashrc.original
  fi

  # Install Oh My Zsh
  git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH

  # Install PowerLeve10K theme
  git clone https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k

  # Download PowerLeve10K Plugins for autosuggestion and syntax highlighting:
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/plugins/zsh-syntax-highlighting

  # Symlinks the .zshrc file from .dotfiles/.zshrc
  ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

  # nanorc - improve nano syntax
  git clone https://github.com/scopatz/nanorc.git $NANORC

  echo
  echo
  echo "[INFO] Setup has been completed!!! Please restart your terminal"
  echo
}

if targetOS ubuntu debian; then
  if [[ ! -d $DOTFILES ]]; then
    installDotfiles
  else
    echo
    read -p "[INFO] Dotfiles already installed. Do you want to reinstall? [y/N]: " confirmation
    echo
    until [[ "$confirmation" =~ ^[yYnN]*$ ]]; do
      echo
      echo "[ERROR] invalid selection."
      echo
      read -p "[INFO] Dotfiles already installed. Do you want to reinstall? [y/N]: " confirmation
      echo
    done
    if [[ "$confirmation" =~ ^[yY]$ ]]; then
      installDotfiles
    fi
  fi
else
  echo
  echo "[ERROR] This script can be run only on Ubuntu | Debian OS"
  echo
  exit 1
fi