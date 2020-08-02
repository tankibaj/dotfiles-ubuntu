## Setup SSH key
First of all, copy your ssh private and public key to `~/.ssh`

Make sure that ssh agent is running.

```bash
eval $(ssh-agent -s)
```

Add your SSH private key to the ssh-agent.

```bash
ssh-add ~/.ssh/id_rsa
```

Test git ssh connection

```bash
ssh -T git@github.com
```


## Install dotfile

#### via curl

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/tankibaj/dotfiles-ubuntu/master/install.sh)"
```

#### via wget

```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/tankibaj/dotfiles-ubuntu/master/install.sh)"
```


## Load new .zshrc

```bash
source $HOME/.zshrc
```


```bash
source $HOME/.zshrc
```
