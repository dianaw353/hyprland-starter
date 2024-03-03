#!/bin/bash

echo "Welcome to the hyprland starter script."
echo "Script made by Diana"
echo "This script is made to guide you though the process of installing Hyprland and theming."

source ./library.sh
#source ./confirm_start.sh
read -p "Press enter to continue the script and install script dependencies."
source ./script_dependencies/init.sh
echo "Updating packages mirror list so we can get the latest and greatest packages."
_PackagesMirrorListSyncPacman
source ./aur_wrapper/init.sh
source ./general_packages/init.sh
source ./backup_dotfiles/init.sh
source ./gpu_drivers/init.sh
source ./hyprland_dependencies/init.sh
#source ./profiles/init.sh # rice and dotfiles dependencies:
source ./systemd_enable/init.sh
#source ./display_manager/init.sh
#source ./shell_type/init.sh
#source ./import_dotfiles/init.sh #symLinks
#source ./import_wallpapers/init.sh
if gum confirm --affirmative="Laptop" --negative="Desktop" "Are you using a laptop or desktop?"; then
    # Run other files if the user is using a laptop
    echo "Running additional scripts to make this laptop usage."
    source ./workarounds/init.sh
else
    echo "Running additional scripts for desktop usage."
fi
source ./vm_support/init.sh
source ./cleanup/init.sh
figlet "Done"
echo "Please restart your system for everything to take effect!"
