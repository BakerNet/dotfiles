# robbyrussell inspired prompt

autoload -Uz colors && colors

# Prevent Python's activate script from overwriting PROMPT
VIRTUAL_ENV_DISABLE_PROMPT=1

# Async git info
_PROMPT_GIT_INFO=""
_PROMPT_GIT_DIR=""
_PROMPT_COLOR=""
_prompt_async_fd=0

_prompt_async_callback() {
  local fd=$1
  _PROMPT_GIT_INFO=$(cat <&$fd)
  _PROMPT_GIT_DIR=$PWD
  zle -F $fd
  exec {fd}<&-
  _prompt_async_fd=0
  zle reset-prompt
}

_prompt_git_precmd() {
  # Capture exit status before anything else changes it
  (( $? == 0 )) && _PROMPT_COLOR="%{$fg_bold[green]%}" || _PROMPT_COLOR="%{$fg_bold[red]%}"

  # Clear stale info only when the directory has changed
  [[ "$PWD" != "$_PROMPT_GIT_DIR" ]] && _PROMPT_GIT_INFO=""

  # Cancel any still-running async job
  if (( _prompt_async_fd )); then
    zle -F $_prompt_async_fd 2>/dev/null
    exec {_prompt_async_fd}<&-
    _prompt_async_fd=0
  fi

  # Launch git queries in a background subshell; zle -F fires the callback
  # when the fd is readable (i.e. once the subshell exits)
  exec {_prompt_async_fd}< <(
    local branch
    branch=$(git branch --show-current 2>/dev/null)
    [[ -z "$branch" ]] && branch=$(git rev-parse --short HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
      local dirty=""
      if [[ -n "$(git status --porcelain 2>/dev/null | head -1)" ]]; then
        dirty="%{$fg[yellow]%} ✗%{$reset_color%}"
      fi
      printf '%s' " %{$fg[blue]%}git:(%{$fg[red]%}${branch}%{$fg[blue]%})%{$reset_color%}${dirty}"
    fi
  )
  zle -F $_prompt_async_fd _prompt_async_callback 2>/dev/null
}

add-zsh-hook precmd _prompt_git_precmd

setopt PROMPT_SUBST

PROMPT='${_PROMPT_COLOR}┏━%{$reset_color%}${VIRTUAL_ENV:+ (${VIRTUAL_ENV:h:t})} %{$fg_bold[cyan]%}%c%{$reset_color%}${_PROMPT_GIT_INFO}
${_PROMPT_COLOR}┗━━▶%{$reset_color%} '
