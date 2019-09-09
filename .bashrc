# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*)
	;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa

alias ssh-vagrant='ssh vagrant'
alias dch='VISUAL=vim dch'

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# if [[ "$TERM" =~ 256color ]]; then
export PS1="\[\033[38;5;113m\]\u \[\033[38;5;39m\]\w\[\033[0m\]\$(parse_git_branch)\[\033[00m\] $ "
# else
#	export PS1="\[\033[0;32m\]\u \[\033[36m\]\w\[\033[0m\]\$(parse_git_branch)\[\033[00m\] $ "
# fi

# https://www.mankier.com/1/exa
# da = a file's date;
# di = directories;
export EXA_COLORS="da=38;5;253:di=38;5;253"
alias ll='exa -abghl'
alias la='ls -A'
alias l='exa'
alias cat='bat'

function transcoder-ctl-rsync {
	rsync \
		-avz --info=progress2 \
		-e "ssh -p 2222" \
			/mnt/d/vm/debian/gl-ce.int/transcoder/ctl/* \
			--exclude '.git' \
			--exclude 'env/go' \
			--exclude 'env/gopath' \
			--exclude 'bin' \
			--exclude 'log' \
		--exclude 'src/vendor' \
			--exclude '*.fix' \
			--exclude 'tmp' \
			egorov@bl-dev-gpu2-trans01.int:/home/egorov/transcoder-ctl
}

function bbl-streamer-rsync {
	rsync \
		-avz --info=progress2 \
		-e "ssh -p 2222" \
		/mnt/d/vm/debian/gl-ce.int/transcoder/bbl-streamer/* \
		--exclude '.git' \
		--exclude 'env/go' \
		--exclude 'env/gopath' \
		--exclude 'bin' \
		--exclude 'log' \
		--exclude '*.fix' \
		--exclude '*.ts' \
		--exclude 'CudaSample' \
		--exclude 'CudaSample-5.5' \
		egorov@bl-dev-gpu2-trans01.int:/home/egorov/transcoder/bbl-streamer
}

function gpac-rsync {
	rsync \
		-avz --info=progress2 \
		-e "ssh -p 2222" \
		/mnt/d/vm/debian/github.com/gpac/gpac/* \
		--exclude '.git' \
		--exclude 'bin' \
		--exclude 'log' \
		egorov@bl-dev-gpu2-trans01.int:/home/egorov/gpac
}

function transcoder-ffmpeg-vanila-rsync {
	rsync \
		-avz --info=progress2 \
		-e "ssh -p 2222" \
		/mnt/d/vm/debian/transcoder-ffmpeg-vanila \
		--exclude '.git' \
		--exclude 'env/go' \
		--exclude 'env/gopath' \
		--exclude 'bin' \
		--exclude 'log' \
		--exclude '*.fix' \
		--exclude 'tmp' \
		egorov@bl-dev-gpu2-trans01.int:/home/egorov
}

function transcoder-transcoder-core-2-deb-rsync {
	rsync \
		-avz --info=progress2 \
		-e "ssh -p 2222" \
		/mnt/d/vm/debian/transcoder-transcoder-core-2-deb \
		--exclude '.git' \
		--exclude 'env' \
		--exclude 'bin' \
		--exclude 'log' \
		--exclude '*.fix' \
		egorov@bl-dev-gpu2-trans01.int:/home/egorov
}

function enc-worker-rsync {
	rsync \
		-avz --info=progress2 \
		-e "ssh -p 2222" \
		/mnt/d/vm/debian/gl-ce.int/enc/worker \
		--exclude '.git' \
		--exclude 'env/go' \
		--exclude 'env/gopath' \
		--exclude 'vendor' \
		--exclude 'bin' \
		--exclude 'log' \
		--exclude '*.fix' \
		--exclude 'tmp' \
		egorov@bl-dev-gpu2-trans01.int:/home/egorov
}

function enc-bblvod-rsync {
	rsync \
		-avz --info=progress2 \
		-e "ssh -p 2222" \
		/mnt/d/vm/debian/gl-ce.int/enc/bblvod \
		--exclude '.git' \
		egorov@bl-dev-gpu2-trans01.int:/home/egorov
}

function enc-bblvod-deb-rsync {
	rsync \
		-avz --info=progress2 \
		--rsync-path="mkdir -p /home/egorov/enc/ && rsync" \
		-e "ssh -p 2222" \
		/mnt/d/vm/debian/gl-ce.int/enc/bblvod-deb \
		--exclude '.git' \
		--exclude 'tmp' \
		egorov@bl-dev-gpu2-trans01.int:/home/egorov/enc
}

function enc-ui-old-rsync {
	rsync \
		-avz --info=progress2 \
		--rsync-path="mkdir -p /home/egorov/enc/ && rsync" \
		-e "ssh -p 2222" \
		/mnt/d/vm/debian/gl-ce.int/enc/ui-old \
		--exclude '.git' \
		--exclude 'tmp' \
		egorov@bl-dev-gpu2-trans01.int:/home/egorov/enc
}

function vanga-rsync {
	rsync \
		-avz --info=progress2 \
		-e "ssh -p 2222" \
		/mnt/d/vm/debian/gl.bradburylab.tv/vanga/vanga \
		--exclude '.git' \
		--exclude 'env/go' \
		--exclude 'env/gopath' \
		--exclude 'bin' \
		--exclude 'log' \
		--exclude '*.fix' \
		egorov@bl-dev-gpu2-trans01.int:/home/egorov
}

function sandbox-rsync {
    rsync \
	-avz --info=progress2 \
	-e "ssh -p 2222" \
	/mnt/d/vm/debian/sandbox \
	--exclude '.git' \
	--exclude 'env/go' \
	--exclude 'env/gopath' \
	--exclude 'bin' \
	--exclude 'log' \
	--exclude 'target' \
	--exclude 'node_modules' \
	--exclude '*.fix' \
	egorov@bl-dev-gpu2-trans01.int:/home/egorov
}

function sandbox-rsync {
    rsync \
	-avz --info=progress2 \
	-e "ssh -p 2222" \
	/mnt/d/vm/debian/sandbox \
	--exclude '.git' \
	--exclude 'env/go' \
	--exclude 'env/gopath' \
	--exclude 'bin' \
	--exclude 'log' \
	--exclude 'target' \
	--exclude 'node_modules' \
	--exclude '*.fix' \
	egorov@bl-dev-gpu2-trans01.int:/home/egorov
}

function va-ts-rsync {
    rsync \
	-avz --info=progress2 \
	-e "ssh -p 2222" \
	/mnt/d/vm/debian/github.com/video-audio/va-ts \
	--exclude '.git' \
	--exclude 'target' \
	egorov@bl-dev-gpu2-trans01.int:/home/egorov
}

function va-tool-rsync {
    rsync \
	-avz --info=progress2 \
	-e "ssh -p 2222" \
	/mnt/d/vm/debian/github.com/video-audio/va-tool \
	--exclude '.git' \
	--exclude 'target' \
	egorov@bl-dev-gpu2-trans01.int:/home/egorov
}

function va-dumps-rsync {
    rsync \
	-avz --info=progress2 \
	-e "ssh -p 2222" \
	/mnt/d/vm/debian/github.com/video-audio/va-dumps \
	--exclude '.git' \
	egorov@bl-dev-gpu2-trans01.int:/home/egorov
}

function git-lg-fzf {
	git lg |
		fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
			--bind "ctrl-m:execute:
				echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
				xargs -I % sh -c 'git show --color=always % | less -R'"
}

function git-checkout-b-fzf() {
	local branches target
	branches=$(
		git branch --all | grep -v HEAD |
		sed "s/.* //" | sed "s#remotes/[^/]*/##" |
		sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
	target=$(
		(echo "$branches") |
		fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
			--ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
	git checkout $(echo "$target" | awk '{print $2}')
}

function git-checkout-t-fzf() {
	local tags target
	tags=$(
		git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
	target=$(
		(echo "$tags") |
		fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
			--ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
	git checkout $(echo "$target" | awk '{print $2}')
}

PATH_PROJECTS="/mnt/d/vm/debian"
PATH_GITHUB_COM="${PATH_PROJECTS}/github.com"
PATH_GL_BRADBURYLAB_TV="${PATH_PROJECTS}/gl.bradburylab.tv"
PATH_GL_CE_INT="${PATH_PROJECTS}/gl-ce.int"

PATH_REMOTE_PROJECTS="/vagrant"
PATH_REMOTE_GITHUB_COM="${PATH_REMOTE_PROJECTS}/github.com"
PATH_REMOTE_GL_BRADBURYLAB_TV="${PATH_REMOTE_PROJECTS}/gl.bradburylab.tv"
PATH_REMOTE_GL_CE_INT="${PATH_REMOTE_PROJECTS}/gl-ce.int"

PATH_SANDBOX="${PATH_PROJECTS}/sandbox"
PATH_LIBVA="${PATH_SANDBOX}/c-cpp/04-udp-mpegts"
PATH_REMOTE_SANDBOX="${PATH_REMOTE_PROJECTS}/sandbox"
PATH_REMOTE_LIBVA="${PATH_REMOTE_SANDBOX}/c-cpp/04-udp-mpegts"
function tmux-dev-libva {
	tmux new-session -s libva -n c-make   -d "cd '${PATH_LIBVA}/src'   ; /bin/bash" &&
	tmux new-window           -n c-run       "cd '${PATH_LIBVA}/src'   ; ssh -t vagrant 'cd ${PATH_REMOTE_LIBVA}/src && /bin/zsh -i'; /bin/bash" &&
	tmux new-window           -n tsplay      "cd '${PATH_LIBVA}/src'   ; ssh -t vagrant 'cd ${PATH_REMOTE_LIBVA}/src && /bin/zsh -i'; /bin/bash" &&
	tmux new-window           -n tsplay      "cd '${PATH_LIBVA}/src'   ; ssh -t vagrant 'cd ${PATH_REMOTE_LIBVA}/src && /bin/zsh -i'; /bin/bash" &&
	tmux new-window           -n tsplay      "cd '${PATH_LIBVA}/src'   ; ssh -t vagrant 'cd ${PATH_REMOTE_LIBVA}/src && /bin/zsh -i'; /bin/bash" &&
	tmux new-window           -n rust        "cd '${PATH_LIBVA}/app-1' ; ssh -t vagrant 'cd ${PATH_REMOTE_LIBVA}/app-1 && /bin/zsh -i'; /bin/bash" &&
	tmux a
}
alias cd-libva="cd ${PATH_LIBVA}"

function tmux-dev-sandbox {
    tmux new-session -s sandbox -n sandbox -d "cd '${PATH_SANDBOX}'; /bin/bash" &&
	tmux a
}
alias cd-sandbox="cd ${PATH_SANDBOX}"

PATH_GITHUB_COM="${PATH_PROJECTS}/github.com"
PATH_VIDEO_AUDIO="${PATH_GITHUB_COM}/video-audio"

alias cd-github-com="cd ${PATH_GITHUB_COM}"
alias cd-video-audio="cd ${PATH_VIDEO_AUDIO}"

PATH_VA_TS="${PATH_VIDEO_AUDIO}/va-ts"
function tmux-dev-va-ts {
	tmux new-session -s va-ts -n va-ts -d "cd '${PATH_VA_TS}'; /bin/bash" &&
	tmux new-window           -n run      "cd '${PATH_VA_TS}'; /bin/bash" &&
	tmux a
}
alias cd-va-ts="cd ${PATH_VA_TS}"

PATH_VA_TOOL="${PATH_VIDEO_AUDIO}/va-tool"
function tmux-dev-va-tool {
	tmux new-session -s va-tool -n va-tool -d "cd '${PATH_VA_TOOL}'; /bin/bash" &&
	tmux new-window             -n run        "cd '${PATH_VA_TOOL}'; /bin/bash" &&
	tmux a
}
alias cd-va-tool="cd ${PATH_VA_TOOL}"

PATH_TRANSCODER="${PATH_GL_CE_INT}/transcoder"
PATH_TRANSCODER_HTTP_API="${PATH_TRANSCODER}/http-api"
PATH_TRANSCODER_UI="${PATH_TRANSCODER}/ui"
PATH_TRANSCODER_CTL_2="${PATH_TRANSCODER}/ctl"
PATH_TRANSCODER_CORE="${PATH_TRANSCODER}/bbl-streamer/bbl-streamer"
PATH_TRANSCODER_CTL_DEB="${PATH_TRANSCODER}/ctl-deb"
PATH_TRANSCODER_HTTP_API_DEB="${PATH_TRANSCODER}/http-api-deb"
PATH_TRANSCODER_UI_DEB="${PATH_TRANSCODER}/ui-deb"
PATH_TRANSCODER_TEST="${PATH_TRANSCODER}/test"
PATH_TRANSCODER_DOCS="${PATH_TRANSCODER}/docs"
PATH_REMOTE_TRANSCODER="${PATH_REMOTE_GL_BRADBURYLAB_TV}/transcoder"
PATH_F451="${PATH_GL_CE_INT}/f451"
function tmux-dev-transcoder {
	local path_remote_ctl="${PATH_REMOTE_GL_CE_INT}/transcoder/ctl"

	tmux new-session -s transcoder -n 'http-api-rsync' -d "cd '${PATH_TRANSCODER_HTTP_API}' && /bin/bash" &&
	tmux new-window                -n 'http-api'          "cd '${PATH_TRANSCODER_HTTP_API}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n 'ctl-rsync'         "cd '${PATH_TRANSCODER_CTL_2}/src' && /bin/bash" &&
	tmux new-window                -n ctl                 "cd '${PATH_TRANSCODER_CTL_2}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n 'rsync-core'        "cd '${PATH_TRANSCODER_CORE}'  && /bin/bash" &&
	tmux new-window                -n core                "cd '${PATH_TRANSCODER_CORE}'  && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n core                "cd '${PATH_TRANSCODER_CORE}'  && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	# tmux new-window                -n f451-rsync      "cd '${PATH_F451}/f451' && /bin/bash" &&
	# tmux new-window                -n f451-make       "cd '${PATH_F451}/f451' && ssh -p 2222 bl-dev-gpu2-trans01.int && /bin/bash" &&
	# tmux new-window                -n f451-server     "cd '${PATH_F451}/f451' && ssh -p 2222 bl-dev-gpu2-trans01.int && /bin/bash" &&
	tmux a
}

function tmux-dev-transcoder-failover {
	local path_remote_ctl="${PATH_REMOTE_GL_CE_INT}/transcoder/ctl"

	tmux new-session -s transcoder-failover -n 'http-api-rsync' -d "cd '${PATH_TRANSCODER_HTTP_API}' && /bin/bash" &&
	tmux new-window                -n 'http-api-01'       "cd '${PATH_TRANSCODER_HTTP_API}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n 'http-api-02'       "cd '${PATH_TRANSCODER_HTTP_API}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n 'http-api-03'       "cd '${PATH_TRANSCODER_HTTP_API}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n 'ctl-rsync'         "cd '${PATH_TRANSCODER_CTL_2}/src' && /bin/bash" &&
	tmux new-window                -n 'ctl-01'            "cd '${PATH_TRANSCODER_CTL_2}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n 'ctl-02'            "cd '${PATH_TRANSCODER_CTL_2}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n 'ctl-03'            "cd '${PATH_TRANSCODER_CTL_2}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}

function tmux-dev-transcoder-sentinel {
	tmux new-session -s transcoder-sentinel -n 'rsync' -d "cd '${PATH_TRANSCODER_CTL_2}/src' && /bin/bash" &&
	tmux new-window                -n 'build'             "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n '01'                "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n '02'                "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                -n '03'                "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}

function tmux-dev-transcoder-api {
	tmux new-session -s transcoder-api -n 'rsync' -d "cd '${PATH_TRANSCODER_CTL_2}/src' && /bin/bash" &&
	tmux new-window                    -n 'build'    "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                    -n '01'       "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                    -n '02'       "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                    -n '03'       "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}

function tmux-dev-transcoder-ctl {
	tmux new-session -s transcoder-ctl -n 'rsync' -d "cd '${PATH_TRANSCODER_CTL_2}/src' && /bin/bash" &&
	tmux new-window                    -n 'build'    "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                    -n '01'       "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                    -n '02'       "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                    -n '03'       "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}

function tmux-dev-transcoder-dash-cenc {
	tmux new-session -s transcoder-dash-cenc -n 'rsync'        -d "cd '${PATH_TRANSCODER_CTL_2}/src' && /bin/bash" &&
	tmux new-window                          -n 'wv-client'       "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                          -n 'wv-drm-proxy'    "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                          -n 'MP4Box'          "cd '${PATH_TRANSCODER_CTL_2}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}

function tmux-dev-transcoder-ui {
	tmux new-session -s transcoder-ui -n 'rsync'  -d "cd '${PATH_TRANSCODER_UI}' && /bin/bash" &&
	tmux new-window                   -n 'grunt'     "cd '${PATH_TRANSCODER_UI}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                   -n 'conect'    "cd '${PATH_TRANSCODER_UI}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}

function tmux-dev-transcoder-docs {
	tmux new-session -s transcoder-docs -n 'emacs'  -d "cd '${PATH_TRANSCODER_DOCS}' && /bin/bash" &&
	tmux new-window                                    "cd '${PATH_TRANSCODER_DOCS}' && /bin/bash" &&
	tmux new-window                                    "cd '${PATH_TRANSCODER_DOCS}' && /bin/bash" &&
	tmux a
}

alias cd-bbl-transcoder-http-api="cd ${PATH_TRANSCODER_HTTP_API}"
alias cd-transcoder-http-api="cd ${PATH_TRANSCODER_HTTP_API}"
alias cd-bbl-transcoder-ui="cd ${PATH_TRANSCODER_UI}"
alias cd-transcoder-ui="cd ${PATH_TRANSCODER_UI}"
alias cd-bbl-transcoder-ctl-2="cd ${PATH_TRANSCODER_CTL_2}"
alias cd-bbl-transcoder-ctl="cd ${PATH_TRANSCODER_CTL_2}"
alias cd-transcoder-ctl="cd ${PATH_TRANSCODER_CTL_2}"
alias cd-bbl-transcoder-goctl="cd ${PATH_TRANSCODER_CTL_2}"
alias cd-bbl-transcoder-bbl-streamer="cd ${PATH_TRANSCODER_CORE}"
alias cd-bbl-transcoder-core="cd ${PATH_TRANSCODER_CORE}"
alias cd-transcoder-core="cd ${PATH_TRANSCODER_CORE}"
alias cd-bbl-transcoder-http-api-deb="cd ${PATH_TRANSCODER_HTTP_API_DEB}"
alias cd-transcoder-http-api-deb="cd ${PATH_TRANSCODER_HTTP_API_DEB}"
alias cd-bbl-transcoder-ui-deb="cd ${PATH_TRANSCODER_UI_DEB}"
alias cd-transcoder-ui-deb="cd ${PATH_TRANSCODER_UI_DEB}"
alias cd-bbl-transcoder-ctl-deb="cd ${PATH_TRANSCODER_CTL_DEB}"
alias cd-transcoder-ctl-deb="cd ${PATH_TRANSCODER_CTL_DEB}"
alias cd-transcoder-test="cd ${PATH_TRANSCODER_TEST}"
alias cd-transcoder-docs="cd ${PATH_TRANSCODER_DOCS}"

PATH_ENC="${PATH_GL_CE_INT}/enc"
PATH_ENC_CORE="${PATH_ENC}/bblvod"
PATH_ENC_CORE_DEB="${PATH_ENC}/bblvod-deb"
PATH_ENC_WORKER="${PATH_ENC}/worker"
PATH_ENC_WORKER_DEB="${PATH_ENC}/worker-deb"
PATH_ENC_POLLER="${PATH_ENC}/poller"
PATH_ENC_UI="${PATH_ENC}/ui"
PATH_ENC_UI_DEB="${PATH_ENC}/ui-deb"
PATH_ENC_UI_OLD="${PATH_ENC}/ui-old"
PATH_ENC_UI_OLD_DEB="${PATH_ENC}/ui-old-deb"
function tmux-dev-enc {
	tmux new-session -s enc -n 'poller-rsync'  -d "cd '${PATH_ENC_POLLER}/src' && /bin/bash" &&
	tmux new-window         -n 'build'            "cd '${PATH_ENC_POLLER}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window         -n 'poller'           "cd '${PATH_ENC_POLLER}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window         -n 'worker'           "cd '${PATH_ENC_WORKER}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window         -n 'worker'           "cd '${PATH_ENC_WORKER}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window         -n 'core-rsync'       "cd '${PATH_ENC_CORE_DEB}'   && /bin/bash" &&
	tmux new-window         -n 'core'             "cd '${PATH_ENC_CORE_DEB}'   && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window         -n 'ui-old'           "cd '${PATH_ENC_UI_OLD}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window         -n 'ui-old-deb'       "cd '${PATH_ENC_UI_OLD_DEB}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}
function tmux-dev-enc-mts-24 {
	tmux new-session -s "enc-mts-24" -n 'poller-rsync'  -d "cd '${PATH_ENC_POLLER}/src' && /bin/bash" &&
	tmux new-window                  -n 'poller'           "cd '${PATH_ENC_POLLER}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                  -n 'mts-tasks-queue'  "cd '${PATH_ENC_POLLER}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                  -n 'worker-rsync'     "cd '${PATH_ENC_WORKER}'     && /bin/bash" &&
	tmux new-window                  -n 'worker'           "cd '${PATH_ENC_WORKER}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                  -n 'core-rsync'       "cd '${PATH_ENC_CORE_DEB}'   && /bin/bash" &&
	tmux new-window                  -n 'core'             "cd '${PATH_ENC_CORE_DEB}'   && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}
alias cd-enc-core="cd ${PATH_ENC_CORE}"
alias cd-enc-core-deb="cd ${PATH_ENC_CORE_DEB}"
alias cd-enc-worker="cd ${PATH_ENC_WORKER}"
alias cd-enc-worker-deb="cd ${PATH_ENC_WORKER_DEB}"
alias cd-enc-poller="cd ${PATH_ENC_POLLER}"
alias cd-enc-ui="cd ${PATH_ENC_UI}"
alias cd-enc-ui-deb="cd ${PATH_ENC_UI_DEB}"
alias cd-enc-ui-old="cd ${PATH_ENC_UI_OLD}"
alias cd-enc-ui-old-deb="cd ${PATH_ENC_UI_OLD_DEB}"

function tmux-dev-f451 {
	tmux new-session -s f451 -n rsync    -d "cd '${PATH_F451}/f451/src' && /bin/bash" &&
	tmux new-window          -n make        "cd '${PATH_F451}/f451/src' && /bin/bash" &&
	tmux new-window          -n server      "cd '${PATH_F451}/f451/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}
alias cd-bbl-f451="cd ${PATH_F451}/f451/src"
alias cd-f451="cd ${PATH_F451}/f451/src"
function env-f451 {
	export GOPATH=${PATH_F451}/f451/env/gopath:${PATH_F451}/f451/src/vendor;
	export GOROOT=${PATH_F451}/f451/env/go;
	export PATH=${GOROOT}/bin:${PATH};
}

PATH_CAS="${PATH_GL_CE_INT}/cas/cas"
function tmux-dev-cas {
	tmux new-session -s cas -n rsync    -d "cd '${PATH_CAS}/src' && /bin/bash" &&
	tmux new-window         -n build       "cd '${PATH_CAS}/src' && /bin/bash" &&
	tmux new-window         -n cas-01      "cd '${PATH_CAS}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window         -n cas-02      "cd '${PATH_CAS}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window         -n cas-03      "cd '${PATH_CAS}/src' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}
alias cd-bbl-cas="cd ${PATH_CAS}/src"
alias cd-cas="cd ${PATH_CAS}/src"
function env-cas {
	export GOPATH=${PATH_CAS}/env/gopath:${PATH_CAS}/src/vendor;
	export GOROOT=${PATH_CAS}/env/go;
	export PATH=${GOROOT}/bin:${PATH};
}

PATH_VANGA="${PATH_GL_BRADBURYLAB_TV}/vanga/vanga"
PATH_VANGA_DEB="${PATH_GL_BRADBURYLAB_TV}/vanga/vanga-deb"
PATH_VANGA_GO_DEB="${PATH_GL_BRADBURYLAB_TV}/vanga/vanga-go-deb"
function tmux-dev-vanga {
	tmux new-session -s vanga -n 'vanga-rsync'   -d "cd '${PATH_VANGA}' && /bin/bash" &&
	tmux new-window           -n 'vanga'            "cd '${PATH_VANGA}' && ssh -p 2222 bl-dev-gpu2-trans01.int" &&
	tmux a
}
alias cd-bbl-vanga="cd ${PATH_VANGA}"
alias cd-bbl-vanga-deb="cd ${PATH_VANGA_DEB}"
alias cd-bbl-vanga-go-deb="cd ${PATH_VANGA_GO_DEB}"

PATH_SMPP_PROXY="${PATH_GL_CE_INT}/tele2/smpp-proxy"
PATH_REMOTE_TELE2="${PATH_REMOTE_GL_CE_INT}/tele2"
function tmux-dev-smpp-proxy() {
	local path_remote_smmp_proxy="${PATH_REMOTE_TELE2}/smpp-proxy"
	tmux new-session -s smpp-proxy  -n 'build/server' -d "cd '${PATH_SMPP_PROXY}' && ssh -t vagrant 'cd ${path_remote_smmp_proxy}/src && /bin/zsh -i'; /bin/bash" &&
	tmux new-window                 -n "master-01"       "cd '${PATH_SMPP_PROXY}' && ssh -t vagrant 'cd ${path_remote_smpp_proxy}/src && /bin/zsh -i'; /bin/bash" &&
	tmux new-window                 -n "master-02"       "cd '${PATH_SMPP_PROXY}' && ssh -t vagrant 'cd ${path_remote_smpp_proxy}/src && /bin/zsh -i'; /bin/bash" &&
	tmux new-window                 -n "db"              "cd '${PATH_SMPP_PROXY}' && ssh -t vagrant 'cd ${path_remote_smpp_proxy}/src && /bin/zsh -i'; /bin/bash" &&
	tmux a
}
alias cd-smpp-proxy="cd ${PATH_SMPP_PROXY}"
alias cd-tele2-smpp-proxy="cd ${PATH_SMPP_PROXY}"

PATH_MTS="${PATH_GL_CE_INT}/mts"
PATH_CDN_API="${PATH_MTS}/cdn-api"
PATH_CDN_API_BIN_DEB="${PATH_MTS}/cdn-api-bin-deb"
PATH_CDN_API_MIGRATE="${PATH_MTS}/cdn-api-migrate"
PATH_CDN_API_LDAP="${PATH_MTS}/cdn-api-ldap"
PATH_CDN_ADMIN="${PATH_MTS}/cdn-admin"
PATH_CDN_ADMIN_BIN_DEB="${PATH_MTS}/cdn-admin-bin-deb"
PATH_CDN_SUPERVISOR="${PATH_MTS}/cdn-supervisor"
PATH_CDN_SUPERVISOR_BIN_DEB="${PATH_MTS}/cdn-supervisor-bin-deb"
PATH_CDN_REDIRECTOR="${PATH_MTS}/cdn-redirector"
PATH_CDN_UI="${PATH_MTS}/cdn-ui"
PATH_CDN="${PATH_MTS}/cdn"
PATH_CDN_LOG_PARSER="${PATH_MTS}/cdn-log-parser"
PATH_REMOTE_MTS="${PATH_REMOTE_GL_CE_INT}/mts"
function tmux-dev-cdn-fe {
	tmux new-session -s cdn-fe -n "api-rsync"     -d "cd '${PATH_CDN_API}' && /bin/bash" &&
	tmux new-window            -n "api"              "cd '${PATH_CDN_API}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window            -n "ui-rsync"         "cd '${PATH_CDN_UI}/src'  && /bin/bash" &&
	tmux new-window            -n "ui-build-fe"      "cd '${PATH_CDN_UI}'  && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window            -n "ui-build"         "cd '${PATH_CDN_UI}'  && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window            -n "admin-rsync"      "cd '${PATH_CDN_ADMIN}' && /bin/bash" &&
	tmux new-window            -n "admin"            "cd '${PATH_CDN_ADMIN}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window            -n "admin-fe"         "cd '${PATH_CDN_ADMIN}' && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}
function tmux-dev-cdn-be {
	tmux new-session -s cdn-be -n "cdn-rsync"        -d "cd '${PATH_CDN}/src' && /bin/bash" &&
	tmux new-window            -n "cdn-build"           "cd '${PATH_CDN}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window            -n "torrent-tracker"     "cd '${PATH_CDN}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window            -n "origin-vod"          "cd '${PATH_CDN}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window            -n "torrent-client"      "cd '${PATH_CDN}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window            -n "torrent-client"      "cd '${PATH_CDN}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window            -n "torrent-client"      "cd '${PATH_CDN}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window            -n "torrent-client"      "cd '${PATH_CDN}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}
function tmux-dev-cdn-log-parser {
	tmux new-session -s cdn-log-parser -n "rsync" -d "cd '${PATH_CDN}/src' && /bin/bash" &&
	tmux new-window                    -n "build"    "cd '${PATH_CDN}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                    -n "run"      "cd '${PATH_CDN}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux new-window                    -n "stbs"     "cd '${PATH_CDN}'     && ssh -p 2222 bl-dev-gpu2-trans01.int; /bin/bash" &&
	tmux a
}
alias cd-cdn-api="cd ${PATH_CDN_API}"
alias cd-cdn-api-bin-deb="cd ${PATH_CDN_API_BIN_DEB}"
alias cd-cdn-api-migrate="cd ${PATH_CDN_API_MIGRATE}"
alias cd-cdn-api-ldap="cd ${PATH_CDN_API_LDAP}"
alias cd-cdn-admin="cd ${PATH_CDN_ADMIN}"
alias cd-cdn-admin-bin-deb="cd ${PATH_CDN_ADMIN_BIN_DEB}"
alias cd-cdn-ui="cd ${PATH_CDN_UI}"
alias cd-supervisor="cd ${PATH_CDN_SUPERVISOR}"
alias cd-supervisor-bin-deb="cd ${PATH_CDN_SUPERVISOR_BIN_DEB}"
alias cd-supervisor-bin-deb="cd ${PATH_CDN_SUPERVISOR_BIN_DEB}"
alias cd-cdn="cd ${PATH_CDN}"
alias cd-cdn-redirector="cd ${PATH_CDN_REDIRECTOR}"
alias cd-cdn-log-parser="cd ${PATH_CDN_LOG_PARSER}"

PATH_MTS_F451_SEGMENTER="${PATH_MTS}/f451-segmenter"
PATH_MTS_F451_SAVER="${PATH_MTS}/f451-catchupsaver"
PATH_MTS_F451_ROUTER="${PATH_MTS}/f451-router"
PATH_MTS_F451_CTL="${PATH_MTS}/f451-ctl"
PATH_MTS_F451_CLI="${PATH_MTS}/f451-cli"
PATH_MTS_F451_CLEANER="${PATH_MTS}/f451-cleaner"
function tmux-dev-mts-f451 {
	tmux new-session -s mts-f451 -n "segmenter-rsync" -d "cd '${PATH_MTS_F451_SEGMENTER}/src'; /bin/bash" &&
	tmux new-window              -n "segmenter-build"    "cd '${PATH_MTS_F451_SEGMENTER}/src'; /bin/bash" &&
	tmux new-window              -n "tsplay"             "cd '${PATH_MTS_F451_SEGMENTER}/src'; /bin/bash" &&
	tmux new-window              -n "segmenter-run"      "cd '${PATH_MTS_F451_SEGMENTER}/src'; /bin/bash" &&
	tmux new-window              -n "saver-build"        "cd '${PATH_MTS_F451_SAVER}/src'; /bin/bash" &&
	tmux new-window              -n "saver-run"          "cd '${PATH_MTS_F451_SAVER}/src'; /bin/bash" &&
	tmux new-window              -n "router-build"       "cd '${PATH_MTS_F451_ROUTER}/src'; /bin/bash" &&
	tmux new-window              -n "router-run"         "cd '${PATH_MTS_F451_ROUTER}/src'; /bin/bash" &&
	tmux new-window              -n "curl"               "cd '${PATH_MTS_F451_ROUTER}/src'; /bin/bash" &&
	tmux a
}
alias cd-mts-f451-segmenter="cd ${PATH_MTS_F451_SEGMENTER}"
alias cd-mts-f451-saver="cd ${PATH_MTS_F451_SAVER}"
alias cd-mts-f451-router="cd ${PATH_MTS_F451_ROUTER}"
alias cd-mts-f451-ctl="cd ${PATH_MTS_F451_CTL}"
alias cd-mts-f451-cli="cd ${PATH_MTS_F451_CLI}"
alias cd-mts-f451-cleaner="cd ${PATH_MTS_F451_CLEANER}"

PATH_SOCKET_SERVER="${PATH_GL_CE_INT}/tele2/socket-server"
function tmux-dev-socket-server() {
	tmux new-session -s socket-server -n "build/rsync" -d "cd '${PATH_SOCKET_SERVER}/src'; /bin/bash" &&
	tmux new-window                   -n "curl"           "cd '${PATH_SOCKET_SERVER}/src'; /bin/bash" &&
	tmux a
}
alias cd-socket-server="cd ${PATH_SOCKET_SERVER}"

DEBEMAIL="vany.egorov@gmail.com"
DEBFULLNAME="Ivan Egorov"

VIMRUNTIME=/usr/bin
EDITOR=/usr/bin/vim

source $HOME/.cargo/env
export RUST_SRC_PATH=~/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

[[ -s "/home/egorov/.gvm/scripts/gvm" ]] && source "/home/egorov/.gvm/scripts/gvm"
gvm use go1.13

# export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
# n 6.9.5

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# rvm use default
