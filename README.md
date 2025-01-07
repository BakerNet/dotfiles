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
git remote add origin https://github.com/BakerNet/dotfiles
```

Add `config` command to shell RC:
```bash
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
```
Use `config` instead of `git` for adding/removing dotfiles

Pull the dotfiles:
```bash
config checkout main
config pull
```

Hide untracked files:
```bash
config config --local status.showUntrackedFiles no
```
