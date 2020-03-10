#!/bin/bash

# 
# SYNOPSIS:
#	A setup script for personal Debian working
#	environment. Aim is to setup the barebones
#	binaries and libraries needed to work.
#
# USAGE:
#	cd /path/to/config
#	chmod +x bin/setup.sh
#	sudo bin/setup.sh
#
# DESCRIPTION:
#	The script is meant to be re-runnable time 
#	and time again without causing issues. It
#	should also never store any sensitive config
#	files or information such as, SSH keypair,
#	WireGuard configs, GPG keys etc.
# 

# Update repositories (assuming source.list is valid/updated)
sudo apt update && apt upgrade -y

# Install essentially packages
sudo apt install git -y

# Install dependencies for flamegraph
sudo apt install -y linux-tools-common linux-tools-generic software-properties-common

PKG_OK=$(dpkg-query -W --showformat='${Status}\n' rustup|grep "install ok installed")
echo "Checking for rustup: ${PKG_OK}"
if [ "" == "$PKG_OK" ]; then
  echo "No rustup. Setting up rustup."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

  # Need to add Cargo to the PATH environment variable in order
  # to be able to add rustup in the namespace
  PATH=$PATH:~/.cargo/bin

  # Setup nightly toolchain & install important Cargo components
  rustup toolchain add nightly

  cargo install flamegraph # Dependencies already install above 
  
  cargo +nightly install racer  
  rustup component add rust-src


  rustup component add rls-preview rust-analysis rust-src
fi

PKG_OK=$(dpkg-query -W --showformat='${Status}\n' alacritty|grep "install ok installed")
echo "Checking for alacritty: ${PKG_OK}"
if [ "" == "$PKG_OK" ]; then
  echo "No alacritty. Setting up alacritty."

  # Install alacritty terminal manager (https://github.com/alacritty/alacritty)
  sudo add-apt-repository "deb http://ppa.launchpad.net/mmstick76/alacritty/ubuntu bionic main"
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5B7FC40A404FAD98548806028AC9B4BBBAB4900B
  sudo apt update && apt install alacritty -y

  # Setup config file symlink for alacritty
  mkdir -p ~/.config/alacritty
  cp ../shell/alacritty.yaml ~/.config/alacritty/alacritty.yaml
fi


PKG_OK=$(dpkg-query -W --showformat='${Status}\n' fish|grep "install ok installed")
echo "Checking for fish: ${PKG_OK}"
if [ "" == "$PKG_OK" ]; then
  echo "No fish. Setting up fish."

  echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' > /etc/apt/sources.list.d/shells:fish:release:3.list
  wget -nv https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key -O Release.key
  sudo apt-key add - < Release.key
  sudo apt-get update && apt-get install -y fish
fi


PKG_OK=$(dpkg-query -W --showformat='${Status}\n' nvim|grep "install ok installed")
echo "Checking for neovim: ${PKG_OK}"
if [ "" == "$PKG_OK" ]; then
  echo "No neovim. Setting up neovim."

  sudo apt install -y neovim 

  # Setup Vim-Plug manager for NeoVim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  mkdir -p ~/.config/nvim/
  cp shell/.vimrc ~/.config/nvim/init.vim
  cp shell/.vimrc ~/.vimrc

  # Need to install nodejs (ugh) in order to get vim-coc working nicely
  echo "Setting up nodejs as a pre-requisite for vim-coc plugin..."
  sudo apt install -y nodejs

  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update && sudo apt install yarn

  nvim +PlugInstall +PlugClean +PlugUpdate +UpdateRemotePlugins +qall
fi

# Download and Install Firefox Developer edition
#pushd ~/Downloads
#curl -fLo firefox-developer.tar.bz2 --create-dirs \
#	https://download-installer.cdn.mozilla.net/pub/firefox/nightly/latest-mozilla-central/firefox-75.0a1.en-US.linux-x86_64.tar.bz2
#tar -xvf firefox-developer.tar.bz2
#
#firefox_dir=$(which firefox)
#mv $firefox_dir "${firefox_dir}.backup"
#mv firefox /opt/
#ln -s /opt/firefox/firefox $firefox_dir
#
#echo "[!] Currently not sure where to place your userChrome.css file..."
#echo "    You may need to add it under ~/.mozilla/firefox/* and create "
#echo "    a chrome/ directory to copy to"
#popd

# Setup fish config
cp shell/config.fish ~/.config/fish/config.fish
