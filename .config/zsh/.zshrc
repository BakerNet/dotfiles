# Lines configured by zsh-newuser-install
unsetopt beep
setopt HIST_SAVE_NO_DUPS

autoload -Uz compinit
compinit

# Plugin manager
source $ZDOTDIR/.antidote/antidote.zsh
antidote load

# zsh-history-substring-search configuration
bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=0
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=0

# End of lines added by compinstall
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Vi mode stuff
INSERT_MODE_INDICATOR="%F{yellow}+%f"

# python venv
python_venv() {
    MYVENV="./.venv"
    # Check if virtural environment exists
    [[ -d $MYVENV ]] && source $MYVENV/bin/activate > /dev/null 2>&1
    # Else deactivate
    [[ ! -d $MYVENV ]] && deactivate > /dev/null 2>&1
}
autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv
python_venv

if [[ -f "$HOME/.zshrc_private" ]]; then
  source "$HOME/.zshrc_private"
fi
