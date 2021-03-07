# remove annoying message:
# default interactive shell is now zsh
export BASH_SILENCE_DEPRECATION_WARNING=1

export GOPATH="$HOME/code/gopath"

export PATH="$PATH:$HOME/code/gopath/bin"

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8


alias ll='exa -abghl'
alias la='ls -A'
alias l='exa'
alias cat='bat'


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


parse_git_dirty () {
  [[ $(git status 2> /dev/null | tail -1) != "nothing to commit, working tree clean" ]] && echo "*"
}

parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

show_git_prompt () {
  git branch 2>/dev/null 1>&2 && echo -e "-($(parse_git_branch))"
}

if [[ -n $(type -t git) ]] ; then
  PS1="\$(show_git_prompt)"
else
  PS1=
fi

PS1="\[\e[31;1m\]┌───=(\[\033[38;5;113m\]\u\[\e[31;1m\] :: \[\e[33;1m\]\h\[\e[31;1m\])-[\[\033[38;5;39m\]\w\[\e[31;1m\]]$PS1
\[\e[31;1m\]└──( \[\e[0m\]"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
