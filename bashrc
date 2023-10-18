# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# os
OS=`uname`

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color | xterm-color256 | xterm) color_prompt=yes;;
#esac
color_prompt=yes

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

        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ ot\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local ansi=42
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local ansi=43
        else
            local ansi=41
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
            test "$branch" != master || branch=' '
        else
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi
        echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch${COLOR_NONE} "
    fi
}

# Adds the "virtual env" to the prompt if we want it
function _virtual_env_prompt() {
    if [[ -e $VIRTUAL_ENV && -z $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
        echo "($LIGHT_GRAY${VIRTUAL_ENV##*/}$COLOR_NONE)"
    fi
}

#export PROMPT_COLOR="\[\033[$(($RANDOM % 2));$((31 + ($RANDOM % 7)))m\]"

function _prompt_command() {
    # prompt="${YELLOW}\u${COLOR_NONE}@${GREEN}\h${COLOR_NONE}:${PROMPT_COLOR}\w${COLOR_NONE}"
    prompt="${YELLOW}\u${COLOR_NONE}@${GREEN}\h${COLOR_NONE}:${BLUE}\w\n${BLUE}>:${COLOR_NONE}"
    PS1="`_virtual_env_prompt``_git_prompt`$prompt "
}
PROMPT_COMMAND=_prompt_command

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

command_exists () {
    type "$1" &> /dev/null ;
}

export PATH="/usr/local/bin:$PATH"

# add homebrew coreutils to path
GNUBIN="/usr/local/opt/coreutils/libexec/gnubin"
if [ -d "$GNUBIN" ]; then
    export PATH="$GNUBIN:$PATH"
fi

# enable color support of ls and also add handy aliases
if [[ $OS == "Darwin" && ! -d "$GNUBIN" ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

alias grep='grep --color=auto --exclude=*~'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias grepy='grep -r --include=*.py'
alias tmux='tmux -2'

if command_exists dircolors; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
eval `dircolors ~/.dircolors`
fi

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# for mac this is where that is (at least using brew)
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

if command_exists fasd; then
    eval "$(fasd --init auto)"
    alias v='f -e vim'
    alias o='a -e open'
fi

# customizations
if [ -f "$HOME/.bash_custom" ] ; then
    source "$HOME/.bash_custom"
fi

if [ -f $HOME/.profile ]; then
    source $HOME/.profile
fi

if [ "$TERM" == "xterm" ]; then
   export TERM=xterm-256color
fi
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

export VISUAL=vim
export EDITOR=vim

# Predictable SSH authentication socket location.
SOCK="/tmp/ssh-agent-$USER-screen"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

export GPG_TTY=$(tty)

# vim mode for command line
set -o vi
