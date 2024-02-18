figlet "Package Manager"

_choose_package_manager() {
  echo "Note: A AUR package manager is a utility that helps you install third party packages easily without any hassle."
  echo "Please choose your preferred AUR package manager:"
  package_manager=$(echo -e "yay\naura\nparu" | gum choose)
  if [[ -n $package_manager ]]; then
    echo "You have selected $package_manager."
    if ! command -v $package_manager &> /dev/null; then
      echo "$package_manager is not installed. Cloning and installing from the AUR..."
      cd ~/
      git clone https://aur.archlinux.org/$package_manager-bin.git
      cd $package_manager-bin
      makepkg -si
      cd ~/hyprland-starter
    else
      echo "$package_manager is already installed. Skipping installation."
    fi
  else
    echo "Invalid selection. Please try again."
  fi
}

_choose_package_manager
