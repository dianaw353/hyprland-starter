#!/bin/bash
figlet "GPU Drivers"
source ./library.sh
echo "What GPU drivers would you like to install?"
## Function to select GPU drivers for multiple brands
selectGPUDrivers() {
    options=("amd" "intel" "nvidia")
    selected_brands=$(gum choose --no-limit "${options[@]}")
    echo "$selected_brands"
}

_installPackagesPacman() {
  local packages=$1
  echo "Installing packages: $packages"
  sudo pacman -S --needed --noconfirm "$packages"
}

installGPUDrivers() {
  local selected_brands=$1
  for selected_brand in $selected_brands; do
    local file_path="${selected_brand}.txt"
    echo "Resolved file path: $(readlink -f "$file_path")"

    if [ -f "${selected_brand}.txt" ]; then
      echo "File ${selected_brand}.txt exists. Installing GPU drivers for $selected_brand..."
      if _installPackagesPacman "$(cat "$file_path")"; then
        echo "GPU drivers for $selected_brand installed successfully"
        if [ "$selected_brand" == "nvidia" ]; then
          echo "Setting environment variables for NVIDIA drivers..."
          cat > ~/starter-dotfile/hypr/conf/environment.conf << EOF
source = ~/starter-dotfile/hypr/conf/environments/nvidia.conf
EOF
        fi
      else
        echo "ERROR: Failed to install GPU drivers for $selected_brand"
      fi
    else
      echo "File ${selected_brand}.txt does not exist. Skipping GPU drivers for $selected_brand..."
    fi
  done
}

## Function to install wine if the user chooses to install it
installWine() {
    question="Do you want to install wine? It's a compatibility layer for running Windows applications on Linux."
    if gum confirm "$question"; then
        echo "Installing wine..."
        options=("amd" "intel" "nvidia")
        selected_brands=$(gum choose --no-limit "${options[@]}")
        for selected_brand in $selected_brands; do
            local file_path="32bit${selected_brand}.txt"
            echo "Resolved file path: $(readlink -f "$file_path")"

            if [ -f "32bit${selected_brand}.txt" ]; then
                echo "File 32bit${selected_brand}.txt exists. Installing 32bit GPU drivers for $selected_brand..."
                if _installPackagesPacman "$(cat "$file_path")"; then
                  echo "32bit GPU drivers for $selected_brand installed successfully"
                else
                  echo "ERROR: Failed to install 32bit GPU drivers for $selected_brand"
                fi
            else
                echo "File 32bit${selected_brand}.txt does not exist. Skipping 32bit GPU drivers for $selected_brand..."
            fi
        done
    else
        echo "Skipping wine installation."
    fi
}

## Example usage:
selected_brands=$(selectGPUDrivers)
installGPUDrivers "$selected_brands"
installWine
