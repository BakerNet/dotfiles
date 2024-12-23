Git bare repo

Repo location:
```
~/dotfiles
```

Initial setup:
```
mkdir ~/dotfiles
cd ~/dotfiles
git init --bare
git branch -m main
git remote add origin https://github.com/BakerNet/dotfiles
git pull
```

Add `config` command to shell RC:
```bash
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```

Use `config` instead of `git` for adding/removing dotfiles

Hide ignored files:
```bash
config config --local status.showUntrackedFiles no
```
