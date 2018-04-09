# ZSH Theme emulating the Fish shell's default prompt.
# customized by kexplo

_fishy_collapsed_wd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|^$ENV{HOME}|~|g; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
}

PROMPT2="%{$fg[red]%}\ %{$reset_color%}"

# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html

prompt_venv() {
  echo -n "$(virtualenv_prompt_info)"
}

prompt_user() {
  local user_color='green'; [ $UID -eq 0 ] && user_color='red'
  echo -n "%n@%m:%{$fg[$user_color]%}"
}

prompt_path() {
  echo -n "$(_fishy_collapsed_wd)%{$reset_color%}"
}

prompt_git() {
  echo -n "%{$fg[yellow]%}$(git_prompt_info)%{$reset_color%}%(!.#.$)"
}

build_prompt() {
  prompt_venv
  prompt_user
  prompt_path
  prompt_git
}

PROMPT='$(build_prompt) '

ZSH_THEME_GIT_PROMPT_PREFIX=":"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"

ZSH_THEME_VIRTUALENV_PREFIX="%{$bg[blue]%}%{$fg_bold[white]%}("
ZSH_THEME_VIRTUALENV_SUFFIX=")%{$reset_color%}"

# show elapsed time at the RPROMPT if slower than 3sec.
start-timer() {
  COMMAND_TIMER="$SECONDS"
}
stop-timer-rprompt() {
  local return_status="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"

  #RPROMPT='${return_status}$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'
  RPROMPT="${return_status}%{$reset_color%} "
  if [[ -z "$COMMAND_TIMER" ]]
  then
    return
  fi

  local elapsed
  elapsed="$(($SECONDS - $COMMAND_TIMER))"
  unset COMMAND_TIMER

  if [[ "$elapsed" -lt 3 ]]
  then
    # ~3sec: show nothing
    return
  elif [[ "$elapsed" -lt 600 ]]
  then
    # 3sec~10min: ↳42sec (yellow)
    RPROMPT+="%F{yellow}↳%S${elapsed}sec%s%f"
  else
    # 10min~: ↳23min (red)
    RPROMPT+="%F{red}↳%S$((elapsed/60))min%s%f"
  fi
}
add-zsh-hook preexec start-timer
add-zsh-hook precmd stop-timer-rprompt
