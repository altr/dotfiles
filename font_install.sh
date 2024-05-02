#!/bin/bash

# install nerd font system wide

apt-install -y --no-install-recommends curl unzip

zip_file="DejaVuSansMono.zip"
font_dir="/usr/local/share/fonts"; mkdir -p "$font_dir"

if ls $font_dir/DejaVuSans* &> /dev/null; then
	echo "DejaVuFont already exists"
else
	curl -fLo DejaVuSansMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$zip_file"
	unzip -q "$zip_file" -d "$font_dir" || { echo "Error: Unable to extract '$selected_font'."; return 1; }
	rm "$zip_file"
	if command -v fc-cache &> /dev/null; then
		fc-cache -f > /dev/null || { echo "Error: Unable to update font cache. Exiting."; exit 1; }
		echo "Font cache updated."
	else
		apt-get update
		apt install fontconfig
		fc-cache -f > /dev/null || { echo "Error: Unable to update font cache. Exiting."; exit 1; }
	fi
fi
