
export PATH="$PATH:$HOME/.npm/bin"
export PATH="$PATH:$HOME/downloads/software"

#source ~/.bashrc
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias subl=subl3
PS1='[\u@\h \W]\$ '

# Install Ruby Gems to ~/gems
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH
PATH=~/.gem/ruby/2.7.0/bin:$PATH
PATH=/home/adeel/work/gsoc/2018/Boost/boost:$PATH
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add /home/adeel/.ssh/id_rsa_github
fi

# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

alias ls='ls -l --color'
alias l='ls -l --color'
alias display-external-single='xrandr --output DP1-8 --mode 2560x1440 --rotate normal; xrandr --output eDP1 --off'
alias display-external-extend='xrandr --output eDP1 --mode 2560x1440; xrandr --output DP1-8 --mode 2560x1440 --rotate normal --left-of eDP1'
alias display-external-off='xrandr --output DP1-8 --off; xrandr --output eDP1 --mode 2560x1440'

export LD_LIBRARY_PATH="/var/lib/docker/overlay2/4b70c36960b8fdad8d9e2ff2f44b89ba4328c97c16afaa643dc554326d784794/diff/usr/local/cuda/lib64/stubs;/var/lib/docker/overlay2/c965271440d7b4dad73c245693076356c697d05fd4a7e4d91e6a11ed929be2dd/diff/usr/local/cuda-10.0/lib64/stubs/libcuda.so"

