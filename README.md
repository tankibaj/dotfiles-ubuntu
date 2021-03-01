I have been using bash since 2007. Every time I set up a new Ubuntu or Debian machine, I manually copied my .bashrc file to each machine. It was a real mess.

Last year, I decided to execute a single command on a new machine to pull down all of my dotfiles and install all the tools I commonly use. That’s why I have created this dotfiles repository. It helps me to install everything automatically.



## Install dotfiles

###### wget

```bash
bash -c "$(wget -O- -q https://raw.githubusercontent.com/tankibaj/dotfiles-ubuntu/main/install.sh)"
```

###### curl

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tankibaj/dotfiles-ubuntu/main/install.sh)"
```
