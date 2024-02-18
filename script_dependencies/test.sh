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
  local file_path=$1
  local package_manager=$(_detectPackageManager)

  if [[ -n $package_manager ]]; then
    while IFS= read -r pkg; do
      if pacman -Qs "$pkg" > /dev/null; then
        echo "The package $pkg is already installed."
      else
        echo "Installing $pkg using $package_manager..."
        commands=()
        case $package_manager in
          yay|yay-bin|yay-git)
            commands+=(yay -S --noconfirm "$pkg")
            ;;
          aura|aura-bin|aura-git)
            commands+=(sudo aura -A --noconfirm "$pkg")
            ;;
          paru|paru-bin|paru-git)
            commands+=(paru -S --noconfirm "$pkg")
            ;;
        esac
        echo "Commands to be executed: ${commands[@]}"
        if ! "${commands[@]}"; then
          echo "Failed to install $pkg using $package_manager."
          return 1
        fi
        echo "$pkg installed successfully."
      fi
    done < "$file_path"
  else
    echo "No valid package manager found. Please install 'yay', 'yay-bin', 'yay-git', 'aura', 'aura-bin', 'aura-git', 'paru', 'paru-bin', or 'paru-git'."
    return 1
  fi
}

_installPackageAur "packages.txt"
