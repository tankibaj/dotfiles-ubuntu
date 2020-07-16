# Basic
alias terminal-reload='source ~/.bashrc'
alias mycountry='curl https://ifconfig.co/country'
alias mycity='curl https://ifconfig.co/city'
alias myip='curl https://ifconfig.co'
alias myip2="curl https://ipecho.net/plain"
alias whoIsMe="curl -s "http://ifconfig.co/json" | jq -r '.'"

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
