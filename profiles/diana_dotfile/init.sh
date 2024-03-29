#!/bin/bash

# Diana Starter Dotfiles
source ./../../library.sh

read -p "Press enter to continue install the dotfiles."

echo "Downloading dotfiles"
cd ~/
git clone --depth=1 https://github.com/dianaw353/starter-dotfile.git
cd ~/starter-dotfile

echo "Installing dotfiles dependencies"
_installPackageAur "profiles/diana_dotfiles/packages.txt"

echo "Installing dotfiles"
if [ -d ~/dotfiles-versions/$version/alacritty ]; then
    _installSymLink alacritty ~/.config/alacritty ~/dotfiles/alacritty/ ~/.config
fi

if [ -d ~/dotfiles-versions/$version/hypr ]; then
    _installSymLink hypr ~/.config/hypr ~/dotfiles/hypr/ ~/.config
fi

if [ -d ~/dotfiles-versions/$version/wlogout ]; then
    _installSymLink wlogout ~/.config/wlogout ~/dotfiles/wlogout/ ~/.config
fi

if [ -d ~/dotfiles-versions/$version/dunst ]; then
    _installSymLink dunst ~/.config/dunst ~/dotfiles/dunst/ ~/.config
fi

cd ~/hyprland-starter
# echo "Downloading wallpaper"
# echo "Installing wallpaper"
# echo "Setting up greetd"
# echo "Switching shell to zsh"
