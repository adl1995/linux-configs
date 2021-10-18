#
# ~/.bash_profile
#

# Means bash will store an unlimited number of lines.
export HISTSIZE=-1

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"
