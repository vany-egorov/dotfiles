# Set up the prompt
autoload -Uz compinit compinit
autoload -Uz promptinit
promptinit
prompt adam2

setopt histignorealldups

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# rvm
source ~/.rvm/scripts/rvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#
export PYTHONIOENCODING=utf-8

function to-cdn-api() {
  cd "/vagrant/cdn-api/src";
  source "/vagrant/cdn-api/env/py/bin/activate";
}

function to-cdn-admin() {
  cd "/vagrant/cdn-admin/src";
  source "/vagrant/cdn-admin/env/py/bin/activate";
}

function to-cdn-supervisor() {
  cd "/vagrant/cdn-supervisor/src";
  source "/vagrant/cdn-supervisor/env/py/bin/activate";
}

function to-cdn-redirector() {
  cd "/vagrant/cdn-redirector";
  source "/vagrant/cdn-redirector/env/py/bin/activate";
  export GOROOT=/vagrant/cdn-redirector/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cdn-redirector/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-cdn-salt() {
  cd "/vagrant/cdngo-salt";
}

function to-cdn-origin() {
  cd "/vagrant/cdn-origin/src";
  export GOROOT=/vagrant/cdn-origin/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cdn-origin/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-cdn-node() {
  cd "/vagrant/cdn-node/src";
  export GOROOT=/vagrant/cdn-node/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cdn-node/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-cdn-log-parser() {
  cd "/vagrant/cdn-log-parser";
  export GOROOT=/vagrant/cdn-log-parser/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cdn-log-parser/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-redmine() {
  cd "/vagrant/redmine";
  rvm use ruby-2.1.1;
  rvm gemset use redmine;
}
