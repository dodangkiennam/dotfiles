#!/bin/bash
sudo apt update && sudo apt install -y stow

stow .

# check if nodejs is installed
if type node > /dev/null 2>&1 && which node > /dev/null 2>&1 ;then
    node -v
    echo "node is installed, skipping..."
else
    echo "install node"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
	\. "$HOME/.nvm/nvm.sh"
	nvm install 24
	node -v # Should print "v24.12.0".
	npm -v # Should print "11.6.2".
fi

npm install -g tree-sitter-cli
dotnet tool install -g EasyDotnet

