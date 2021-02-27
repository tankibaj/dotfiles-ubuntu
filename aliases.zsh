# Manage Package
if [ -f /usr/bin/apt ]; then
    alias update='sudo apt update'
    alias upgrade='sudo apt dist-upgrade'
    alias install='sudo apt install'
    alias autoremove='sudo apt autoremove'
fi

# Prompt confirmation and explain what is being done
alias rm='rm -iv'
alias mv='mv -iv'
alias cp='cp -iv'
alias ln='ln -iv'

# Basic
alias zshrc='sudo nano ~/.dotfiles/.zshrc'
alias terminal-reload='source ~/.dotfiles/.zshrc'
alias aliases='sudo nano ~/.dotfiles/aliases.zsh'
alias mycountry='curl https://ifconfig.co/country'
alias mycity='curl https://ifconfig.co/city'
alias myip='curl https://ifconfig.co'
alias myip2="curl https://ipecho.net/plain"
alias whoisme="curl -s "http://ifconfig.co/json" | jq -r '.'"
alias size="sudo du -cksh * | sort -hr"
alias ports='sudo netstat -tulanp'
alias killvpn="sudo killall openvpn"
alias ipt="sudo iptables -nvL"
#alias ipa='bash ~/.dotfiles/functions/ipa.sh'
alias ls=' ls -lhF --time-style=long-iso --color=auto'
alias ls.=' ls -lhFa --time-style=long-iso --color=auto'
alias services='service  --status-all'

# Basic functions
ips() {
    if [[ $(ip -4 addr | grep inet | grep -vEc '127(\.[0-9]{1,3}){3}') -eq 1 ]]; then
        echo
        ip -4 addr | grep -w inet | grep -vE '127(\.[0-9]{1,3}){3}' | awk '{ print "\033[0;31m"$7"\033[0m"": ""\033[0;33m"$2"\033[0m"}'
    else
        echo
        ip -4 addr | grep -w inet | grep -vE '127(\.[0-9]{1,3}){3}' | awk '{ print "\033[0;31m"$7"\033[0m"": ""\033[0;33m"$2"\033[0m"}' | nl -s '| '
    fi
}

gettingStarted() {
    if [ -e GettingStarted.txt ]; then
        egrep '^\s+\$' GettingStarted.txt | sed -e 's@\$@@'
    else
        echo 'GettingStarted does not exist!!'
    fi
}

codeBlock() {
    if [ -e README.md ]; then
        sed -n '/^```/,/^```/ p' <README.md | sed '/^```/ d'
    else
        echo 'README does not exist!!'
    fi
}

codeBlockBash() {
    if [ -e README.md ]; then
        sed -n '/^```bash/,/^```/ p' <README.md | sed '/^```/ d'
    else
        echo 'README does not exist!!'
    fi
}

# See all paths, one element per line.
# If an argument is supplied, grep fot it.
PATH() {
    test -n "$1" && {
        echo $PATH | perl -p -e "s/:/\n/g;" | grep -i "$1"
    } || {
        echo $PATH | perl -p -e "s/:/\n/g;"
    }
}


# Path
alias cd..='cd ..'
alias home="cd ~"
alias sites="cd /var/www/"
alias dotfiles='~/.dotfiles'

# Git Alias
#alias init='git init'
alias clone='git clone'
alias add='git add .'
alias commit='git commit -m'
alias status='git status'
alias gl='git log'
alias log='git log'
alias push='git push -u'
alias pull='git pull'
alias nah='git reset --hard && git clean -df'
alias nahTo='git reset --hard'
alias showallbranch='git branch -a'
alias checkout='git checkout'
alias checkoutnew='git checkout -b'
alias deletebranch='git branch -D'
alias setorigin='git remote set-url origin'
alias origin='git remote show origin'
alias remote='git remote -v'
alias remote-remove='git remote remove'
alias remote-rename='git remote rename'
alias commit-count='git rev-list --count'
alias git-remove='rm -rf .git*'

# Nginx
alias nginxError='sudo tail -n 100 /var/log/nginx/error.log'
alias nginxAccess='sudo tail -n 100 /var/log/nginx/access.log'
alias site-available='cd /etc/nginx/sites-available/'
alias site-enabled='cd /etc/nginx/sites-enabled/'

# Docker
alias dstart='docker start'
alias dsa='docker ps -aq | xargs docker stop'
alias ds='docker stop'
alias drma='docker ps -aq | xargs docker rm -f'
alias drm='docker rm -f'
alias drmi='docker rmi -f'
alias drmia='docker images -aq | xargs docker rmi -f'
alias dit='docker exec -it'
alias dpsa='docker ps -a'
alias dps='docker ps'
alias dlogs='docker logs'
alias di='docker images'
alias dc='docker-compose'
alias dcupd='docker-compose up -d'
alias dcup='docker-compose up'
alias dcd='docker-compose down'
alias dcb='docker-compose build'
alias dinsp='docker inspect'


# Virsh
alias vls='sudo virsh list --all'
alias vinfo='sudo virsh dominfo'
alias vsd='sudo virsh shutdown'
alias vstart='sudo virsh start'
alias vas='sudo virsh autostart'
alias vreboot='sudo virsh reboot'
alias vreset='sudo virsh reset'
alias vsls='sudo virsh snapshot-list'
alias vcreate='sudo virsh create'
alias vdxml='sudo virsh dumpxml'
alias vedit='sudo virsh edit'

# Delte KVM instance
vDelete() {
    if [ -z $1 ]; then
        echo "VM name required!!"
    fi
    sudo virsh shutdown $1
    sudo virsh destroy $1
    sudo virsh undefine $1
    sudo virsh pool-destroy $1
    sudo rm -rfv /var/lib/libvirt/images/$1.qcow2
    if [ -f /var/lib/libvirt/images/$1-seed.qcow2 ]; then
        sudo rm -rfv /var/lib/libvirt/images/$1-seed.qcow2
    fi
}

# Create KVM Screenshot
vCreateScreenshot() {
    if [ -z $1 ]; then
        echo "VM name required!!"
    fi
    if [ -z $2 ]; then
        echo "Screenshot name required!!"
    fi
    sudo virsh snapshot-create-as --domain $1 --name $2 --description $2
}

# Revert KVM Screenshot
vRevertScreenshot() {
    if [ -z $1 ]; then
        echo "VM name required!!"
    fi
    if [ -z $2 ]; then
        echo "Screenshot name required!!"
    fi
    sudo virsh snapshot-revert --domain $1 --snapshotname $2 --running
}

# Delte KVM Screenshot
vDeleteScreenshot() {
    if [ -z $1 ]; then
        echo "VM name required!!"
    fi
    if [ -z $2 ]; then
        echo "Screenshot name required!!"
    fi
    sudo virsh snapshot-delete --domain $1 --snapshotname $2
}

# Make dir and go
mdgo() {
    test -n $1 || return
    mkdir -p $1 && cd $1
}

# Extract archive
extract() {
    if [ -f $1 ]; then
        case $1 in
        *.tar) tar xf $1 ;;
        *.tar.bz2) tar xjvf $1 ;;
        *.tar.gz) tar xzvf $1 ;;
        *.tar.xz) tar xvf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.gz) gunzip $1 ;;
        *.zip) unzip $1 ;;
        *) echo "'$1' cannot be extracted with this method!!!" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

whoisip() {
    curl -s http://ip-api.com/json/$1 | jq -r '.'
}
