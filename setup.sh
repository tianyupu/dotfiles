#!/usr/bin/env sh

# Script to set up dependencies for dotfiles.

# Download packages
sudo apt-get update
sudo apt-get install -y \
  redshift \
  xmonad xmobar suckless-tools \
  vim git tmux \
  thunar xscreensaver scrot feh amixer xbacklight

# Remove gnome-screensaver if installed
if [ -e /usr/bin/gnome-screensaver ]; then
  sudo apt-get remove -y gnome-screensaver
fi
