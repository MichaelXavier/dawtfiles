# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="gallois" # like it
#ZSH_THEME="kolo" # like it but incomplete path

if [ -n "$INSIDE_EMACS" ]; then
    export ZSH_THEME="robbyrussell"
else
    export ZSH_THEME="kolo"
fi

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(gem git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
bindkey "^R" history-incremental-search-backward

##### Haskell Customizations #####

# unregister broken GHC packages. Run this a few times to resolve dependency rot in installed packages.
# ghc-pkg-clean -f cabal/dev/packages*.conf also works.
function ghc-pkg-clean() {
    for p in `ghc-pkg check $* 2>&1  | grep problems | awk '{print $6}' | sed -e 's/:$//'`
    do
        echo unregistering $p; ghc-pkg $* unregister $p
    done
}

# remove all installed GHC/cabal packages, leaving ~/.cabal binaries and docs in place.
# When all else fails, use this to get out of dependency hell and start over.
function ghc-pkg-reset() {
    read -p 'erasing all your user ghc and cabal packages - are you sure (y/n) ? ' ans
    test x$ans == xy && ( \
        echo 'erasing directories under ~/.ghc'; rm -rf `find ~/.ghc -maxdepth 1 -type d`; \
        echo 'erasing ~/.cabal/lib'; rm -rf ~/.cabal/lib; \
        # echo 'erasing ~/.cabal/packages'; rm -rf ~/.cabal/packages; \
        # echo 'erasing ~/.cabal/share'; rm -rf ~/.cabal/share; \
        )
}

alias cabalupgrades="cabal list --installed  | egrep -iv '(synopsis|homepage|license)'"

##### Aliases ##### 
alias wgeto='wget -qO-'
alias mixer='alsamixer'
alias diskusage='gdmap'
alias octal='stat -c "%a %n" '

alias hoogle="hoogle --color"

##### Bindings #####
stty stop undef # remove ctrl+q
stty start undef # remove ctrl+s


##### Options #####
unsetopt beep
unsetopt correct_all

#TODO: remove
source $HOME/.soostonerc

##### RVM #####
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:node_modules/.bin
export PATH=$PATH:~/.cask/bin
export PATH=$PATH:~/.local/bin

alias a="ls -lrthG"

# haskell development aliases
alias cc='cabal configure'
alias ci='cabal install'
cb() { cabal build "$@" | grep -v "^Loading package" ;}

alias cct='cabal configure --ghc-options="-fno-code" --builddir=disttc'
alias cit='cabal install --ghc-options="-fno-code" --builddir=disttc'
cbt() { cabal build --builddir=disttc "$@" | grep -v "^Loading package" ;}

alias cc0='cabal configure -O0 --builddir=dist0'
alias ci0='cabal install -O0 --builddir=dist0'
cb0() { cabal build --builddir=dist0 "$@" | grep -v "^Loading package" ;}

alias csa='cabal sandbox add-source'
alias csh='cabal sandbox hc-pkg'

alias sb='stack build'
alias st='stack test'


# Git development
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}
compdef g=git

export NPROCS=`nproc`
export MAKEFLAGS="-j $NPROCS --load-average=$NPROCS"

export NVM_DIR="/home/michael/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f "$HOME/dotfiles/per_machine_config.sh" ]] && source $HOME/dotfiles/per_machine_config.sh
[[ -f "$HOME/.secrets" ]] && source $HOME/.secrets


# stack hook if available
[[ -f "$HOME/stack.sh" ]] && alias stack='$HOME/stack.sh'

# direnv if available
which direnv &>/dev/null && eval "$(direnv hook zsh)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


function portforward {
    host=$1
    src=$2
    dest=$3
    sshhost=$4
    ssh -nNT -L $dest:$host:$src $sshhost
}

function killline {
    lineno=$1
    file=$2
    sed -ie "${lineno}d" $file
}

function domodify {
    while inotifywait --quiet --event modify "${@:2}"; do zsh -c "$1"; done
}

function octal {
    stat -c "%a %n" $1
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/michael/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/home/michael/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/michael/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/michael/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

PATH=/opt/ghc/8.4.3/bin:$PATH

# added by Anaconda3 installer
export PATH="/home/michael/anaconda3/bin:$PATH"

# prioritize cabal over stack bins
export PATH=$HOME/.cabal/bin:$HOME/.local/bin:$PATH
# nix if available
[[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]] && . $HOME/.nix-profile/etc/profile.d/nix.sh

export PATH=$PATH:/usr/local/go/bin

# https://stackoverflow.com/a/8363532
case "$TERM" in
"dumb")
    PS1="> "
    ;;
esac
