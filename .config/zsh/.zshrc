# Lines configured by zsh-newuser-install
unsetopt beep

setopt HIST_SAVE_NO_DUPS
setopt extended_history
setopt hist_ignore_space
setopt hist_verify
setopt share_history
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# rust completions
if command -v rustc >/dev/null 2>&1; then
  export fpath=("$(rustc --print sysroot)"/share/zsh/site-functions $fpath)
fi

# Plugin manager
source $ZDOTDIR/.antidote/antidote.zsh
antidote load

# Completion stuff
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache yes
bindkey '^[[Z' reverse-menu-complete

# zsh-history-substring-search configuration
bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=0
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=0

# End of lines added by compinstall
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias vim="nvim"

# Vi mode stuff
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
function zvm_after_select_vi_mode() {
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      echo -ne '\e]12;red\a\e[2 q'
      ;;
    $ZVM_MODE_INSERT)
      echo -ne '\e]112\a\e[2 q'
      ;;
    $ZVM_MODE_VISUAL)
      echo -ne '\e]12;yellow\a\e[2 q'
      ;;
  esac
}

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

# Colored man pages
export LESS_TERMCAP_mb=$'\e[1;31m'   # begin blink (red)
export LESS_TERMCAP_md=$'\e[1;32m'   # begin bold (green — headings)
export LESS_TERMCAP_me=$'\e[0m'      # end bold/blink
export LESS_TERMCAP_us=$'\e[4;34m'   # begin underline (blue — emphasized)
export LESS_TERMCAP_ue=$'\e[0m'      # end underline
export LESS_TERMCAP_so=$'\e[1;44;33m' # begin standout (search highlight)
export LESS_TERMCAP_se=$'\e[0m'      # end standout

source "$ZDOTDIR/aliases.zsh"
if [[ -f "$HOME/.zshrc_private" ]]; then
  source "$HOME/.zshrc_private"
fi
source "$ZDOTDIR/prompt.zsh"
