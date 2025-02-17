#!/usr/bin/env zsh
#
# configs that should be set before p10k instant prompt
#

# direnv: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#how-do-i-initialize-direnv-when-using-instant-prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

############################################################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# direnv: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#how-do-i-initialize-direnv-when-using-instant-prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

############################################################################################
# zplug
#
if [[ -f "$HOME/.zplug/init.zsh" ]]; then
  source "$HOME/.zplug/init.zsh"

  # disable async git prompt
  # zstyle ':omz:alpha:lib:git' async-prompt no

  zplug "lib/theme-and-appearance", from:oh-my-zsh
  zplug "lib/completion", from:oh-my-zsh
  zplug "lib/git", from:oh-my-zsh
  zplug "plugins/virtualenv", from:oh-my-zsh
  zplug "plugins/zsh-navigation-tools", from:oh-my-zsh
  zplug "plugins/kube-ps1", from:oh-my-zsh

  zplug "zsh-users/zsh-autosuggestions"
  zplug "zsh-users/zsh-completions"
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "zsh-users/zsh-history-substring-search"

  zplug "agkozak/zsh-z"

  # zplug "kexplo/dotfiles", as:theme, use:kexplo.zsh-theme
  zplug romkatv/powerlevel10k, as:theme, depth:1

  # zplug load --verbose
  zplug load
fi

############################################################################################
# zsh settings
#

# === basics
unsetopt auto_cd
setopt interactive
setopt interactivecomments

# === history
setopt appendhistory
setopt extendedhistory
setopt incappendhistory
setopt sharehistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorespace
setopt histverify

# === completion
setopt alwaystoend
setopt completeinword

# === prompt
setopt promptsubst

# === job contorl
setopt longlistjobs
setopt monitor

# === I/O
setopt ignoreeof     # Prevent closing the terminal using ^D
setopt noflowcontrol

# === Enable zstat
zmodload -F zsh/stat b:zstat

# Edit current command line
autoload -U edit-command-line
zle -N edit-command-line
zstyle :zle:edit-command-line editor nvim -f
bindkey '\C-x\C-e' edit-command-line

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=yellow'
ZSH_HIGHLIGHT_STYLES[default]='fg=cyan'

autoload -U colors && colors

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

############################################################################################
# zshrc
#

alias vim='nvim'

# if it is macOS
if [[ "$(uname)" == "Darwin" ]]; then
  alias ls='ls --color=auto'
else
  alias ls='ls --color=tty'
fi
alias l='ls'

alias tmux='tmux -2'
alias rg='rg --hidden'
alias utc='date -u "+%x %T %Z"'

# WSL
(( ${+commands[clip.exe]} )) && alias clip='clip.exe'

alias git-cleanup-branch='git fetch --all -p && git branch -v | grep gone | cut -c 3- | awk '\''{print $1}'\'' | xargs git branch -D'

#F1 ^[OP
#F2 ^[OQ
#F3 ^[OR
#F4 ^[OS
#F5 ^[[15~
#F6 ^[[17~
#F7 ^[[18~
#F8 ^[[19~
#F9 ^[[20~
#F10 ^[[21~
#F11 ^[[23~
#F12 ^[[24~

# Bind keys: [Home] and [End].
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

# Bind history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# Inside tmux
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

alias kgit='LANG=ko_KR git'
alias git='LANG=en_US git'

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export LESS='-RXF'

# fzf
alias fzfp="fzf --preview 'head -100 {}'"
(( ${+commands[fzf]} )) && source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--tmux center'

# Linuxbrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# pyenv
if (( ${+commands[pyenv]} )); then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  (( ${+commands[pyenv-virtualenv-init]} )) && eval "$(pyenv virtualenv-init -)"
fi

# enable Docker buildkit
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# snap
export PATH="/snap/bin:$PATH"

############################################################################################
# p10k
#

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    # os_icon               # os identifier
    virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
    dir                     # current directory
    vcs                     # git status
    # =========================[ Line #2 ]=========================
    newline                 # \n
    prompt_char             # prompt symbol
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    background_jobs         # presence of background jobs
    kubecontext             # current kubernetes context (https://kubernetes.io/)
    aws                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
    context                 # user@hostname
    time                    # current time
    # =========================[ Line #2 ]=========================
    newline
  )

  # always show kubecontext
  unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND

  # virtualenv
  typeset -g POWERLEVEL9K_VIRTUALENV_LEFT_DELIMITER='('
  typeset -g POWERLEVEL9K_VIRTUALENV_RIGHT_DELIMITER=')'
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=false

  # status
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=true

  # prompt char
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='$'

  # always show context
  unset POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION
fi

############################################################################################

function uvs() {
    if [ ! -d .venv ]; then
        uv venv
    fi
    source .venv/bin/activate
}

# Load local config
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
