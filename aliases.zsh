# Manage Package
if [ -f /usr/bin/apt ]; then
    alias update='sudo apt update'
    alias upgrade='sudo apt dist-upgrade'
    alias install='sudo apt install'
    alias autoremove='sudo apt autoremove'
fi

# Systemctl
if [ -f /usr/bin/systemctl ]; then
    alias ctlrestart='sudo systemctl restart'    # Start or restart one or more units
    alias ctlstatus='sudo systemctl status'      # Show runtime status of one or more units
    alias ctlstop='sudo systemctl stop'          # Stop (deactivate) one or more units
    alias ctlstart='sudo systemctl start'        # Start (activate) one or more units
    alias ctlreload='sudo systemctl reload'      # Reload one or more units
    alias ctlenable='sudo systemctl enable'      # Enable one or more unit files
    alias ctldisable='sudo systemctl disable'    # Disable one or more unit files
    alias ctlkill='sudo systemctl kill'          # Send signal to processes of a unit
    alias ctlclean='sudo systemctl clean'        # Clean runtime, cache, state, logs or configuration of unit
    alias ctlisactive='sudo systemctl is-active' # Check whether units are active
    alias ctlisfailed='sudo systemctl is-failed' # Check whether units are failed
fi

#=========================================================================
#      ---------------| List & Size |---------------
#=========================================================================
if [ -x "$(command -v exa)" ]; then
    alias ls='exa --long --group --icons --binary'
    alias ls.='exa --long --group --icons --binary --all'
    alias tree='exa --tree --icons'
    alias tree.='exa --tree --icons --all'
else
    alias ls='ls -lhF'
    alias ls.='ls -lhFa'
    alias tree='tree'
fi
alias tree-="tree"
alias size="du -sh"
#[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]


