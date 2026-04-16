alias gs="git status"
alias gc="git commit -m"
function gM {
    git checkout origin/$(git branch -l main master --format '%(refname:short)')
}
alias gSS="git stash"
alias gSP="git stash pop"
alias ga="git add"
alias gaa="git add ."
alias gpp="git push"
alias gpf="git push --force-with-lease"
alias gP="git pull"
alias gf="git fetch"
alias gb="git switch"
alias gB="git switch -c"
alias gr="git reset"
alias gR="git rebase -i"
alias gd="git diff"

alias present="nvim -c PresentStart"
alias myip="curl -4 ifconfig.co"
alias myipv6="curl -6 ifconfig.co"

alias ls="ls -G"
alias la="ls -laG"
alias ll="ls -lG"

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
