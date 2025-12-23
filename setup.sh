#!/bin/bash
if ! command -v nvim >/dev/null 2>&1
then
	echo "Installing neovim..."

	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim-linux-x86_64
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	echo "export PATH=\"$PATH:/opt/nvim-linux-x86_64/bin\"" >> ~/.profile
	rm nvim-linux-x86_64.tar.gz
fi

sudo apt-get update && sudo apt-get install -y stow
stow .

npm install -g tree-sitter-cli
dotnet tool install -g EasyDotnet

