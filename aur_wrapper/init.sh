figlet "Package Manager"

_choose_package_manager() {
  echo "Note: A AUR package manager is a utility that helps you install third party packages easily without any hassle."
  echo "Its recommended to use the *-bin version of the package as its already precompiled."
  echo "If you like to run the greatest and latest software choose the *-git of the package but be aware that there may be some issues."
  echo "Please choose your preferred AUR package manager:"
  package_managers=("yay" "yay-bin" "yay-git" "aura" "aura-bin" "aura-git" "paru" "paru-bin" "paru-git")
  package_manager=$(gum choose "${package_managers[@]}")
  if [[ -n $package_manager ]]; then
    echo "You have selected $package_manager."
    if ! command -v $package_manager &> /dev/null; then
      echo "$package_manager is not installed. Cloning and installing from the AUR..."
      cd ~/
      git clone https://aur.archlinux.org/$package_manager.git
      cd $package_manager
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
