# Some copy from https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

main() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  if ! command -v zsh >/dev/null 2>&1; then
    printf "${YELLOW}Zsh is not installed!${NORMAL} Please install zsh first!\n"
    exit
  fi

  if [ ! -n "$ZSH" ]; then
    ZSH=~/.oh-my-zsh
  fi

  if [ ! -d "$ZSH" ]; then
    printf "${YELLOW}Oh-my-zsh is not installed!${NORMAL} Please install oh-my-zsh first!\n"
    exit
  fi

  if [ ! -n "$DOTFILES" ]; then
    DOTFILES=~/.dotfiles
  fi

  if [ -d "$DOTFILES" ]; then
    printf "${YELLOW}You already have Shell Tool installed.${NORMAL}\n"
    printf "You'll need to remove $DOTFILES if you want to re-install.\n"
    exit
  fi

  # Prevent the cloned repository from having insecure permissions. Failing to do
  # so causes compinit() calls to fail with "command not found: compdef" errors
  # for users with insecure umasks (e.g., "002", allowing group writability). Note
  # that this will be ignored under Cygwin by default, as Windows ACLs take
  # precedence over umasks except for filesystems mounted with option "noacl".
  umask g-w,o-w

  printf "${BLUE}Cloning Shell Tool...${NORMAL}\n"
  command -v git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  # The Windows (MSYS) Git is not compatible with normal use on cygwin
  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi
  env git clone https://github.com/adevjoe/dotfiles.git "$DOTFILES" || {
    printf "Error: git clone of shell tool repo failed\n"
    exit 1
  }

  # source env
  ZSHRC=~/.zshrc
  VIMRC=~/.vimrc
  if [ ! -f "$ZSHRC" ]; then
    touch $ZSHRC
  fi

  if [ ! -f "$VIMRC" ]; then
    touch $VIMRC
  fi
  echo 'source $HOME/.dotfiles/.source' >> $ZSHRC
  echo 'source $HOME/.dotfiles/.vimrc' >> $VIMRC

  printf "${GREEN}"
  echo ''
  echo '________          __    _____.__.__                 '
  echo '\______ \   _____/  |__/ ____\__|  |   ____   ______'
  echo ' |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/'
  echo ' |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ '
  echo '/_______  /\____/|__|  |__|  |__|____/\___  >____  >'
  echo '        \/                                \/     \/ '
  echo ''
  echo ''
  echo 'Please look over the ~/.dotfiles file to select env, themes, func, and options.'
  echo ''
  echo 'Enter command `source ~/.dotfiles/.source` to use it in the current terminal.'
  echo ''
  echo 'p.s. Follow us at https://github.com/adevjoe'
  echo ''
  printf "${NORMAL}"
}

main
