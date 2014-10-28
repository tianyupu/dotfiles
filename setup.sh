#!/usr/bin/env sh

# Script to set up dependencies for dotfiles.

# Download packages
sudo apt-get update
sudo apt-get install -y \
  redshift \
  xmonad xmobar suckless-tools \
  git \
  thunar xscreensaver scrot feh amixer xbacklight \
  python python-pip \
  python-software-properties software-properties-common

# Install tmux 1.9a for ubuntu 12.04
sudo apt-add-repository -y ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install -y tmux=1.9a-1~ppa1~p # change the p for other ubuntu

# Download and install powerline, attempting to install fonts
pip install --user git+git://github.com/Lokaltog/powerline
git clone https://github.com/Lokaltog/powerline-fonts.git
cd powerline-fonts
source install.sh

# Remove gnome-screensaver if installed
if [ -e /usr/bin/gnome-screensaver ]; then
  sudo apt-get remove -y gnome-screensaver
fi
