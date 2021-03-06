#!/usr/bin/env bash
# Copy of https://raw.githubusercontent.com/mathiasbynens/dotfiles/master/bootstrap.sh

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".macos" \
		--exclude "LICENSE" \
		--exclude "README.md" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
		--exclude "neovim.sh" \
		--exclude "npm.sh" \
		--exclude "photo.png" \
		--exclude "update.sh" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
