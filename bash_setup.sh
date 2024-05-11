#!/bin/bash

# setup bash
if ! command -v starship &> /dev/null;then
	echo "install starship"
	cmd=$(curl -sS https://starship.rs/install.sh | sh -s -- -f)
fi

# ensure the right aliases are added to bashrc
if ! grep 'eval "$(starship init bash)"' ~/.bashrc &> /dev/null;then
	echo "setup .bashrc"
cat <<EOF>> ~/.bashrc 
alias ll='ls -alF'
alias la='ls -lA'
alias l='ls -lCF'
alias lt='ls -lrt'

alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# GIT
alias gp='git pull'
alias gs='git status'
alias ga='git add'

# NPM
alias dev='npm run dev -- --host'

# encryption & decryption
enc() {
    openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 1000000 -salt -in "$1" -out "$1.enc"
}
dec() {
    file=`echo "$1"`
    file_no_extension=`echo ${file%.*}`
    openssl enc -d -aes-256-cbc -md sha512 -salt -pbkdf2 -iter 1000000 -in "$file" -out "$file_no_extension"
}

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~
EOF

echo 'eval "$(starship init bash)"' >> ~/.bashrc

echo "please run"
echo "source ~/.bashrc"

fi