# Prompt confirmation and explain what is being done
alias rm='rm -iv'
alias mv='mv -iv'
alias cp='cp -iv'
alias ln='ln -iv'
rcp() {
  if [[ $# -eq 2 ]]; then
    rsync -avzh --stats --progress $1 $2
  else
    echo "Usage: rcp <source> <destination>"
  fi
}

# Basic
alias dotfiles='cd ~/.dotfiles'
alias workspace='cd ~/workspace'
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
alias listen='ss -l -4 | grep -v "127\.0\.0" | grep "LISTEN"'
alias killvpn="sudo killall openvpn"
alias ipt="sudo iptables -nvL"
alias services='systemctl list-units --type=service'

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



# Path
#alias init='git init'
alias clone='git clone'
alias add='git add .'
alias commit='git commit -m'
alias status='git status'
alias log='git log'
alias push='git push -u'
alias pull='git pull'
alias nah='git reset --hard && git clean -df'
alias nahto='git reset --hard'
alias bls='git branch -a'
alias checkout='git checkout'
alias checkoutnew='git checkout -b'
alias branchDel='git branch -D'
alias setorigin='git remote set-url origin'
alias origin='git remote show origin'
alias rls='git remote -v'
alias remoterm='git remote remove'
alias rremoteren='git remote rename'
alias commit-count='git rev-list --count'
alias git-remove='rm -rf .git*'
gls() {
    if [[ $# -eq 1 ]]; then
        curl -s https://api.github.com/users/$1/repos | jq '.[]|["name: "+.name,"url: "+.html_url,"clone: "+.clone_url,"ssh: "+.ssh_url]'
    else
        echo "Usage: gls <github username>"
    fi
}


# Nginx
alias nginxError='sudo tail -n 100 /var/log/nginx/error.log'
alias nginxAccess='sudo tail -n 100 /var/log/nginx/access.log'
alias site-available='cd /etc/nginx/sites-available/'
alias site-enabled='cd /etc/nginx/sites-enabled/'

# Docker
alias dls='docker container list --all --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dps="docker ps --all --format 'table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}\t{{.Ports}}'"
alias dstart='docker start'
alias dsa='docker ps -aq | xargs docker stop'
alias dstop='docker stop'
alias drma='docker ps -aq | xargs docker rm -f'
alias drm='docker rm -f'
alias drmi='docker rmi -f'
alias drmia='docker images -aq | xargs docker rmi -f'
alias dit='docker exec -it'
alias dlogs='docker logs'
alias di='docker images'
alias dc='docker-compose'
alias dcupd='docker-compose up -d'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias dcbuild='docker-compose build'
alias dins='docker inspect'
alias dip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

# Virsh
alias vls='sudo virsh list --all'
alias vlssnap='sudo virsh snapshot-list'
alias vlspool='sudo virsh pool-list'
alias vlsnet='sudo virsh net-list'
alias vlsvol='sudo virsh vol-list'
alias vinfo='sudo virsh dominfo'
alias vshutdown='sudo virsh shutdown'
alias vstart='sudo virsh start'
alias vautostart='sudo virsh autostart'
alias vreboot='sudo virsh reboot'
alias vreset='sudo virsh reset'
alias vcreate='sudo virsh create'
alias vdump='sudo virsh dumpxml'
alias vedit='sudo virsh edit'

# Delte KVM instance
vDestroy() {
    if [ -z $1 ]; then
        echo "Instance name required!!"
    fi
    sudo virsh shutdown $1
    sudo virsh destroy $1
    sudo virsh undefine $1
    sudo rm -rfv /var/lib/libvirt/pool/default/$1.qcow2
    if [ -f /var/lib/libvirt/images/$1-seed.qcow2 ]; then
        sudo rm -rfv /var/lib/libvirt/images/$1-seed.qcow2
    fi
}

# Create KVM Screenshot
vCreateScreenshot() {
    if [ -z $1 ]; then
        echo "Instance name required!!"
    fi
    if [ -z $2 ]; then
        echo "Screenshot name required!!"
    fi
    sudo virsh snapshot-create-as --domain $1 --name $2 --description $2
}

# Revert KVM Screenshot
vRevertScreenshot() {
    if [ -z $1 ]; then
        echo "Instance name required!!"
    fi
    if [ -z $2 ]; then
        echo "Screenshot name required!!"
    fi
    sudo virsh snapshot-revert --domain $1 --snapshotname $2 --running
}

# Delte KVM Screenshot
vDeleteScreenshot() {
    if [ -z $1 ]; then
        echo "Instance name required!!"
    fi
    if [ -z $2 ]; then
        echo "Screenshot name required!!"
    fi
    sudo virsh snapshot-delete --domain $1 --snapshotname $2
}

#[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]

#=========================================================================
#      ---------------| Terraform |---------------
#=========================================================================
alias fmt='terraform fmt'
alias validate='terraform validate'
alias plan='terraform plan'
alias apply='terraform apply'
alias state='terraform state'
alias show='terraform show'
alias tws='terraform workspace'
destroy() {
    if [ -e .vagrant ]; then
        vagrant destroy
    elif [ -e .terraform ]; then
        terraform destroy
    else
        echo "This action isn't allowed to run in this directory"
    fi
}
#[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]

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

# Cloud-init
alias cloud-init-output='less +F /var/log/cloud-init-output.log'
alias cloud-init-status='sudo cloud-init status --wait --long'



# Func
listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -i -P | grep LISTEN
    elif [ $# -eq 1 ]; then
        sudo lsof -i -P | grep LISTEN | grep -i --color=auto $1
    else
        echo "Usage: listening [port/appname]"
    fi
}

#=========================================================================
#      ---------------| SSH |---------------
#=========================================================================
alias sshconfig="vim ~/.ssh/config"
alias sshclr='ssh-keygen -R'
alias sshls="grep '^Host' $HOME/.ssh/config | sed 's/Host //' | sort -u"

sshid() {
  cat ~/.ssh/$1.pub | pbcopy && echo "$1 public was copied to clipboard"
}

ssh-id-ls() {
  for file in ~/.ssh/*.pub; do
    printf "%s %s\n" "$(ssh-keygen -lf "$file" | awk '{$1=""}1')" "$file"
  done | column -t | grep --color=auto "$line" || echo "$line"
}

ssh-add-ls() {
  while read -r line; do
    for file in ~/.ssh/*.pub; do
      printf "%s %s\n" "$(ssh-keygen -lf "$file" | awk '{$1=""}1')" "$file"
    done | column -t | grep --color=auto "$line" || echo "$line"
  done < <(ssh-add -l | awk '{print $2}')
}
#[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]

# See all paths, one element per line. If an argument is supplied, grep fot it.
pathls() {
  test -n "$1" && {
    echo $PATH | perl -p -e "s/:/\n/g;" | grep -i "$1"
  } || {
    echo $PATH | perl -p -e "s/:/\n/g;"
  }
}
