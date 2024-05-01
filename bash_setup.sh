#!/bin/bash

if ! command -v starship &> /dev/null;then

cmd=$(curl -sS https://starship.rs/install.sh | sh -s -- -f)

cat <<EOF>> ~/.bashrc 
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -lt'

alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~
EOF

echo 'eval "$(starship init bash)"' >> ~/.bahsrc

fi

source ~/.bashrc
