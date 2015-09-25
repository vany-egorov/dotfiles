eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa

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

stty -ixon

alias maek=make

# docker
function docker-run-vod-encoder() {
  docker run -d -v /vagrant:/vagrant vod-encoder-v0.0.3 /usr/sbin/sshd -D
}

# docker
function docker-run-transcoder-01() {
  docker run -d -p 27018:27017 -p 2221:22 -v /vagrant:/vagrant transcoder-v0.0.8 /usr/sbin/sshd -D
}

function docker-run-transcoder-02() {
  docker run -d -p 27019:27017 -p 2222:22 -v /vagrant:/vagrant transcoder-v0.0.8 /usr/sbin/sshd -D
}

function docker-run-transcoders() {
  docker-run-transcoder-01
  docker-run-transcoder-02
}

function mongo-rm-rs0 () {
  sudo rm -rf /srv/mongodb/rs0
}

function mongo-run-0() {
  echo "stopping mongod"
  sudo /etc/init.d/mongod stop
  echo "\n"

  echo "making mongod dbpath"
  sudo mkdir -p /srv/mongodb/rs0-0
  echo "\n"

  echo "exporting locale"
  export LC_ALL=C
  echo "\n"

  echo "starting mongod"
  sudo mongod --port 27017 --dbpath /srv/mongodb/rs0-0 --bind_ip 0.0.0.0 --replSet rs0 --smallfiles --oplogSize 128
}

function mongo-run-1() {
  echo "stopping mongod"
  sudo /etc/init.d/mongod stop
  echo "\n"

  echo "making mongod dbpath"
  sudo mkdir -p /srv/mongodb/rs0-1
  echo "\n"

  echo "exporting locale"
  export LC_ALL=C
  echo "\n"

  echo "starting mongod"
  sudo mongod --port 27018 --dbpath /srv/mongodb/rs0-1 --bind_ip 0.0.0.0 --replSet rs0 --smallfiles --oplogSize 128
}

function mongo-run-2() {
  echo "stopping mongod"
  sudo /etc/init.d/mongod stop
  echo "\n"

  echo "making mongod dbpath"
  sudo mkdir -p /srv/mongodb/rs0-2
  echo "\n"

  echo "exporting locale"
  export LC_ALL=C
  echo "\n"

  echo "starting mongod"
  sudo mongod --port 27019 --dbpath /srv/mongodb/rs0-2 --bind_ip 0.0.0.0 --replSet rs0 --smallfiles --oplogSize 128
}

function to-transcoder-01() {
  ssh vany@127.0.0.1 -p 2221
}

function to-transcoder-02() {
  ssh vany@127.0.0.1 -p 2222
}

# vod-encoder
function vod-encoder-touch() {
  cwd=$(pwd);

  cd /vagrant/cdn-origin/tmp/vod-encoder/var/lib/vod-encoder-01;
  touch gravity_2014_06_24.done;
  touch gravity_high_40.done;
  touch 3380800_trailer.done;
  touch 3380790_trailer.done;
  ls -lah;

  cd /vagrant/cdn-origin/tmp/vod-encoder/var/lib/vod-encoder-02;
  touch gravity_2014_06_24.done;
  touch gravity_high_40.done;
  touch 3380800_trailer.done;
  touch 3380790_trailer.done;
  ls -lah;

  cd $pwd;
}

# rvm
source ~/.rvm/scripts/rvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#
export PYTHONIOENCODING=utf-8

function git-commit() {
  git add . && git add -u && git commit -am "autocommit fix" && git push
}

function to-asyncio() {
  cd "/vagrant/asyncio/src";
  source "/vagrant/asyncio/env/py3.4/bin/activate";
}

function to-cdn-api() {
  cd "/vagrant/cdn-api";
  source "/vagrant/cdn-api/env/py3.4/bin/activate";
}

function to-cdn-api-migrate() {
  cd "/vagrant/cdn-api-migrate/src";
  source "/vagrant/cdn-api-migrate/env/py3.4/bin/activate";
}

