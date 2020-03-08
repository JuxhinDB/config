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

PKG_OK=$(dpkg-query -W --showformat='${Status}\n' rustup|grep "install ok installed")
echo "Checking for rustup: ${PKG_OK}"
if [ "" == "$PKG_OK" ]; then
  echo "No rustup. Setting up rustup."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

  # Need to add Cargo to the PATH environment variable in order
  # to be able to add rustup in the namespace
  PATH=$PATH:~/.cargo/bin
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


PKG_OK=$(dpkg-query -W --showformat='${Status}\n' foo|grep "install ok installed")
echo "Checking for neovim: ${PKG_OK}"
if [ "" == "$PKG_OK" ]; then
  echo "No neovim. Setting up neovim."

  sudo apt install -y neovim 

  # Setup Vim-Plug manager for NeoVim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  mkdir -p ~/.config/nvim/
  cp shell/.vimrc ~/.config/nvim/init.vim
  nvim +PlugInstall +PlugClean +PlugUpdate +UpdateRemotePlugins
fi

