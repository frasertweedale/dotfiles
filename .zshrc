# .zshrc - zsh configuration

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export BLOCKSIZE='K'
export LANG='en_AU.UTF-8'

PATH=~/.local/bin:$PATH

# set up EDITOR envvar and alias
if which vim &>/dev/null
then
	export EDITOR='vim'
	alias vi='vim'
else
	export EDITOR='vi'
fi

# other aliases
alias l.='ls -d .*'
alias ll='ls -lA'
alias ll.='ls -ld .*'
alias lock='lock -np'
alias tmux='tmux -u'
which ack-grep &>/dev/null && alias ack=ack-grep

# set up PAGER envvar and alias
if which less &>/dev/null
then
	export PAGER='less'
	if echo $(uname -a) | grep -q GNU
	then
		# make GNU less behave like BSD more
		alias more='less -EXm'
	fi	# in BSD-land, LESS_IS_MORE.  See less(1)
else
	# less is missing
	export PAGER='more'
fi

# ls colouring magic
if echo $(uname -a) | grep -q GNU
then
	# GNU ls colour bullshit
	export LS_COLORS='di=1;36:ln=0;36:so=1;35:pi=0;33:ex=1;32:su=1;33:sg=1;33:tw=1;34:ow=1;34'
	alias ls='ls --color=auto'
else
	# colour config for sane ls
	export LSCOLORS='GxgxFxdxCxDxDxhbadExEx'
	export CLICOLOR='YES'
	alias ls='ls -G'
fi

# gpg env
#  nowadays, thanks to --use-standard-socket, GnuPG doesn't need any of
#  these, but mutt expects both GPG_TTY and GPG_AGENT_INFO to exist.
export GPG_TTY=$(tty)
export GPG_AGENT_INFO=  # empty so gpg will fall back to standard socket

# ssh env
[ -f $HOME/.ssh-agent-info ] && . $HOME/.ssh-agent-info >/dev/null

# general config
prompt="[%m:%3~] %n%# "
setopt autolist

if [ "$(whoami)" != "root" ]
then
	# development
	export VIRTUALENV_USE_DISTRIBUTE=1
	export VIRTUALENVWRAPPER_VIRTUALENV_ARGS="--never-download"
	which virtualenvwrapper.sh &>/dev/null && . virtualenvwrapper.sh
fi

# functions
function cdsw {
	[ -z "$1" ] && echo "phail!" && return 1
	TWD=$(echo $PWD | sed s:$1:$2:)
	if [ $TWD != $PWD ]; then cd $TWD;
	else echo "$0: no substitution performed" && return 1; fi
}
function do_cdrc {
	if [ -x ./.cdrc -a "$LAST_CDRC" != "$PWD" -a "$(tty)" != "not a tty" ]
	then
		echo "Executing .cdrc in $PWD:" >&2
		if [ -x "$(which nl)" ]
		then
			cat ./.cdrc | nl -w8 >&2
		else
			cat -n ./.cdrc
		fi
		read -q line\?"orly? " && source ./.cdrc >&2 && LAST_CDRC=$PWD
	fi
}
function cd {
	if [ -z "$1" ] ; then builtin cd ; else builtin cd "$*" ; fi
	[ $? -eq 0 ] || return $?
	do_cdrc
	return 0
}
function du {
	if echo $(uname -a) | grep -q GNU
	then
		command du $(echo $* | sed -r "s,((-[[:alpha:]0]+)|-)d[[:space:]]*([[:digit:]]+),\2 --max-depth=\3,")
	else
		command du $*
	fi
}
for COMMAND in shutdown poweroff reboot halt fastboot fasthalt
do
	function $COMMAND {
		if [ -n "$SSH_CONNECTION" ]
		then
			echo "SSH_CONNECTION=$SSH_CONNECTION"
			read -q "LINE?Are you sure you wish to $0 $*?" || return
		fi
		command $0 $*
	}
done

# create a tmux session in PWD, w/ session name = basename
#  (if tmux is installed)
function tmuxme {
	if [ -f "$(/usr/bin/which tmux 2>/dev/null)" ]
	then
		TMUX= tmux new -s $(basename $PWD) -d || echo "failed!" && return 1
		echo "created new tmux session $(basename $PWD)"
	else
		echo "tmux is not installed!" && return 1
	fi
}

bindkey -v

bindkey "^J" history-beginning-search-forward
bindkey "^K" history-beginning-search-backward
bindkey "^L" end-of-line

fpath=(~/.zshfunctions $fpath)

# rvm info
function rvm_info {
	rvm_info_msg=""
	if which rvm-prompt &>/dev/null
	then
		OUTPUT="$(rvm-prompt)"
		[ -n "$OUTPUT" ] && rvm_info_msg="(%F{3}$OUTPUT%f) "
	fi
}

# VCS info

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable bzr cvs git hg svn

zstyle ':vcs_info:*' stagedstr '%F{2}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{3}●%f'
zstyle ':vcs_info:*' formats '[ %F{2}%b%f%c%u ] '
zstyle ':vcs_info:*' actionformats '%[%F{2}%b|%a%f] '

zstyle ':vcs_info:*' check-for-changes true

zstyle ':vcs_info:bzr:*' use-simple true
zstyle ':vcs_info:bzr:*' branchformat "%b"

precmd () {
	vcs_info
	rvm_info
}
setopt prompt_subst
prompt='[%m:%3~] ${rvm_info_msg}${vcs_info_msg_0_}%n%# '


zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' completions 3
zstyle ':completion:*' format 'COMPLETING(%d)>'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' prompt 'FIXME(%e)>'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
