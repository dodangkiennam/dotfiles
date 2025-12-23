#!/bin/bash
if ! command -v nvim >/dev/null 2>&1
then
	echo "Neovim not found. Installing Neovim..."

	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim-linux-x86_64
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	echo "export PATH=\"$PATH:/opt/nvim-linux-x86_64/bin\"" >> ~/.profile
	rm nvim-linux-x86_64.tar.gz
fi

if ! command -v lazygit >/dev/null 2>&1
then
	echo "Lazygit not found. Installing Lazygit..."

	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit -D -t /usr/local/bin/
	rm lazygit.tar.gz
	rm lazygit
fi

sudo apt update && sudo apt install -y stow
stow .

npm install -g tree-sitter-cli
dotnet tool install -g EasyDotnet

