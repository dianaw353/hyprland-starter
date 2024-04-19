_PackagesMirrorListSyncPacman() {
  gum log --structured --level debug "Syncing packages..."
  sudo pacman -Sy --noconfirm
  gum log --structured --level debug "Checking for available package updates..."
  num_updates=$(pacman -Qu | wc -l)
  if [ "$num_updates" -gt "0" ]; then
    gum log --structured --level debug "$num_updates packages have updates available."
    _UpdateSystemPackages
  else
    gum log --structured --level debug "No package updates available."
  fi
}

_UpdateSystemPackages() {
  if ! gum confirm "Do you want to update system packages now?"; then
    gum log --structured --level debug "Skipping package update."
  else
    gum log --structured --level debug "Updating packages..."
    sudo pacman -Syu --noconfirm
  fi
}

_installPackagesPacman() {
  local filePath="$1"
  if [ ! -f "$filePath" ]; then
    gum log --structured --level error "File not found: $(readlink -f "$filePath")"
    return 1
  fi

  while IFS= read -r pkg; do
    if pacman -Qs "$pkg" > /dev/null; then
      gum log --structured --level debug "The package $pkg is already installed."
    else
      echo "Installing $pkg"
      if sudo pacman -S --noconfirm "$pkg"; then
        gum log --structured --level debug "Successfully installed package $pkg"
      else
        gum log --structured --level error "Failed to install package $pkg"
        return 1
      fi
    fi
  done < "$filePath"

  if [ $? -eq 0 ]; then
    gum log --structured --level debug "Success: All packages installed correctly"
  else
    gum log --structured --level error "Failed to install one or more packages"
  fi
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
  local package_file=$1
  local package_manager=$(_detectPackageManager)

  if [[ -n $package_manager ]]; then
    while IFS= read -r package; do
      gum log --structured --level debug "Checking if $package is already installed..."
      if ! pacman -Q $package >/dev/null 2>&1; then
        gum log --structured --level debug "Installing $package using $package_manager..."
        case $package_manager in
          yay|yay-bin|yay-git)
            if ! yay -S --noconfirm $package; then
              gum log --structured --level error "Failed to install $package using $package_manager."
              return 1
            fi
            ;;
          aura|aura-bin|aura-git)
            if ! sudo aura -A --noconfirm $package; then
              gum log --structured --level error "Failed to install $package using $package_manager."
              return 1
            fi
            ;;
          paru|paru-bin|paru-git)
            if ! paru -S --noconfirm $package; then
              gum log --structured --level error "Failed to install $package using $package_manager."
              return 1
            fi
            ;;
        esac
        gum log --structured --level debug "$package installed successfully."
      else
        gum log --structured --level debug "$package is already installed. Skipping..."
      fi
    done < "$package_file"
  else
    gum log --structured --level error "No valid package manager found. Please install 'yay', 'yay-bin', 'yay-git', 'aura', 'aura-bin', 'aura-git', 'paru', 'paru-bin', or 'paru-git'."
    return 1
  fi
}

_cleanUpAurWrapperCache() {
  local package_manager=$(_detectPackageManager)

  if [[ -n $package_manager ]]; then
    gum log --structured --level debug "Cleaning up $package_manager cache..."
    case $package_manager in
      yay|yay-bin|yay-git)
        if ! yay -Scc --noconfirm; then
          gum log --structured --level error "Failed to clean up $package_manager cache."
          return 1
        fi
        ;;
      aura|aura-bin|aura-git)
        if ! sudo aura -Scc --noconfirm; then
          gum log --structured --level error "Failed to clean up $package_manager cache."
          return 1
        fi
        ;;
      paru|paru-bin|paru-git)
        if ! paru -Scc --noconfirm; then
          gum log --structured --level error "Failed to clean up $package_manager cache."
          return 1
        fi
        ;;
    esac
    gum log --structured --level debug "pacman/$package_manager cache cleaned up successfully."
  else
    gum log --structured --level error "No valid package manager found. Please install 'yay', 'yay-bin', 'yay-git', 'aura', 'aura-bin', 'aura-git', 'paru', 'paru-bin', or 'paru-git'."
    return 1
  fi
}

_installSymLink() {
    name="$1"
    symlink="$2";
    linksource="$3";
    linktarget="$4";
    
    if [ -L "${symlink}" ]; then
        rm ${symlink}
        ln -s ${linksource} ${linktarget} 
        echo ":: Symlink ${linksource} -> ${linktarget} created."
    else
        if [ -d ${symlink} ]; then
            rm -rf ${symlink}/ 
            ln -s ${linksource} ${linktarget}
            echo ":: Symlink for directory ${linksource} -> ${linktarget} created."
        else
            if [ -f ${symlink} ]; then
                rm ${symlink} 
                ln -s ${linksource} ${linktarget} 
                echo ":: Symlink to file ${linksource} -> ${linktarget} created."
            else
                ln -s ${linksource} ${linktarget} 
                echo ":: New symlink ${linksource} -> ${linktarget} created."
            fi
        fi
    fi
}
