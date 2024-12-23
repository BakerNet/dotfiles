Git bare repo

Repo location:
`~/dotfiles`

Add to shell RC:
```bash
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Hide ignored files:
```bash
config config --local status.showUntrackedFiles no
```
