#!/bin/bash

echo "Welcome to the hyprland starter script."
echo "Script made by Diana"
echo "This script is made to guide you though the process of installing Hyprland and theming."

source ./library.sh
echo "Updating packages mirror list so we can get the latest and greatest packages."
read -p "Press enter to continue the script and install script dependencies."
source ./script_dependencies/init.sh
_PackagesMirrorListSyncPacman
source ./aur_wrapper/init.sh
source ./general_packages/init.sh
source ./backup_dotfiles/init.sh
source ./cleanup/init.sh
source ./workarounds/init.sh

figlet "Done"
echo "Please restart your system!"
