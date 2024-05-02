#!/bin/bash

# install nerd font system wide

zip_file="DejaVuSansMono.zip"
font_dir="/usr/local/share/fonts"; mkdir -p "$font_dir"

if ls $font_dir/DejaVuSans* &> /dev/null; then
	echo "DejaVuFont already exists"
else
	curl -fLo DejaVuSansMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$zip_file"
	sudo unzip -q "$zip_file" -d "$font_dir" || { echo "Error: Unable to extract '$selected_font'."; return 1; }
	rm "$zip_file"
	if command -v fc-cache &> /dev/null; then
		fc-cache -f > /dev/null || { echo "Error: Unable to update font cache. Exiting."; exit 1; }
		echo "Font cache updated."
	else
		sudo apt-get update
		sudo apt install fontconfig
		fc-cache -f > /dev/null || { echo "Error: Unable to update font cache. Exiting."; exit 1; }
	fi
fi

if ! command -v starship &> /dev/null;then
	echo "install starship"
	cmd=$(curl -sS https://starship.rs/install.sh | sh -s -- -f)
fi

if ! command -v lt &> /dev/null;then
	echo "setup .bashrc"
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

echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

source ~/.bashrc
