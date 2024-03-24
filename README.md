<div align="center">
<h1>Hyprland Starter</h1>
</div>

## What is this project
This project is made for those that want to simplify the installation process for people who do not want to go through the whole process of setting evrything up

## ✨ Featues WIP
- Installs GPU drivers
  - 32 bit drivers
  - wine installation
- Autostart hyprland
- Installation profiles
- Desktop/Laptop profiles
- Installation of dotfiles
- Backups dotfiles
- Enable bluetooth support
- Device patches (framework laptops only atm)
- VM Support
- Discover Packages
- And much more

## Images comming soon

## Supported platforms

- Arch Linux

This script is made spacifically for Arch Linux but should work on any Arch based distro


## Installation

```
  # 1. ) Clone the dotfiles inside ~/Downloads folder
  git clone https://github.com/dianaw353/hyprland-starter.git ~/Downloads/hyprland-starter --depth=1

  # 2. ) cd into the hyprland starter
  cd ~/Downloads/hyprland-starter

  # 3. ) start the installation
  ./install.sh
```

## Update with GIT

```
# 1.) Change into your Downloads folder
cd ~/Downloads/hyprland-starter

# Switch to rolling release
# git checkout origin/main

# 2.) Pull the latest version and update the repository
git stash; git pull

# 3.) Start the installation to update
./install.sh

```

## Nvidia users

Users that use hyprland has reported that they have been able use hyprland successfully on setups with NVIDIA GPU's.

As Hyprland dose not offically support nvidia devices I will try to make it earier to set up hyprland on nvidia GPU's but I cant garentee that everything will work as I do not own one of their devices. For more support please visit the following link: https://wiki.hyprland.org/Nvidia/


## Some important key bindings
Comming soon

# Troubleshooting

## Missing icons in waybar

In case of missing icons on waybar, it's due to a conflict between several installed fonts (can happen especially on Arco Linux). Please make sure that ttf-ms-fonts is uninstalled and ttf-font-awesome and otf-font-awesome are installed with

```
paru -R ttf-ms-fonts
paru -S ttf-font-awesome otf-font-awesome
```


## Waybar is not loading

There could be a conflict with xdg-desktop-portal-gtk. Please try to remove the package if installed with:

```
sudo pacman -R xdg-desktop-portal-gtk
```

## Insperation

Stephan Raabe: https://gitlab.com/stephan-raabe/dotfiles
