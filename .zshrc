# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="gallois" # like it
#ZSH_THEME="kolo" # like it but incomplete path
ZSH_THEME="eastwood" # like it, but should steal kolo's colors
ZSH_THEME="eastwoodkolo" # like it, but should steal kolo's colors

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
plugins=(bundler gem vi-mode archlinux rails rails3)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

bindkey "^R" history-incremental-search-backward

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
    read "ans?erasing all your user ghc and cabal packages - are you sure (y/n) ? "
    if [[ "$ans" =~ ^[Yy]$ ]]
    then
      echo 'erasing directories under ~/.ghc'
      rm -rf `find ~/.ghc -maxdepth 1 -type d`;
      echo 'erasing ~/.cabal/lib'
      rm -rf ~/.cabal/lib;
    fi
}

alias cabalupgrades="cabal list --installed  | egrep -iv '(synopsis|homepage|license)'"

##### Aliases ##### 
alias make='make -j 5'
alias wgeto='wget -qO-'
alias mixer='alsamixer'

alias hoogle="hoogle --color"

##### Bindings #####
stty stop undef # remove ctrl+q
stty start undef # remove ctrl+s

##### Exports #####

# I get hassled by remote hosts about urxvt not being a valid term
export TERM=rxvt
export AUTOFEATURE=true
export AUTOTEST=true
export RSPEC=true
export RUBYOPT=rubygems
export GEM_PRIVATE_KEY='/home/michael/Scripts/Ruby/Gem\ Building\ Documents/gem-private_key.pem'
export GEM_CERTIFICATE_CHAIN='/home/michael/Scripts/Ruby/Gem\ Building\ Documents/gem-public_cert.pem'
export PATH=$PATH:/home/michael/.gem/ruby/1.8/bin:/home/michael/bin:/home/michael/.cabal/bin:/usr/local/bin:/opt/java/jre/bin
export EDITOR="gvim -f"
export PAGER=less
export BROWSER=google-chrome

# This significantly increases ram usage of REE but cut my spec run time in half
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_HEAP_FREE_MIN=500000
export RUBY_GC_MALLOC_LIMIT=1000000000

##### Options #####
unsetopt beep
unsetopt correct_all

source $HOME/.crystalrc

##### RVM #####
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

##### Tmuxinator #####
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

source ~/.crystalrc

alias a="ls -lrthG"

function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}
compdef g=git
