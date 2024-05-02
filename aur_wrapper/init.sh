figlet "Package Manager"

_check_aur_package_installed() {
  pacman -Qq | grep -qw "$1"
}

_choose_package_manager() {
  echo "Note: A AUR package manager is a utility that helps you install third party packages easily without any hassle."
  echo "Its recommended to use the *-bin version of the package as its already precompiled."
  echo "If you like to run the greatest and latest software choose the *-git of the package but be aware that there may be some issues."
  echo "Please choose your preferred AUR package manager:"
  package_managers=("yay-bin" "yay-git" "aura-bin" "aura-git" "paru-bin" "paru-git")
  package_manager="${package_managers[0]}"
  if ! _check_aur_package_installed "$package_manager"; then
    package_manager=$(gum choose "${package_managers[@]}")
    if [[ -n $package_manager ]]; then
      echo "You have selected $package_manager."
      if ! _check_aur_package_installed "$package_manager"; then
        echo "$package_manager is not installed. Cloning and installing from the AUR..."
        cd ~/
        git clone "https://aur.archlinux.org/$package_manager.git"
        cd "$package_manager"
        makepkg -si
        cd ~/hyprland-starter
      else
        echo "$package_manager is already installed. Skipping AUR Wrapper installation."
      fi
    else
      echo "Invalid selection. Please try again."
    fi
  else
    echo "$package_manager is already installed. Skipping installation."
  fi
}

# List of packages to check
packages=("yay-bin" "yay-git" "aura-bin" "aura-git" "paru-bin" "paru-git")

# Check if the packages are already installed
for package in "${packages[@]}"; do
  if _check_aur_package_installed "$package"; then
    echo "$package is already installed. Skipping AUR Wrapper installation."
    package_manager="$package"
    break
  fi
done

# If no package is found, ask the user to choose one
if [[ -z "$package_manager" ]]; then
  _choose_package_manager
fi
