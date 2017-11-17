##### Exports #####

# I get hassled by remote hosts about urxvt not being a valid term
export TERM=xterm
export AUTOFEATURE=true
export AUTOTEST=true
export RSPEC=true
export RUBYOPT=rubygems
export JRUBY_OPTS=--1.9
export PATH=/opt/firefox/57.0:/usr/local/bin:$PATH:/home/michael/.gem/ruby/1.8/bin:/home/michael/bin:/home/michael/.cabal/bin:/opt/java/jre/bin
export PAGER=less
export BROWSER=google-chrome
export CHROME_BIN=/usr/bin/$BROWSER
export GOPATH=~/go

# http://stackoverflow.com/questions/5570451/how-to-start-emacs-server-only-if-it-is-not-started
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"

[[ -f "$HOME/.secrets" ]] && source $HOME/.secrets
