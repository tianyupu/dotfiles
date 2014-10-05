#!/usr/bin/env sh

# Script to set up dependencies for dotfiles.

# Download packages
sudo apt-get update
sudo apt-get install -y \
  redshift \
  xmonad xmobar suckless-tools \
  vim \
  thunar xscreensaver scrot feh amixer xbacklight
