_PackagesMirrorListSyncPacman() {
  echo "Syncing packages..."
  sudo pacman -Sy --noconfirm
  echo "Checking for available package updates..."
  num_updates=$(pacman -Qu | wc -l)
  if [ "$num_updates" -gt "0" ]; then
    echo "$num_updates packages have updates available."
    _UpdateSystemPackages
  else
    echo "No package updates available."
  fi
}

_UpdateSystemPackages() {
  if ! gum confirm "Do you want to update system packages now?"; then
    echo "Skipping package update."
  else
    echo "Updating packages..."
    sudo pacman -Syu --noconfirm
  fi
}

_installPackagesPacman() {
  local filePath="$1"
  if [ ! -f "$filePath" ]; then
    echo "File not found: $(readlink -f "$filePath")"
    return 1
  fi
  while read -r pkg; do
    echo "Installing $pkg"
    if sudo pacman -S --noconfirm "$pkg"; then
      echo "Successfully installed package $pkg"
    else
      echo "Failed to install package $pkg"
      return 1
    fi
  done < "$filePath"
}

_packagesCheckIfInstalled() {
  local file_path=$1

  if [ -z "$file_path" ] || [ ! -f "$file_path" ]; then
    echo "Please provide a valid file path."
    return 1
  fi

  while IFS= read -r pkg; do
    if pacman -Qs "$pkg" > /dev/null; then
      echo "The package $pkg is already installed."
    else
      if ! _installPackagesPacman "$pkg"; then
        return 1
      fi
    fi
  done < "$file_path"
  echo "Success: All packages installed correctly"
  return 0
}

_detectPackageManager() {
  local package_managers=("yay" "yay-bin" "yay-git" "aura" "aura-bin" "aura-git" "paru" "paru-bin" "paru-git")
  for package_manager in "${package_managers[@]}"; do
    if command -v $package_manager &> /dev/null; then
      echo "$package_manager"
      return 0
    fi
  done
  echo "None of the specified package managers are installed."
  return 1
}

_installPackageAur() {
  local package=$1
  local package_manager=$(_detectPackageManager)

  if [[ -n $package_manager ]]; then
    echo "Installing $package using $package_manager..."
    case $package_manager in
      yay|yay-bin|yay-git)
        if ! yay -S --noconfirm $package; then
          echo "Failed to install $package using $package_manager."
          return 1
        fi
        ;;
      aura|aura-bin|aura-git)
        if ! sudo aura -A --noconfirm $package; then
          echo "Failed to install $package using $package_manager."
          return 1
        fi
        ;;
      paru|paru-bin|paru-git)
        if ! paru -S --noconfirm $package; then
          echo "Failed to install $package using $package_manager."
          return 1
        fi
        ;;
    esac
    echo "$package installed successfully."
  else
    echo "No valid package manager found. Please install 'yay', 'yay-bin', 'yay-git', 'aura', 'aura-bin', 'aura-git', 'paru', 'paru-bin', or 'paru-git'."
    return 1
  fi
}