function to-cdn-api-ldap() {
  cd "/vagrant/cdn-api-ldap/src";
  export GOROOT=/vagrant/cdn-api-ldap/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cdn-api-ldap/env/gopath;
  export PATH=$PATH:$GOPATH/bin; 
  export PATH=$PATH:/vagrant/cdn-api-ldap/bin;
}

function to-cdn-api-deb() {
  cd "/vagrant/cdn-api-deb";
}

function to-cdn-api-bin-deb() {
  cd "/vagrant/cdn-api-bin-deb";
}

function to-cdn-admin() {
  cd "/vagrant/cdn-admin";
  source "/vagrant/cdn-admin/env/py3.4/bin/activate";
  rvm use ruby-2.1.5;
  rvm gemset use cdn-admin;
}

function to-cdn-admin-deb() {
  cd "/vagrant/cdn-admin-deb";
}

function to-cdn-admin-bin-deb() {
  cd "/vagrant/cdn-admin-bin-deb";
}

function to-cdn-ui() {
  cd "/vagrant/cdn-ui/src";
  export GOROOT=/vagrant/cdn-ui/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cdn-ui/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-cdn-supervisor() {
  cd "/vagrant/cdn-supervisor";
  source "/vagrant/cdn-supervisor/env/py3.4/bin/activate";
}

function to-cdn-supervisor-deb() {
  cd "/vagrant/cdn-supervisor-deb";
}

function to-cdn-supervisor-bin-deb() {
  cd "/vagrant/cdn-supervisor-bin-deb";
}

function to-cdn-redirector() {
  cd "/vagrant/cdn-redirector";
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
  export PATH=$PATH:/vagrant/cdn-origin/bin;
}

function to-cdn-asset-descrambler() {
  cd "/vagrant/cdn-asset-descrambler/src";
  export GOROOT=/vagrant/cdn-asset-descrambler/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cdn-asset-descrambler/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-cdn-asset-manifester() {
  cd "/vagrant/cdn-asset-manifester/src";
  export GOROOT=/vagrant/cdn-asset-manifester/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cdn-asset-manifester/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-cdn-node() {
  cd "/vagrant/cdn-node/src";
  export GOROOT=/vagrant/cdn-node/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cdn-node/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  export PATH=$PATH:/vagrant/cdn-node/bin;
}

function to-cdn() {
  cd "/vagrant/cdn/src";
  export GOROOT=/vagrant/cdn/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cdn/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  export PATH=$PATH:/vagrant/cdn/bin;
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
  rvm use ruby-2.1.5;
  # rvm gemset use redmine-2.6-stable;
  rvm gemset use redmine-3.0-stable;
  # rake resque:scheduler
  # QUEUES=* rake resque:work
}

function to-bbl-streamer() {
  cd "/vagrant/bbl-streamer";
}

function bbl-streamer-rsync {
	rsync \
		-avz --info=progress2 \
		-e "ssh -p 2222" \
		/vagrant/bbl-streamer \
		--exclude '.git' \
		--exclude 'env' \
		--exclude 'bin' \
		--exclude 'log' \
		--exclude '*.fix' \
		egorov@172.16.33.151:/home/egorov
}

function to-f451() {
  cd "/vagrant/f451/src";
  export GOROOT=/vagrant/f451/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/f451/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  export PATH=$PATH:/vagrant/f451/bin;
}

function to-f451-server() {
  cd "/vagrant/f451-server";
  export GOROOT=/vagrant/f451-server/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/f451-server/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  export PATH=$PATH:/vagrant/f451-server/bin;
}

function to-f451-agent() {
  cd "/vagrant/f451-agent";
  export GOROOT=/vagrant/f451-agent/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/f451-agent/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  export PATH=$PATH:/vagrant/f451-agent/bin;
}

function to-monitoring-hls() {
  cd "/vagrant/monitoring-hls/src";
  export GOROOT=/vagrant/monitoring-hls/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/monitoring-hls/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  source "/vagrant/monitoring-hls/env/py3.4/bin/activate";
}

function to-monitoring-iptv() {
  cd "/vagrant/monitoring-iptv/src";
  export GOROOT=/vagrant/monitoring-iptv/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/monitoring-iptv/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  source "/vagrant/monitoring-iptv/env/py3.4/bin/activate";
}

function to-ttk() {
  cd "/vagrant/ttk/src";
  export GOROOT=/vagrant/ttk/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/ttk/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-etcd() {
  cd "/home/vany/etcd-0.4.6";
  export GOROOT=/home/vany/etcd-0.4.6;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/home/vany/etcd-0.4.6/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-b-stats() {
  cd "/vagrant/b-stats";
  source "/vagrant/b-stats/env/py2.7/bin/activate";
}

function to-transcoder-etcd() {
  cd "/vagrant/transcoder-etcd";
  export GOROOT=/vagrant/transcoder-etcd/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/transcoder-etcd/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-transcoder-ctl-test() {
  cd "/vagrant/transcoder-ctl-test";
  export GOROOT=/vagrant/transcoder-ctl-test/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/transcoder-ctl-test/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-transcoder-http-api() {
  cd "/vagrant/transcoder-http-api";
  source "/vagrant/transcoder-http-api/env/py2.7/bin/activate";
}

function to-transcoder-http-api-deb() {
  cd "/vagrant/transcoder-http-api-deb";
  deactivate;
}

function to-transcoder-ctl() {
  cd "/vagrant/transcoder-ctl";
  source "/vagrant/transcoder-ctl/env/py2.7/bin/activate";
}

function to-transcoder-ctl-deb() {
  cd "/vagrant/transcoder-ctl-deb";
  deactivate;
}

function to-transcoder-salt() {
  cd "/vagrant/transcoder-salt";
  deactivate;
}

function to-transcoder-schema() {
  cd "/vagrant/transcoder-schema";
  deactivate;
}

function to-transcoder-http-api-zabbix() {
  cd "/vagrant/transcoder-http-api-zabbix";
  source "/vagrant/transcoder-http-api-zabbix/env/py2.7/bin/activate";
}

function to-transcoder-test() {
  cd "/vagrant/transcoder-test";
  export GOROOT=/vagrant/transcoder-test/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/transcoder-test/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  export PATH=$PATH:/vagrant/transcoder-test/bin;
}

function to-transcoder-ffmpeg() {
  cd "/vagrant/transcoder-ffmpeg";
}

function to-docs() {
  cd "/vagrant/docs/sphinx";
  source "/vagrant/docs/env/py3.4/bin/activate";
}
function to-docs-cdn() { to-docs; cd "/vagrant/docs/sphinx/source/subdocs/mts/cdn"; }
function to-docs-cas() { to-docs; cd "/vagrant/docs/sphinx/source/subdocs/limbo/cas"; }
function to-docs-trans-1.X() { to-docs; cd "/vagrant/docs/sphinx/source/subdocs/transcoder/1.X"; }

function to-cas() {
  cd "/vagrant/cas/src";
  export GOROOT=/vagrant/cas/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/cas/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  export PATH=$PATH:/vagrant/cas/bin;
}

function to-enc-poller() {
  cd "/vagrant/enc-poller/src";
  export GOROOT=/vagrant/enc-poller/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/enc-poller/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  export PATH=$PATH:/vagrant/enc-poller/bin;
}

function to-swagger-ui() {
  cd /vagrant/swagger-ui/src;
  export GOROOT=/vagrant/swagger-ui/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/swagger-ui/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  export PATH=$PATH:/vagrant/swagger-ui/bin;
}

function to-oss-proxy() {
  cd "/vagrant/oss-proxy";
  export GOROOT=/vagrant/oss-proxy/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/oss-proxy/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

function to-dproxystv() {
  cd "/vagrant/dproxystv";
  source "/vagrant/dproxystv/env/py/bin/activate";
}

function to-shifu() {
  cd "/vagrant/shifu/src";
  export GOROOT=/vagrant/shifu/env/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/vagrant/shifu/env/gopath;
  export PATH=$PATH:$GOPATH/bin;
  export PATH=$PATH:/vagrant/shifu/bin;
}

function to-etcd-master() {
  cd "/home/egorov/etcd-master";
  export GOROOT=/home/egorov/go;
  export PATH=$PATH:$GOROOT/bin;
  export GOPATH=/home/vany/etcd-master/gopath;
  export PATH=$PATH:$GOPATH/bin;
}

