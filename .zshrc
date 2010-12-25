# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/michael/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#custom prompt
PROMPT='%B%n@%m:%b%~> '

#show insert mode for vi editing mode
function zle-line-init zle-keymap-select {
  RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
  RPS2=$RPS1
  RPS3=$RPS1
  RPS4=$RPS1
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

#ls colors
alias ls='ls --color=auto'

#frackin linux lab
alias linux-lab='uw1-320-lab.uwb.edu'

#mixer
alias mixer='rexima'

#For cucumber with autotest
export AUTOFEATURE=true

export  GOROOT=/home/michael/go/hg
export  GOOS=linux
export  GOARCH=386
export  GOBIN=/home/michael/go/bin

#FIXME: this is retarded, there must be a better way
export PATH=$PATH:$GOBIN:/home/michael/Scripts/Ruby/MechaZilla/bin

alias autofeature='AUTOFEATURE=true autotest 2> /dev/null'

export AUTOFEATURE=true
export AUTOTEST=true
export RSPEC=true
export RUBYOPT=rubygems
export GEM_PRIVATE_KEY='/home/michael/Scripts/Ruby/Gem\ Building\ Documents/gem-private_key.pem'
export GEM_CERTIFICATE_CHAIN='/home/michael/Scripts/Ruby/Gem\ Building\ Documents/gem-public_cert.pem'
export PATH=$PATH:/home/michael/.gem/ruby/1.8/bin:/home/michael/bin:/home/michael/.cabal/bin:/usr/local/bin:/opt/java/jre/bin
export EDITOR=vim
export PAGER=less

# MOAR CORES!
alias make='make -j 5'

# Required by rvm
if [[ -s /home/michael/.rvm/scripts/rvm ]] ; then source /home/michael/.rvm/scripts/rvm ; fi
