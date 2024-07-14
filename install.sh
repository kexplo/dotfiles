#!/usr/bin/env bash
set -euo pipefail

random_str() {
  # reference: https://stackoverflow.com/a/2793856/1545387
  printf "%s" "$(env LC_CTYPE=C tr -cd 'a-f0-9' < /dev/urandom | head -c 4)"
}

is_osx() {
 [[ "$(uname)" == "Darwin" ]]
}

_readlink() {
  if is_osx; then
    greadlink "$@"
  else
    readlink "$@"
  fi
}

check_dependency() {
  if ! is_osx; then
    return
  fi
  if ! which greadlink > /dev/null; then
    echo "Can't found greadlink, you need to run 'brew install coreutils'"
    exit 1
  fi
}

sym_link() {
  local src="$1"
  local dest="$2"

  if [[ -b "$dest" || -e "$dest" || -L "$dest" ]]; then
    if [[ "$(_readlink -f "$src")" == "$(_readlink -f "$dest")" ]]; then
      return
    fi
    backup_name="${dest}.$(random_str).bak"
    echo "Backup existing file(or directory) '$dest' to '$backup_name'"
    mv "$dest" "$backup_name"
  fi
  ln -s "$src" "$dest"
}

RC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

check_dependency

sym_link "$RC_DIR/.vimrc" "$HOME/.vimrc"
sym_link "$RC_DIR/.zshrc" "$HOME/.zshrc"
sym_link "$RC_DIR/.gitconfig" "$HOME/.gitconfig"
sym_link "$RC_DIR/.tmux.conf" "$HOME/.tmux.conf"
mkdir -p "$HOME/.config/ptpython"
sym_link "$RC_DIR/ptpython/config.py" "$HOME/.config/ptpython/config.py"
