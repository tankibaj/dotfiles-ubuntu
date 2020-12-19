# Basic
alias zshrc='sudo nano ~/.dotfiles/.zshrc'
alias terminal-reload='source ~/.dotfiles/.zshrc'
alias aliases='sudo nano ~/.dotfiles/aliases.zsh'
alias mycountry='curl https://ifconfig.co/country'
alias mycity='curl https://ifconfig.co/city'
alias myip='curl https://ifconfig.co'
alias myip2="curl https://ipecho.net/plain"
alias whoIsMe="curl -s "http://ifconfig.co/json" | jq -r '.'"
alias size="sudo du --summarize --human-readable"
alias ports ="netstat -tupln"

# Path
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


# Virsh
alias vlist='sudo virsh list --all'
alias vinfo='sudo virsh dominfo'
alias vshutdown='sudo virsh shutdown'
alias vstart='sudo virsh start'
alias vautostart='sudo virsh autostart'
alias vreboot='sudo virsh reboot'
alias vreset='sudo virsh reset'
alias vslist='sudo virsh snapshot-list'
vDelete() {
  if [ -z $1 ]; then
    echo "VM name required!!" && exit 1
  fi
  sudo virsh shutdown $1
  sudo virsh destroy $1
  sudo virsh undefine $1
  sudo virsh pool-destroy $1
  sudo rm -rf /var/lib/libvirt/images/$1.qcow2
}
vCreateScreenshot() {
  if [ -z $1 ]; then
    echo "VM name required!!"
  fi
  if [ -z $2 ]; then
    echo "Screenshot name required!!"
  fi
  sudo virsh snapshot-create-as --domain $1 --name $2 --description $2
}
vRevertScreenshot() {
  if [ -z $1 ]; then
    echo "VM name required!!"
  fi
  if [ -z $2 ]; then
    echo "Screenshot name required!!"
  fi
  sudo virsh snapshot-revert --domain $1 --snapshotname $2 --running
}
vDeleteScreenshot() {
  if [ -z $1 ]; then
    echo "VM name required!!"
  fi
  if [ -z $2 ]; then
    echo "Screenshot name required!!"
  fi
  sudo virsh snapshot-delete --domain $1 --snapshotname $2
}
