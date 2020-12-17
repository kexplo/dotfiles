#!/usr/bin/env zsh

source "$HOME/stdlib.sh"
source "$HOME/.zplug/init.zsh"

zplug "lib/theme-and-appearance", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/virtualenv", from:oh-my-zsh
zplug "plugins/zsh-navigation-tools", from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

zplug "agkozak/zsh-z"

zplug "kexplo/dotfiles", as:theme, use:kexplo.zsh-theme

# zplug load --verbose
zplug load

############################################################################################

# == basics
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

############################################################################################

# Edit current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=yellow'
ZSH_HIGHLIGHT_STYLES[default]='fg=cyan'

autoload -U colors && colors

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

if is_osx; then
  alias ls='ls -G'
else
  alias ls='ls --color=tty'
fi
alias l='ls'

alias tmux='tmux -2'
alias fzf="fzf --preview 'head -100 {}'"
alias rg='rg --hidden'
alias utc='date -u "+%x %T %Z"'

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

# Linuxbrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# pipsi
export PATH="$HOME/.local/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# direnv
if which direnv >/dev/null; then eval "$(direnv hook zsh)"; fi

# snap
export PATH="/snap/bin:$PATH"

# microk8s kubectl
alias kubectl='microk8s.kubectl'

# Load local config
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
