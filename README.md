# ⚠️  DEPRECATED

Further development has moved to [tankibaj/dotfiles](https://github.com/tankibaj/dotfiles).



Your dotfiles are how you personalize your system. These are mine.

Every time I set up a new Ubuntu machine, I manually copied my .bashrc file to each machine. It was a real mess. So, I decided to execute a single command on a new machine to pull down all of my dotfiles and install all the tools I commonly use. That’s why I have created this dotfiles repository. It helps me to automate the setup process and maintain aliases.


## Install dotfiles

###### wget

```bash
bash -c "$(wget -O- -q https://raw.githubusercontent.com/tankibaj/dotfiles-ubuntu/main/install.sh)"
```

###### curl

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tankibaj/dotfiles-ubuntu/main/install.sh)"
```
